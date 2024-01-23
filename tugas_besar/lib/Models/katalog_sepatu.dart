//DIGUNAKAN UNTUK GET ALL DATA
import 'package:tugas_besar/Models/Category/category.dart';

class KatalogSepatuModel {
  final String id;
  final String brand;
  final String name;
  final String category;
  final String price;
  final String color;
  final String image;

  KatalogSepatuModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.color,
    required this.image,
  });

  factory KatalogSepatuModel.fromJson(Map<String, dynamic> json) =>
      KatalogSepatuModel(
          id: json["_id"],
          brand: json["brand"],
          name: json["name"],
          category: json["category"],
          price: json["price"],
          color: json["color"],
          image: json["image"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "name": name,
        "category": category,
        "price": price,
        "color": color,
        "image": image
      };
}

//DIGUNAKAN UNTUK FORM INPUT
class KatalogSepatuInput {
  final String brand;
  final String name;
  final String category;
  final String price;
  final String color;
  final String image;

  KatalogSepatuInput({
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.color,
    required this.image,
  });

  Map<String, dynamic> toJson() => {
        "brand": brand,
        "name": name,
        "category": category,
        "price": price,
        "color": color,
        "image": image
      };
}

//DIGUNAKAN UNTUK RESPONSE
class KatalogSepatuResponse {
  final String? insertedId;
  final String message;
  final int status;

  KatalogSepatuResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory KatalogSepatuResponse.fromJson(Map<String, dynamic> json) =>
      KatalogSepatuResponse(
        insertedId: json["inserted_id"],
        message: json["message"],
        status: json["status"],
      );

  List<Category>? get categories => null;

  // Future<List<Category>> toList() async {}

  map(Category Function(dynamic json) param0) {}
}
