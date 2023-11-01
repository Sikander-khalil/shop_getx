import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_carts_getx/user_model.dart';

import 'detail_screen.dart';



class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController dropInput = TextEditingController();
  List<UserModel> usersList = List.empty(growable: true);

  int index = 0;
  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }
  Future<void> saveUserModelsToSharedPreferences(List<UserModel> userList) async {
    final prefs = await SharedPreferences.getInstance();


    final userModelsJsonList = userList.map((user) => jsonEncode(user.toJson())).toList();


    await prefs.setStringList('userModels', userModelsJsonList);
  }

  var items = ['JaazCash', 'Payonner', 'Bank', 'EasyPaisa'];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
              title: Text("Check Out"),
              automaticallyImplyLeading: true,
              actions: [
                InkWell(
                    onTap: () {
                      Get.to(() => DetailScreen());
                    },
                    child: Icon(Icons.navigate_next_sharp))
              ]),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: dateInput,
                      decoration: InputDecoration(
                        hintText: 'Enter your date',
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1995),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: dropInput,
                      decoration: InputDecoration(
                        hintText: "Enter Your Payment Method",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        suffixIcon: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            dropInput.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return items
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        hintText: 'Enter Your City',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            String name = nameController.text.trim();
                            String city = cityController.text.trim();
                            String date = dateInput.text.trim();
                            String drop = dropInput.text.trim();

                            if (name.isNotEmpty && city.isNotEmpty) {
                              setState(() {


                                usersList.add(UserModel(
                                  name: name,
                                  cityName: city,
                                  dateTime: date,
                                  dropValue: drop,
                                ));


                                saveUserModelsToSharedPreferences(usersList);
                              });
                             Get.to(() => DetailScreen());
                            }
                          },
                          child: Text("Donate"),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
