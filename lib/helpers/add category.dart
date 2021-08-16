import 'package:flutter/material.dart';

class Addcat extends StatelessWidget {
  const Addcat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      bottom: const TabBar(
        tabs: <Widget>[
          Tab(
            text: "Restaurants",
          ),
          Tab(
            text: "Product",
          ),
          Tab(
            text: "Category",
          ),
        ],
      ),
    ),body: TabBarView(
      children: <Widget>[
        Center(
          child: Text("It's cloudy here"),
        ),
        Center(
          child: Text("It's rainy here"),
        ),
        Center(
          child: Text("It's sunny here"),
        ),
      ],
    ),




    );
  }
}
