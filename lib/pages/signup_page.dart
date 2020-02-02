import 'package:cloud_izmir/pages/home_page.dart';
import 'package:cloud_izmir/pages/login_page.dart';
import 'package:cloud_izmir/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String email;
  String password;
  String verificationCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onSaved: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.mail),
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    onSaved: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password"),
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton.extended(
                    onPressed: () async {
                      _formKey.currentState.save();
                      print("Email: $email, Password: $password");
                      try {
                        final userId =
                            await authService.signUp(email, password);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                              height: 300,
                              child: Form(
                                key: _dialogFormKey,
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      onSaved: (val) {
                                        verificationCode = val;
                                      },
                                      decoration: InputDecoration(
                                          labelText: "Verify Code"),
                                    ),
                                    RaisedButton(
                                      child: Text("Verify"),
                                      onPressed: () async {
                                        _dialogFormKey.currentState.save();
                                        try {
                                          await authService.verifyUser(
                                              userId, verificationCode);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => LoginPage(),
                                            ),
                                          );
                                        } catch (e) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      } catch (e) {
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            content: Text("An error occurred"),
                          ),
                        );
                        print("failure");
                      }
                    },
                    icon: Icon(Icons.verified_user),
                    label: Text("Login"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
