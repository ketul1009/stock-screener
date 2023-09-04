import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:jumping_dot/jumping_dot.dart';
import 'package:stock_market_filter/Common/ErrorBox.dart';
import 'package:stock_market_filter/Common/Toast.dart';

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
  bool _loggedIn = false;
  Widget libChild = const Text("Log In");
  Widget errorBox = Container();

  void _login() async {
    setState(() {
      libChild = JumpingDots(
        color: Colors.white,
        radius: 5,
        numberOfDots: 3,
      );
    });
    String email = _emailController.text;
    String password = _passwordController.text;

    final url = Uri.parse("https://0uzp72ur4a.execute-api.ap-south-1.amazonaws.com/dev/stockscreener/login");
    var res = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({'userId': email, 'password': password}),
    );

    debugPrint(res.body);
    if(res.body.toString() == "true"){
      setState(() {
        _loggedIn=true;
        libChild = const Text("Log In");
        context.go('/home');
      });
    }
    else{
      setState(() {
        errorBox = ErrorBox(error: "Some error occurred, StatusCode: ${res.statusCode.toString()}");
        libChild = const Text("Log In");
      });
    }
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
          errorBox,
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
            ),
            onTap: (){
              setState(() {
                errorBox=Container();
              });
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            onTap: (){
              setState(() {
                errorBox=Container();
              });
            },
          ),
          TextButton(
              onPressed: (){},
              child: const Text("Forgot password?")),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: (){
              if(_emailController.text.isEmpty){
                setState(() {
                  errorBox = ErrorBox(error: "Enter username");
                });
              }
              else if(_passwordController.text.isEmpty){
                setState(() {
                  errorBox = ErrorBox(error: "Enter Password");
                });
              }
              else{
                _login();
              }
            },
            child: libChild,
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
