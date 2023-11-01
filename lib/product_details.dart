import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'cart_controller.dart'; // Import your CartController

class ProdcutDetails extends StatefulWidget {
  final String itemName;
  final String itemImage;
  final dynamic itemCount;
  final double itemPrice;

  ProdcutDetails({
    required this.itemName,
    required this.itemCount,
    required this.itemImage,
    required this.itemPrice,
  });

  @override
  State<ProdcutDetails> createState() => _ProdcutDetailsState();
}

class _ProdcutDetailsState extends State<ProdcutDetails> {
  late TextEditingController itemCountController;
  late dynamic itemcount;
  late int firstVal;

  @override
  void initState() {

    super.initState();

    itemcount = widget.itemCount;
    firstVal = widget.itemPrice.toInt();
    itemCountController = TextEditingController(text: widget.itemCount.toString());

  }
  final CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
   // TextEditingController itemCountController = TextEditingController(text: widget.itemCount.toString());


    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: (){

              Get.back();
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(widget.itemImage),
                Text(
                  widget.itemName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 20),
                Text(itemCountController.text.toString()),
                TextFormField(
                  controller: itemCountController,
                  keyboardType: TextInputType.number,
                  onChanged: (newValue) {
                    setState(() {
                    double abc = widget.itemPrice;
                    double enteredQuantity = double.tryParse(itemCountController.text) ?? 0.0;
                    double result = enteredQuantity * abc;

                    firstVal = result.toInt();

                    cartController.updateCart(widget.itemName, enteredQuantity.toInt(), firstVal.toDouble());
                  });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  (firstVal.toString()),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
