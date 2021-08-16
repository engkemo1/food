import 'package:flutter/material.dart';
import 'package:foood/Providers/APP.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/models/Order.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Orders"),
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: user.orders.length,
          itemBuilder: (_, index){
            OrderModel _order = user.orders[index];
            return ListTile(
              leading: Text(
                 "\$${_order.total!/100}",style: TextStyle(fontWeight: FontWeight.bold,),

              ),
              title: Text(_order.description.toString()),
              subtitle: Text(DateTime.fromMillisecondsSinceEpoch(_order.createdAt!.toInt()).toString()),
              trailing: Text( _order.status.toString(), style:TextStyle(color: Colors.green,)),
            );
          }),
    );
  }
}