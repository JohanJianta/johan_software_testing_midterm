part of 'views.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final customWidgetBuilder = CustomWidgetBuilder();

  late User? user;
  late AuthViewModel authViewModel;

  Future<void> _logoutUser() async {
    try {
      await authViewModel.initiateLogout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) customWidgetBuilder.showSnackBar(context, e.toString(), Colors.red);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authViewModel = Provider.of<AuthViewModel>(context);
    user = authViewModel.user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customWidgetBuilder.buildText(text: "ID: ${user?.id}"),
                customWidgetBuilder.buildText(text: "Username: ${user?.username}"),
                customWidgetBuilder.buildText(
                    text: "Full Name: ${user?.firstName} ${user?.lastName}"),
                customWidgetBuilder.buildText(text: "Gender: ${user?.gender}"),
                customWidgetBuilder.buildText(text: "Email: ${user?.email}"),
                const SizedBox(height: 32),
                customWidgetBuilder.buildButton(
                  text: 'Logout',
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: _logoutUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
