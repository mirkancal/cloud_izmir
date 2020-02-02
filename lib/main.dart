import 'package:cloud_izmir/models/user.dart';
import 'package:cloud_izmir/services/user_service.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final userService = UserService();
  Future<List<User>> userFuture;
  @override
  void initState() {
    userFuture = userService.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: userFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Hata oluştu");
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final currentUser = snapshot.data[index];
                  return ListTile(
                    title: Text(
                      currentUser.name,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    subtitle: Text(currentUser.email),
                  );
                  // return Text(currentUser.name);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
