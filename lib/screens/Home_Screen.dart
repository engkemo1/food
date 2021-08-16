import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foood/Providers/APP.dart';
import 'package:foood/Providers/Category.dart';
import 'package:foood/Providers/Products.dart';
import 'package:foood/Providers/res.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/helpers/Catag.dart';
import 'package:foood/helpers/Featured.dart';
import 'package:foood/helpers/Loading.dart';
import 'package:foood/helpers/navig.dart';
import 'package:foood/helpers/widget/res.dart';
import 'package:foood/models/pro%20search.dart';
import 'package:foood/models/res%20search.dart';
import 'package:foood/screens/rest.dart';

import 'package:provider/provider.dart';

import 'Cart Screen.dart';
import 'Login.dart';
import 'category.dart';
import 'order.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final app = Provider.of<AppProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    restaurantProvider.loadSingleRestaurant();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0.5,
        backgroundColor: Colors.yellow,
        title: Text(
          "FoodApp",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  changeScreen(context, CartScreen());
                },
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.yellow),
              accountName: Text(
                user.userModel?.name ?? "username lading...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              accountEmail: Text(
                 user.userModel?.email ?? "email loading...",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, Home());
              },
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            ListTile(
              onTap: () async {
                await user.getOrders();
                changeScreen(context, OrdersScreen());
              },
              leading: Icon(Icons.bookmark_border),
              title: Text("My orders"),
            ),
            ListTile(
              onTap: () {
                changeScreen(context, CartScreen());
              },
              leading: Icon(Icons.shopping_cart),
              title: Text( "Cart"),
            ),
            ListTile(
              onTap: () {
                user.signOut();
                changeScreenReplacement(context, Login());
              },
              leading: Icon(Icons.exit_to_app),
              title: Text( "Log out"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body:  SafeArea(
              child: ListView(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ListTile(
                          leading: Icon(
                            Icons.search,
                            color: Colors.red,
                          ),
                          title: TextField(
                            textInputAction: TextInputAction.search,
                            onSubmitted: (pattern) async {
                              app.changeLoading();
                              if (app.search == SearchBy.PRODUCTS) {
                                await productProvider.search(
                                    pattern);
                                changeScreen(context, ProductSearchScreen());
                              } else {
                                await restaurantProvider.search(name: pattern);
                                changeScreen(
                                    context, RestaurantsSearchScreen());
                              }
                              app.changeLoading();
                            },
                            decoration: InputDecoration(
                              hintText: "Find food and restaurant",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                         "Search by:",style: TextStyle( color: Colors.grey,
                        fontWeight: FontWeight.w300,),

                      ),
                      DropdownButton<String>(
                        value: app.filterBy,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w300),
                        icon: Icon(
                          Icons.filter_list,
                          color: Colors.yellow,
                        ),
                        elevation: 0,
                        onChanged: (value) {
                          if (value == "Products") {
                            app.changeSearchBy( SearchBy.PRODUCTS);
                          } else {
                            app.changeSearchBy(
                                 SearchBy.RESTAURANTS);
                          }
                        },
                        items: <String>["Products", "Restaurants"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value, child: Text(value));
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categoryProvider.categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {

//                              app.changeLoading();
                              await productProvider.loadProductsByCategory(
                                  categoryName:
                                      categoryProvider.categories[index].name);

                              changeScreen(
                                  context,
                                  CategoryScreen( categoryModel: categoryProvider.loadCategories(),
                                    
                                  ));

//                              app.changeLoading();
                            },
                            child: CategoryWidget(
                              categore:categoryProvider.loadCategories() ,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(

                          "Featured",style: TextStyle( fontSize: 20,
                          color: Colors.grey,)

                        ),
                      ],
                    ),
                  ),
                  Featured(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Popular restaurants",style: TextStyle(fontSize: 20,
                          color: Colors.grey,),

                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: restaurantProvider.restaurants
                        .map((item) => GestureDetector(
                              onTap: () async {
                                app.changeLoading();

                                await productProvider.loadProductsByRestaurant(
                                    restaurantId: item.id);
                                app.changeLoading();

                                changeScreen(
                                    context,
                                    RestaurantScreen(
                                      restaurantModel: item,
                                    ));
                              },
                              child: RestaurantWidget(
                                restaurant: item,
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
    );
  }
}
