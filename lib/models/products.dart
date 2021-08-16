
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  static const ID = "id";
  static const NAME = "name";
  static const RATING = "rating";
  static const IMAGE = "image";
  static const PRICE = "price";
  static const RESTAURANT_ID = "restaurantId";
  static const RESTAURANT = "restaurant";
  static const DESCRIPTION = "description";
  static const CATEGORY = "category";
  static const FEATURED = "featured";
  static const RATES = "rates";
  static const USER_LIKES = "userLikes";


  String? _id;
  String ?_name;
  String ?_restaurantId;
  String ?_restaurant;
  String ?_category;
  String? _image;
  String ?_description;

  double? _rating;
  int? _price;
  int ?_rates;

  bool? _featured;

  String? get id => _id;

  String? get name => _name;

  String? get restaurant => _restaurant;

  String? get restaurantId => _restaurantId;

  String? get category => _category;

  String? get description => _description;

  String ?get image => _image;



  double? get rating => _rating;

  int ?get price => _price;

  bool ?get featured => _featured;

  int ?get rates => _rates;

  // public variable
  bool liked = false;

  ProductModel.fromSnapshot(DocumentSnapshot snapshot) {
    _id = snapshot[ID];
    _image = snapshot[IMAGE];
    _restaurant = snapshot[RESTAURANT];
    _restaurantId = snapshot[RESTAURANT_ID].toString();
    _description = snapshot[DESCRIPTION];
    _id = snapshot[ID];
    _featured = snapshot[FEATURED];
    _price = snapshot[PRICE].floor();
    _category = snapshot[CATEGORY];
    _rating = snapshot[RATING];
    _rates = snapshot[RATES];
    _name = snapshot[NAME];
  }
}