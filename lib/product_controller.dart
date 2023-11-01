import 'package:get/get.dart';

class ProdcutDetailsController extends GetxController {

  final itemName = ''.obs;
  final itemImage = ''.obs;
  final itemCount = 0.obs;
  final itemPrice = 0.0.obs;


  void updateItemDetails(String name, String image, int count, double price) {
    itemName.value = name;
    itemImage.value = image;
    itemCount.value = count;
    itemPrice.value = price;
  }


}
