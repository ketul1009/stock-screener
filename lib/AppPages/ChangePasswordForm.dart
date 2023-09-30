import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/ErrorBox.dart';
import '../Common/Toast.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Widget libChild = const Text("Save Password");
  Widget errorBox = Container();

  void _changePassword(String validate, String newPwd) async {
    SharedPreferences pref =await SharedPreferences.getInstance();
    String? userId = pref.getString("userId");
    String? oldPwd = pref.getString("password");
    if(oldPwd==validate){
      final url = Uri.parse("https://0uzp72ur4a.execute-api.ap-south-1.amazonaws.com/dev/stockscreener/changepwd");
      var res = await http.put(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: json.encode({'userId': userId, 'password': newPwd}),
      );
      pref.setString("password", newPwd);
      debugPrint(res.body.toString());
    }
    else{
      setState(() {
        errorBox = ErrorBox(error: "Old password not correct");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              errorBox,
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Old password',
                ),
                onTap: (){
                  setState(() {
                    errorBox=Container();
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
                obscureText: true,
                onTap: (){
                  setState(() {
                    errorBox=Container();
                  });
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                onTap: (){
                  setState(() {
                    errorBox=Container();
                  });
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: (){
                  if(_currentPasswordController.text.isEmpty){
                    setState(() {
                      errorBox = ErrorBox(error: "Enter Current Password");
                    });
                  }
                  else if(_newPasswordController.text.isEmpty){
                    setState(() {
                      errorBox = ErrorBox(error: "Enter New Password");
                    });
                  }
                  else if(_confirmPasswordController.text.isEmpty){
                    setState(() {
                      errorBox = ErrorBox(error: "Enter Correct Password");
                    });
                  }
                  else if(_newPasswordController.text==_currentPasswordController.text){
                    setState(() {
                      errorBox = ErrorBox(error: "New password cannot be same as old");
                    });
                  }
                  else if(_newPasswordController.text!=_confirmPasswordController.text){
                    setState(() {
                      errorBox = ErrorBox(error: "Password do not match");
                    });
                  }
                  else{
                    _changePassword(_currentPasswordController.text, _newPasswordController.text);
                    _currentPasswordController.clear();
                    _newPasswordController.clear();
                    _confirmPasswordController.clear();
                    ToastService.showToast(context, "Password changed");
                    context.go('/home');
                  }
                },
                child: libChild,
              ),
            ],
          ),
        ),
      )
    );
  }
}