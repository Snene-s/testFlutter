import 'package:flutter/material.dart';
import 'package:test_ilyes/services/auth.dart';
import 'package:test_ilyes/views/home.dart';
import 'package:test_ilyes/views/signin.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  AuthService authService = new AuthService();
  bool _isLoading = false;
  String email = "", password = "", name = "";

  signUp() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.signUpEmailAndPass(email, password).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Sign Up '),
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
                        return val!.isEmpty ? "name isEmpty" : null;
                      },
                      decoration: InputDecoration(hintText: "Name"),
                      onChanged: (val) {
                        name = val;
                      },
                    ),
                    SizedBox(
                      height: 6,
                    ),
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
                      decoration: InputDecoration(hintText: "password"),
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
                        signUp();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(24)),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 48,
                        child: Text(
                          "Sign up",
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
                                    builder: (context) => SignIn()));
                          },
                          child: Text(
                            "sign In",
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
    ;
  }
}
