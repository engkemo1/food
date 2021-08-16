
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/helpers/Loading.dart';
import 'package:foood/helpers/navig.dart';
import 'package:foood/screens/Home_Screen.dart';
import 'package:provider/provider.dart';

import 'registration.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body:authProvider.status == Status.Authenticating? Loading() : ListView(
        children: [
          SizedBox(height: 40,),
    Container(

      child: 
      Center(
        child: Image.asset("images/hamburger.png",height: 150,width: 150,),
      )
      ,
    ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: Provider.of<UserProvider>(context).email,

                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                      icon: Icon(Icons.email)
                  ),
                ),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(padding: EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: Provider.of<UserProvider>(context).password,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      icon: Icon(Icons.lock)
                  ),
                ),),
            ),
          ),
          SizedBox(height: 5,),

          Padding(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: ()async{
                if(!await authProvider.signIn()){
                _key.currentState!.showSnackBar(
                SnackBar(content: Text("Login failed!"))
                );
                return;
                }
                authProvider.clearController();
                changeScreenReplacement(context, Home());

              }
               ,
              child: Container(

                decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text( "Login", style:TextStyle(color: Colors.white,fontSize: 22) )
                    ],
                  ),),
              ),
            ),
          ),
SizedBox(height: 5,),
          GestureDetector(
            onTap: (){
              changeScreen(context, Register());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
             Text( "Register here", style:TextStyle(fontSize: 20,color: Colors.grey) ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
