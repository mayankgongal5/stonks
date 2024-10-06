import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;

  const LoginScreen({Key? key, required this.onThemeToggle}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _supabaseClient = Supabase.instance.client;
  bool isDarkMode = false;

  void _logout() {
    // Implement your logout logic here
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(onThemeToggle: widget.onThemeToggle)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: const Text('Login'),
  actions: [
    IconButton(
      icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
      onPressed: () {
        setState(() {
          isDarkMode = !isDarkMode;
        });
        widget.onThemeToggle(isDarkMode);
      },
    ),
  ],
),
body: Center(
  child: SizedBox(
    width: 300, // Adjust width as needed
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/icon/icon.png', // Replace with your image asset path
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'io.mydomain.myapp://callback',
          onSignInComplete: (response) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(onThemeToggle: widget.onThemeToggle)),
            );
          },
          onSignUpComplete: (response) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(onThemeToggle: widget.onThemeToggle)),
            );
          },
          metadataFields: [
            MetaDataField(
              prefixIcon: const Icon(Icons.person),
              label: 'Username',
              key: 'username',
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
          ],
        ),
      ],
    ),
  ),
),
    );
  }
}