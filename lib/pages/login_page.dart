import 'package:cloud_izmir/pages/home_page.dart';
import 'package:cloud_izmir/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                        await authService.login(email, password);
                        print("success");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(
                              title: "Home",
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
