import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Codeplayon Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyDashboard(),
    );
  }
}
class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}
class _MyDashboardState extends State<MyDashboard> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference Example"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              child: Center(
                child: Text(
                  'Hello ! $username',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              width: 250,
              child: RawMaterialButton(
                textStyle: TextStyle(color: Colors.white),
                fillColor: Colors.green[500],
                onPressed: () {
                  logindata.setBool('login', true);
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => MyLoginPage()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Logout",style: TextStyle(fontSize: 22),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}