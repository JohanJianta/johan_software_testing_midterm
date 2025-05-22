import 'package:flutter/material.dart';
import 'package:johan_software_testing_midterm/views/views.dart';
import 'package:provider/provider.dart';
import 'package:johan_software_testing_midterm/viewmodels/auth_view_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
    );
  }
}
