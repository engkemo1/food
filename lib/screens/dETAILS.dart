import 'package:flutter/material.dart';
import 'package:foood/Providers/APP.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/helpers/Like%20Widget.dart';
import 'package:foood/helpers/Loading.dart';
import 'package:foood/helpers/navig.dart';
import 'package:foood/models/products.dart';
import 'package:foood/screens/Bag.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  final ProductModel product;

  const Details({required this.product});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int quantity = 1;
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppProvider>(context);

    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: SafeArea(
          child:  app.isLoading ? Loading() : Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue, offset: Offset(1, 1), blurRadius: 3)
                ]),
            child: Stack(
              children: [
                Center(
                  child: ClipRect(child: Image.network(widget.product.image!)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_rounded)),
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shopping_bag_rounded,
                              size: 30,
                              color: Colors.black,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                                width: 20,
                                height: 20,
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
                    )
                  ],
                ),
                Positioned(
                  bottom: 10,right: 10,
                  child: LikeWidget(),


                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  widget.product.name!,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Text("\$${widget.product.price!/100 }",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red)),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.remove,size: 20,)),
              Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text("Add to Bag",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
                ),
              ),IconButton(onPressed: (){

                changeScreen(context, Bag(pro:widget.product ,));
              }, icon: Icon(Icons.add,size: 20,))
            ],
          )
        ],
      )),
    );
  }
}
