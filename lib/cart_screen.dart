import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_carts_getx/check_out.dart';
import 'package:shopping_carts_getx/product_details.dart';
import 'cart_controller.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (CartController cartcont){
        return Scaffold(
          key: _scaffoldkey,
          appBar: AppBar(
            title: Text('Cart'),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => CheckOut());
                      },
                      child: Text("Check Out"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Obx(() {
            final cart = Get.find<CartController>().cart;

            return ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final itemName = cart.keys.elementAt(index);
                final itemData = cart[itemName];
                final itemPrice = itemData!['price'];
                final itemImg = itemData['imgUrl'];
                final itemCount = itemData['count'];

                final itemList = <Widget>[];
                for (int i = 1; i <= itemCount; i++) {
                  itemList.add(
                    Card(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: InkWell(
                          onTap: () {
                            Get.to(() => ProdcutDetails(
                              itemName: itemName,
                              itemCount: itemCount,
                              itemImage: itemImg,
                              itemPrice: itemPrice,
                            ));
                          },
                          child: Text(
                            '$i item $itemName',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        subtitle: Text(
                          'Price: ${itemPrice.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: Image.asset(
                          itemImg,
                          width: 50,
                          height: 50,
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {

                            setState(() {
                              Get.find<CartController>().removeFromCart(itemName);
                            });
                          },
                          child: Text("Remove Cart"),
                        ),
                      ),
                    ),
                  );
                }

                return Column(children: itemList);
              },
            );
          }),
        );

      },

    );
  }
}
