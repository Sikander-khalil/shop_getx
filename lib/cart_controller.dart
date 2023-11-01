import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final RxMap<String, Map<String, dynamic>> cart = <String, Map<String, dynamic>>{}.obs;

  SharedPreferences? _prefs;

  @override
  void onInit() {
    super.onInit();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadCartFromPrefs();
  }

  void _loadCartFromPrefs() {
    final cartData2 = _prefs?.getString('cartData');
    print(cartData2);
    if (cartData2 != null) {
      try {
        cart.value = Map<String, Map<String, dynamic>>.from(json.decode(cartData2));
        update();
      } catch (e) {
        print('Error loading cart data from SharedPreferences: $e');
      }
    }
  }

  Future<void> _saveCartToPrefs() async {
    if (_prefs != null) {
      final cartData2 = json.encode(cart);
      _prefs!.setString('cartData', cartData2);
    }
  }

  int get itemCount => cart.length;

  void addToCart(String itemName, double itemPrice, String imgUrl) {
    if (cart.containsKey(itemName)) {
      cart[itemName]!['count'] += 1;
      cart[itemName]!['price'] = itemPrice * cart[itemName]!['count'];
    } else {
      cart[itemName] = {'price': itemPrice, 'count': 1, 'imgUrl': imgUrl};
    }
    _saveCartToPrefs();
    update();
  }

  void removeFromCart(String itemName) {
    if (cart.containsKey(itemName)) {
      final itemCount = cart[itemName]!['count'];
      if (itemCount > 1) {
        cart[itemName]!['count']--;
        cart[itemName]!['price'] = cart[itemName]!['price'];
      } else {
        cart.remove(itemName);
      }
      _saveCartToPrefs();
      update();
    }
  }

  double getItemPrice(String itemName) {
    if (cart.containsKey(itemName)) {
      return cart[itemName]!['price'];
    }
    return 0;
  }

  dynamic getItemImage(String itemName) {
    if (cart.containsKey(itemName)) {
      return cart[itemName]!['imgUrl'];
    }
    return null;
  }

  void updateCart(String itemName, int itemCount, double itemPrice) {
    if (cart.containsKey(itemName)) {
      final price = cart[itemName]!['price'];
      cart[itemName]!['count'] = itemCount;
      cart[itemName]!['price'] = itemPrice + price - itemPrice;
      _saveCartToPrefs();
      update();
    }
  }
}
