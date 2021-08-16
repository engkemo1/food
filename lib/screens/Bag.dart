import 'package:flutter/material.dart';
import 'package:foood/models/products.dart';

class Bag extends StatefulWidget {

  final ProductModel pro;

  const Bag({required this.pro});

  @override
  _BagState createState() => _BagState();
}

class _BagState extends State<Bag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.pro.name!, style: TextStyle(color: Colors.black),),
        leading: IconButton(onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black,),),
        actions: [
          Padding(padding: EdgeInsets.only(top: 5, right: 3),
            child: Stack(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_bag_rounded,
                      size: 35,
                      color: Colors.black,
                    )),
                Positioned(
                    bottom: 4,
                    right: 0,
                    child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(1, 3),
                                  blurRadius: 2),
                            ],
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text("2"),
                        )))
              ],
            ),


          )
        ],

      ),
      body: ListView(
        children: [
          SizedBox(height: 15,),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.blue,
                      offset: Offset(1, 1), blurRadius: 3)
                ]
            ),
            child: Row(
              children: [
                Image.network(widget.pro.image!, width: 50, height: 50,),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.only(bottom: 3),
                        child: Text("${widget.pro.name}", style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),), ),
                    Text("\$${widget.pro.price}", style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),)
                  ],
                )


              ],
            ),

          )
        ],

      ),
    );
  }
}
