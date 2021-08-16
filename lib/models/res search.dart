import 'package:flutter/material.dart';
import 'package:foood/Providers/APP.dart';
import 'package:foood/Providers/Products.dart';
import 'package:foood/Providers/res.dart';
import 'package:foood/helpers/Loading.dart';
import 'package:foood/helpers/navig.dart';
import 'package:foood/helpers/widget/res.dart';
import 'package:foood/screens/rest.dart';
import 'package:provider/provider.dart';

class RestaurantsSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
        "Restaurants", style: TextStyle(fontSize:20 ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: app.isLoading
          ? Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Loading()],
        ),
      )
          : restaurantProvider.searchedRestaurants.length < 1
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.grey,
                size: 30,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(
              "No Restaurants Found",style: TextStyle( color: Colors.grey,
              fontWeight: FontWeight.w300,
              fontSize: 22,),

              ),
            ],
          )
        ],
      )
          : ListView.builder(
          itemCount: restaurantProvider.searchedRestaurants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () async {
                  app.changeLoading();
                  await productProvider.loadProductsByRestaurant(
                      restaurantId: restaurantProvider
                          .searchedRestaurants[index].id);
                  app.changeLoading();

                  changeScreen(
                      context,
                      RestaurantScreen(
                        restaurantModel: restaurantProvider
                            .searchedRestaurants[index],
                      ));
                },
                child: RestaurantWidget(
                    restaurant:
                    restaurantProvider.searchedRestaurants[index]));
          }),
    );
  }
}