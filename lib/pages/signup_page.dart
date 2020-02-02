import 'package:cloud_izmir/pages/home_page.dart';
import 'package:cloud_izmir/pages/login_page.dart';
import 'package:cloud_izmir/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String email;
  String password;
  String verificationCode;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> _dialogFormKey = GlobalKey<FormState>();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Builder(
        builder: (context) => Center(
          child: Card(
            margin: EdgeInsets.all(8.0),
            color: Colors.lightGreen[100],
            child: Container(
              height: 350,
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.green[900],
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      onSaved: (val) {
                        email = val;
                      },
                      validator: (val) {
                        if (!val.contains("@")) {
                          return "Please enter valid email";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.mail),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      onSaved: (val) {
                        password = val;
                      },
                      validator: (val) {
                        if (val.length < 6) {
                          return "Password must be 6 character length";
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        icon: Icon(Icons.supervised_user_circle),
                        label: Text("Sign Up"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              final userId = await authService.signUp(
                                  email: email, password: password);

                              final result = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Container(
                                    height: 200,
                                    child: Form(
                                      key: _dialogFormKey,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Text(
                                            "Please enter verification code",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.green,
                                            ),
                                          ),
                                          TextFormField(
                                            onSaved: (val) {
                                              verificationCode = val;
                                            },
                                            decoration: InputDecoration(
                                                labelText: "Verification Code"),
                                          ),
                                          RaisedButton(
                                            child: Text("Verify"),
                                            onPressed: () async {
                                              _dialogFormKey.currentState
                                                  .save();
                                              try {
                                                await authService.verifyEmail(
                                                    userId: userId,
                                                    code: verificationCode);
                                                Navigator.pop(context, true);
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         HomePage(),
                                                //   ),
                                                // );
                                              } catch (e) {
                                                Navigator.pop(context, false);
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                              if (result) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              } else {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Incorrect code"),
                                  ),
                                );
                              }
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => LoginPage(),
                              //   ),
                              // );
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("an error occurred"),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
