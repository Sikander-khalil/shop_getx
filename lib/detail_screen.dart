import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_carts_getx/user_model.dart';

import 'cart_controller.dart';


class DetailScreen extends StatefulWidget {
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final CartController cartController = Get.find<CartController>();
  List<UserModel> usersList = [];
  @override
  void initState() {
    super.initState();
    loadUserModelsFromSharedPreferences();
  }

  Stream<List<UserModel>> loadUserModelsFromSharedPreferences() async* {
    final prefs = await SharedPreferences.getInstance();
    final userModelsJsonList = prefs.getStringList('userModels');
    if (userModelsJsonList != null) {
      final userModelsList = userModelsJsonList
          .map((json) => UserModel.fromJson(jsonDecode(json)))
          .toList();
      yield userModelsList;
    } else {
      yield [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users Details'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<List<UserModel>>(

              stream: loadUserModelsFromSharedPreferences(),
              builder: (context, AsyncSnapshot snapshot) {

                if (snapshot.hasData) {
                  List<UserModel> userModels = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: userModels.length,
                    itemBuilder: (context, index) =>
                        getRow(userModels[index], index),
                  );
                } else {

                  return Text('Stream emitted false');
                }
              },


            )
          ],
        ),
      ),
    );
  }

  Widget getRow(UserModel model, int index) {
    return SizedBox(
      height: 300,
      child: Card(
        color: Colors.red,
        child: ListTile(
          leading: CircleAvatar(
            radius: 15,
            backgroundColor: index % 2 == 0 ? Colors.blue : Colors.black,
            child: Text(
              model.name[0],
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Text(
                      model.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                model.cityName,
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                model.dateTime,
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                model.dropValue,
                style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),

              SizedBox(
                height: 150,
               child: _buildItemList(cartController),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemList(CartController cart) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.cart.length,
          itemBuilder: (context, index) {
            var itemName = controller.cart.keys.elementAt(index);
            var itemData = controller.cart[itemName];
            var itemPrice = itemData!['price'];
            var itemCount = itemData['count'];

            List<Widget> itemList = [];

            itemList.add(
              Card(
                color: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Item Name: " + " " + itemName,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Item Quantity: " + " " + itemCount.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${itemName} Price: " +
                              " " +
                              (itemPrice * itemCount).toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );

            return Stack(
              children: itemList,
            );
          },
        );
      },
    );
  }
}