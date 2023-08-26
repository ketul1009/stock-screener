import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Perform login logic here
    String email = _emailController.text;
    String password = _passwordController.text;

    debugPrint("Email: $email");
    debugPrint("password: $password");
    context.go("/home");
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
          const Text("Sign in to Stock Screener", style: TextStyle(fontSize: 20),),
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
          TextButton(
              onPressed: (){},
              child: const Text("Forgot password?")),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
          const SizedBox(height: 16.0),
          TextButton(
              onPressed: (){
                context.go("/signup");
              },
              child: const Text("Don't have an account? Create new")),
        ],
      ),
    );
  }
}
