import 'package:client/pages/home.dart';
import 'package:client/pages/sign_up.dart';
import 'package:client/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) async {
    try {
      final signedInUser = await signIn(
        emailController.text,
        passwordController.text,
      );
      print('Signed in user: $signedInUser');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e) {
      print('Failed to sign in user: $e');
      // Display an error message to the user if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          style: TextStyle(
            color: Colors.black, // Change app bar text color
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          children: [
            const SizedBox(height: 80.0),
            const Text(
              'Sign in ',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black), // Change text color
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: widget.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.black, // Change label text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change border color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change border color
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: widget.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.black, // Change label text color
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change border color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change border color
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.login(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 0, 0), // Change button background color
                  ),
                ),
                child: const Text('Sign In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)), // Change button text color
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?', style: TextStyle(color: Colors.black)), // Change text color
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ),
                    );
                  },
                  child: const Text('Sign Up', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))), // Change text color
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
