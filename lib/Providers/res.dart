import 'package:flutter/material.dart';
import 'package:foood/helpers/restaurent.dart';
import 'package:foood/models/Res%20model.dart';

class RestaurantProvider with ChangeNotifier{
  RestaurantServices _restaurantServices = RestaurantServices();
  List<RestaurantModel> restaurants = [];
  List<RestaurantModel> searchedRestaurants = [];

  RestaurantModel? restaurant;

  RestaurantProvider.initialize(){
    loadRestaurants();
  }

  loadRestaurants()async{
    restaurants = await _restaurantServices.getRestaurants();
    notifyListeners();
  }

  loadSingleRestaurant({String? retaurantId}) async{
    restaurant = await _restaurantServices.getRestaurantById(id: retaurantId);
    notifyListeners();
  }

  Future search({String? name})async{
    searchedRestaurants = await _restaurantServices.searchRestaurant(restaurantName: name);
    print("RESTOS ARE: ${searchedRestaurants.length}");
    notifyListeners();
  }
}