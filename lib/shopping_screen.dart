import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_controller.dart';

class ShoppingScreen extends StatefulWidget {
  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  final CartController cartController = Get.find();

  final List<Map<String, dynamic>> _shoppinglist = [
    {
      "name": "Apple",
      "Price": "36",
      "image": "assets/images/apple.png",
    },
    {
      "name": "Mango",
      "Price": "66",
      "image": "assets/images/mango.png",

    },
    {
      "name": "Banana",
      "Price": "56",
      "image": "assets/images/banaha.png",
    },
    {
      "name": "Water Melon",
      "Price": "96",
      "image": "assets/images/water_melon.png",
    },
    {
      "name": "Peach",
      "Price": "56",
      "image": "assets/images/peach.png",
    },
    {
      "name": "Blackberry",
      "Price": "86",
      "image": "assets/images/blackberry.png",
    },
  ];


  late List<bool> checklist2;

  @override
  void initState() {
    super.initState();
    checklist2 = List.generate(_shoppinglist.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Shopping Screen",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: GetX<CartController>(
              builder: (cartController) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    if (cartController.itemCount > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 9,
                          child: Text(
                            cartController.itemCount.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _shoppinglist.length,
              itemBuilder: (context, index) {
                final item = _shoppinglist[index];
                return Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Text(
                      item["name"],
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      item["Price"].toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        String itemName = item["name"];
                        String imgUrl = item["image"];
                        double itemPrice = double.tryParse(item["Price"]) ?? 0.0;
                      setState(() {
                        cartController.addToCart(itemName, itemPrice, imgUrl);
                      });
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                    leading: MouseRegion(
                      onEnter: (_) {
                        checklist2[index] = true;
                      },
                      onExit: (_) {
                        checklist2[index] = false;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: checklist2[index] ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Image.asset(
                          item["image"],
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
