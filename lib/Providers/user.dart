
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foood/helpers/order.dart';
import 'package:foood/helpers/users.dart';
import 'package:foood/models/Cartitems.dart';
import 'package:foood/models/Order.dart';
import 'package:foood/models/products.dart';
import 'package:foood/models/user.dart';
import 'package:uuid/uuid.dart';
 enum Status{Uninitialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{


   var user= FirebaseAuth.instance.currentUser;
  FirebaseAuth? _auth;
  User? _user;
  UserServices _userServicse = UserServices();
OrderServices ord = OrderServices();
  Status _status = Status.Uninitialized;
FirebaseFirestore FIR= FirebaseFirestore.instance;
  UserModel? _userModel;
  //  getter
  UserModel? get userModel => _userModel;
  Status get status => _status;
  final formkey = GlobalKey<FormState>();
   List<OrderModel> orders = [];

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
   UserProvider.initialize(): _auth = FirebaseAuth.instance{
     _auth!.authStateChanges().listen((User? use){
      _onStateChanged(use!);
     });
   }
   Future<void> _onStateChanged(User firebaseUser) async{
     if(firebaseUser == null){
       _status = Status.Unauthenticated;
     }else{
       _user = firebaseUser;
       _status = Status.Authenticated;
       _userModel = await _userServicse.getUserById(_user!.uid);
     }
     notifyListeners();
   }


   Future<void> reloadUserModel()async{
     _userModel = await _userServicse.getUserById(user!.uid);
     notifyListeners();
   }
   Future<bool> signIn()async{
     try{

       _status = Status.Authenticating;
       notifyListeners();
       await _auth!.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
       return true;
     }catch(e){
       _status = Status.Unauthenticated;
       notifyListeners();
       print(e.toString());
       return false;
     }
   }
Future<bool> signUp()async{
     try{

_status = Status.Authenticating;
notifyListeners();
await _auth!.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value) => FirebaseFirestore.instance.collection("users").doc(value.user!.uid).set({
  'name':name.text,
  'email':email.text,
  'uid':value.user!.uid,
  "likedFood": [],
  "likedRestaurants": []


}));
return true;


     }catch(e){
       _status=Status.Unauthenticated;
       notifyListeners();
       print(e.toString());
       return false;
     }
}
   void clearController(){
     name.text = "";
     password.text = "";
     email.text = "";
   }
   Future signOut()async{
     _auth!.signOut();
     _status = Status.Unauthenticated;
     notifyListeners();
     return Future.delayed(Duration.zero);
   }
   Future<bool> addToCard(ProductModel product, int quantity)async{
     print("THE PRODUC IS: ${product.toString()}");
     print("THE qty IS: ${quantity.toString()}");

     try{
       var uuid = Uuid();
       String cartItemId = uuid.v4();
       List<CartItemModel>? cart = _userModel!.cart;
//      bool itemExists = false;
       Map cartItem ={
         "id": cartItemId,
         "name": product.name,
         "image": product.image,
         "restaurantId": product.restaurantId,
         "totalRestaurantSale": product.price! * quantity,
         "productId": product.id,
         "price": product.price,
         "quantity": quantity
       };

       CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){
       print("CART ITEMS ARE: ${cart.toString()}");
         _userServicse.addToCart( _user!.uid, item);
//      }



       return true;
     }catch(e){
       print("THE ERROR ${e.toString()}");
       return false;
     }

   }

   getOrders()async{
     orders = await ord.getUserOrders(userId: _user!.uid);
     notifyListeners();
   }

   Future<bool> removeFromCart(CartItemModel cartItem)async{
     print("THE PRODUC IS: ${cartItem.toString()}");

     try{
       _userServicse.removeFromCart( _user!.uid, cartItem);
       return true;
     }catch(e){
       print("THE ERROR ${e.toString()}");
       return false;
     }

   }
}

