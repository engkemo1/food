


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foood/models/Cartitems.dart';
import 'package:foood/models/user.dart';

class UserServices{


  String coLection ="users";
  FirebaseFirestore _firesore= FirebaseFirestore.instance;


  void createUser ( Map<String,dynamic> result){
    _firesore.collection(coLection).doc(result["id"]).set(result);
    

  }
void updatedata( Map<String,dynamic> result){
    _firesore.collection(coLection).doc(result["id"]).update(result);
    
}
  Future<UserModel> getUserById(String id) => _firesore.collection(coLection).doc(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });
  void addToCart(String userId, CartItemModel cartItem){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firesore.collection(coLection).doc(userId).update({
      "cart": FieldValue.arrayUnion([cartItem.toMap()])
    });
  }

  void removeFromCart(String userId, CartItemModel cartItem){
    print("THE USER ID IS: $userId");
    print("cart items are: ${cartItem.toString()}");
    _firesore.collection(coLection).doc(userId).update({
      "cart": FieldValue.arrayRemove([cartItem.toMap()])
    });
  }

}