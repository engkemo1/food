import 'package:cloud_firestore/cloud_firestore.dart';

import 'Cartitems.dart';

class UserModel{
  static const ID = "id";
  static const NAME = "name";
  static const EMAIL = "email";
  static const STRIPE_ID = "stripeId";
  static const CART = "cart";



  String? _name;
  String ?_email;
  String ?_id;
  String? _stripeId;
  int _priceSum = 0;
  int ?_quantitySum = 0;


//  getters
  String? get name => _name;
  String? get email => _email;
  String? get id => _id;
  String? get stripeId => _stripeId;

//  public variable
  List<CartItemModel>?cart;
  int? totalCartPrice;

  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot[NAME];
    _email = snapshot[EMAIL];
    _id = snapshot[ID];
    _stripeId = snapshot[STRIPE_ID];
    cart = _convertCartItems(snapshot[CART]) ;
    totalCartPrice = snapshot[CART] == null ? 0 :getTotalPrice(snapshot[CART]);
  }

  int getTotalPrice(List? cart){
    if(cart == null){
      return 0;
    }
    for(Map cartItem in cart){
      int price= cartItem["price"] * cartItem["quantity"];
      _priceSum+=price;
    }

    int total = _priceSum;

    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");
    print("THE TOTAL IS $total");

    return total;
  }

  List<CartItemModel> _convertCartItems(List cart){
    List<CartItemModel> convertedCart = [];
    for(Map cartItem in cart){
      convertedCart.add(CartItemModel.fromMap(cartItem));
    }
    return convertedCart;
  }}