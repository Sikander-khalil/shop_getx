import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_carts_getx/shopping_screen.dart';

import 'cart_screen.dart';
import 'check_out.dart';
import 'cart_controller.dart'; // Import your CartController

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(CartController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => ShoppingScreen(),
        ),
        GetPage(
          name: '/cart',
          page: () => CartScreen(),


        ),
        GetPage(
          name: '/checkout',
          page: () => CheckOut(),
        ),

      ],
    );
  }
}
