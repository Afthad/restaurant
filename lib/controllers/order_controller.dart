import 'package:get/get.dart';
import 'package:restaurant_app/models/cart_model.dart';
import 'package:restaurant_app/models/products_model.dart';
import 'package:restaurant_app/prefs/prefs.dart';


class OrderController extends GetxController {
  RxList<CartModel> cartItems = <CartModel>[].obs;

  addToCart(Cat1 cart) {
    bool isExists = false;
    for (var e in cartItems) {
      if (e.name == cart.name) {
        e.count = e.count + 1;
        isExists = true;
        break;
      }
    }
    if (!isExists) {
      cartItems.add(CartModel(count: 1, name: cart.name!, price: cart.price!));
    }
    getTotalPrice();
  }

  deleteCartItem(String name) {
    cartItems.removeWhere((element) => element.name == name);
  }

  reduceCount(String name) {
    for (var e in cartItems) {
      if (e.name == name && e.count > 1) {
        e.count = e.count - 1;
        break;
      }
      if (e.name == name && e.count == 1) {
        deleteCartItem(name);
        break;
      }
    }
    getTotalPrice();
  }

  RxDouble totalPrice = 0.0.obs;
  void getTotalPrice() {
    totalPrice.value = cartItems.fold<double>(
        0,
        (previousValue, element) =>
            (double.parse((element.price.toString())) * element.count) +
            previousValue);
  }

  RxBool checkCart(String name) {
    RxBool itExists = false.obs;
    for (var element in cartItems) {
      if (element.name == name) {
        itExists.value = true;
      }
    }
    return itExists;
  }

  clearCart() {
    cartItems.clear();
    getTotalPrice();
  }

  Future<void> saveOrder() async {
    List<Map<dynamic, dynamic>> addedItems = [];
    if (PrefsDb.prefsBox.isNotEmpty) {
      for (var c in PrefsDb.getOrders) {
        addedItems.add({
          "name": c['name'],
          "price": c['price'],
          "count": c['count'],
          "instock": true
        });
      }
    }
    for (var a in cartItems) {
      addedItems.add({
        "name": a.name,
        "price": a.price,
        "count": a.count,
        "instock": true
      });
    }

    PrefsDb.saveOrders(addedItems);
    print(PrefsDb.getOrders);
    getTotalPrice();
  }
}
