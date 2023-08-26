import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() {
    // Perform sign-up logic here
    String email = _emailController.text;
    String password = _passwordController.text;

    // TODO: Implement your sign-up validation and navigation logic
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/logo.png',
            height: 140,),
          const SizedBox(height: 16.0),
          const Text("Create new Account", style: TextStyle(fontSize: 20),),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(
              labelText: 'Confirm Password',
            ),
            obscureText: true,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: _signUp,
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: 16.0),
          TextButton(
              onPressed: (){
                context.go("/");
              },
              child: const Text("Already have an account? Sign in")),
        ],
      ),
    );
  }
}
