import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_ilyes/services/auth.dart';
import 'package:test_ilyes/views/signup.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  String email = "", password = "";
  bool _isLoading = false;
  signIn() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signInEmailAndPass(email, password).then((value) {
        setState(() {
          _isLoading=false;
        });
        if(value != null){

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Test Ilyess '),
      ),
      body: _isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Spacer(),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "email isEmpty" : null;
                      },
                      decoration: InputDecoration(hintText: "email"),
                      onChanged: (val) {
                        email = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val!.isEmpty ? "password isEmpty" : null;
                      },
                      decoration: InputDecoration(hintText: "Password"),
                      obscureText: true,
                      onChanged: (val) {
                        password = val;
                      },
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        signIn();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24)),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 48,
                        child: Text(
                          "Sign In",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "don't have an account? ",
                          style: TextStyle(fontSize: 17),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text(
                            "sign Up",
                            style: TextStyle(
                                fontSize: 17,
                                decoration: TextDecoration.underline),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
