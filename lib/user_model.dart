class UserModel {
  String name;
  String cityName;
  String dateTime;
  String dropValue;

  UserModel(
      {required this.name,
        required this.cityName,
        required this.dateTime,
        required this.dropValue});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      name: json["name"],
      cityName: json["cityName"],
      dateTime: json["dateTime"],
      dropValue: json["dropValue"]);

  Map<String, dynamic> toJson() => {
    "name": name,
    "cityName": cityName,
    "dateTime": dateTime,
    "dropValue": dropValue
  };
}
