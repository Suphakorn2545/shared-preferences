import 'package:flutter/material.dart';
import 'package:fluttersharedpreferences/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Shared Preferences',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyLoginPage(),
    );
  }
}
class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;
  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0,right: 20),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/flutter-logo.png')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 10,top: 60),
              child: TextField(
                controller: username_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  contentPadding: new EdgeInsets.all(20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
              child: TextField(
                controller: password_controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  contentPadding: new EdgeInsets.all(20.0),
                ),
                obscureText: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Container(
                height: 50,
                width: 200,
                child: RawMaterialButton(
                  textStyle: TextStyle(color: Colors.white),
                  fillColor: Colors.green,
                  onPressed: () {
                    String username = username_controller.text;
                    String password = password_controller.text;
                    if (username != '' && password != '') {
                      print('Successfull');
                      logindata.setBool('login', false);
                      logindata.setString('username', username);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyDashboard()));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Login",style: TextStyle(fontSize: 22),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}