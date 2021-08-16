import 'package:flutter/material.dart';

class AddRes extends StatelessWidget {


GlobalKey<FormState> _form=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("You are Welcome\nRestaurant")],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.blue, offset: Offset(1, 2), blurRadius: 3)
              ]),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Form(key: _form,child:Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter your Restaurant Name",
                        labelText: "Name"
                      ),

                    ),
                    TextFormField( decoration: InputDecoration(
                        hintText: "Enter your Restaurant Image",
                        labelText: "Image"
                    ),),
                    TextFormField( decoration: InputDecoration(
                        hintText: "Enter your Restaurant Rate",
                        labelText: "Rate"
                    ),),


                  ],


                ) )
              ],
            ),
          )

        )
      ],
    );
  }
}
