part of 'views.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AuthViewModel authViewModel;

  void showSnackBar(BuildContext context, String message, Color? snackBarColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: snackBarColor,
        ),
      );
    });
  }

  Future<void> _validateAndSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      String username = _usernameController.text.trim();
      String password = _passwordController.text.trim();

      String? usernameError = authViewModel.validateUsername(username);
      if (usernameError != null) {
        return showSnackBar(context, usernameError, Colors.red);
      }

      String? passwordError = authViewModel.validatePassword(password);
      if (passwordError != null) {
        return showSnackBar(context, passwordError, Colors.red);
      }

      try {
        String message = await authViewModel.login(username, password);
        if (mounted) {
          showSnackBar(context, message, null);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomePage()),
            (route) => false,
          );
        }
      } catch (e) {
        if (mounted) showSnackBar(context, e.toString(), Colors.red);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    authViewModel = Provider.of<AuthViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: _buildFormContent(),
                  ),
                ),
                _buildLoadingOverlay(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    return Column(
      children: [
        const Text(
          'Login Page',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xFF031749),
          ),
        ),
        const SizedBox(height: 16),
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            cursorColor: const Color(0xFF082367),
            controller: _usernameController,
            decoration: _inputDecoration('Username'),
            keyboardType: TextInputType.name,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please insert your username' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            cursorColor: const Color(0xFF082367),
            controller: _passwordController,
            decoration: _inputDecoration('Password'),
            keyboardType: TextInputType.visiblePassword,
            validator: (value) =>
                value == null || value.isEmpty ? 'Please insert your password' : null,
          ),
          const SizedBox(height: 32),
          _buildButton(
            text: 'Login',
            backgroundColor: const Color(0xFF133569),
            textColor: Colors.white,
            onPressed: _validateAndSubmit,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: borderColor != null ? BorderSide(color: borderColor, width: 1.5) : BorderSide.none,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Color(0xFF082367)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF082367), width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF031749), width: 1.5),
      ),
      border: const OutlineInputBorder(),
    );
  }

  Widget _buildLoadingOverlay() {
    return Builder(builder: (_) {
      if (authViewModel.status == RequestStatus.loading) {
        return Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(color: Color(0xFF729762)),
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
