import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/helpers/Loading.dart';
import 'package:foood/helpers/navig.dart';
import 'package:foood/screens/Home_Screen.dart';
import 'package:provider/provider.dart';

import 'Login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: authProvider.status == Status.Authenticating
          ? Loading()
          : ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Center(
                    child: Image.asset(
                      "images/hamburger.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: Provider.of<UserProvider>(context).name,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Username",
                            icon: Icon(Icons.person)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        controller: Provider.of<UserProvider>(context).email,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            icon: Icon(Icons.email)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        obscureText: false,
                        controller: Provider.of<UserProvider>(context).password,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                            icon: Icon(Icons.lock)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () async {
                      if (!await authProvider.signUp()) {
                        _key.currentState!.showSnackBar(
                            SnackBar(content: Text("Login failed")));
                        return;
                      }
                      authProvider.clearController();

                      changeScreenReplacement(context, Home());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Resgister",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    changeScreen(context, Login());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("login  here",
                          style: TextStyle(fontSize: 20, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
