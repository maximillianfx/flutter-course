import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {

  UserModel user;
  List<CartProduct> products = [];
  bool isLoading = false;
  String couponCode;
  double discountPercentage = 0;

  static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  CartModel(this.user) {
    if (user.isLoggedIn()) {
      _loadCartItems();
    }
  }

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance.collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap()).then((doc) {
          cartProduct.cartId = doc.documentID;
    });

    notifyListeners();

  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance.collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart").document(cartProduct.cartId).delete();

    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct (CartProduct cartProduct) {
    cartProduct.quantity--;
    Firestore.instance.collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void incProduct (CartProduct cartProduct) {
    cartProduct.quantity++;
    Firestore.instance.collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cartId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
    products = query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void setCoupon(String couponCode, double discountPercentage) {
    this.couponCode = couponCode;
    this.discountPercentage = discountPercentage;
  }

  double getProductsPrice() {
    double price = 0.0;
    for(CartProduct c in products) {
      if (c.productData != null) {
        price += c.quantity*c.productData.price;
      }
    }

    return price;

  }

  double getShipPrice() {
    return 9.99;
  }

  double getDiscount() {
    return getProductsPrice()* (discountPercentage/100);
  }

  void updatePrices() {
    notifyListeners();
  }

  Future<String> finishOrder() async {
    if (products.length == 0) {
      return null;
    } else {
      isLoading = true;
      notifyListeners();
      double productsPrice = getProductsPrice();
      double shipPrice = getShipPrice();
      double discount = getDiscount();

      DocumentReference refOrder = await Firestore.instance.collection("orders").add(
        {
          "clientID": user.firebaseUser.uid,
          "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
          "shipPrice": shipPrice,
          "productsPrice": productsPrice,
          "discount": discount,
          "totalPrice": productsPrice - discount + shipPrice,
          "status": 1
        }
      );

      await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("orders").document(refOrder.documentID).setData(
        {
          "orderId": refOrder.documentID
        }
      );

      QuerySnapshot query = await Firestore.instance.collection("users").document(user.firebaseUser.uid).collection("cart").getDocuments();
      for(DocumentSnapshot doc in query.documents) {
        doc.reference.delete();
      }

      products.clear();
      couponCode = null;
      discountPercentage = 0.0;
      isLoading = false;
      notifyListeners();
      return refOrder.documentID;
    }
  }
}
