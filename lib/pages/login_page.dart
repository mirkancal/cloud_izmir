import 'package:cloud_izmir/pages/home_page.dart';
import 'package:cloud_izmir/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                      "Welcome Back",
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
                        icon: Icon(Icons.lock_open),
                        label: Text("Login"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            try {
                              await authService.login(
                                  email: email, password: password);
                              print("Success");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
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
