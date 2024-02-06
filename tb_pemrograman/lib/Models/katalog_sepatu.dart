//DIGUNAKAN UNTUK GET ALL DATA

import 'package:dio/dio.dart';

class KatalogSepatuModel {
  final String id;
  final String brand;
  final String name;
  final String category;
  final String price;
  final String diskon;
  final String color;
  final String image;

  KatalogSepatuModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.diskon,
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
        diskon: json["diskon"],
        color: json["color"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "brand": brand,
        "name": name,
        "category": category,
        "price": price,
        "diskon": diskon,
        "color": color,
        "image": image,
      };

  // static fromResponse(ProductResponse? res) {}
}

//DIGUNAKAN UNTUK FORM INPUT
class KatalogSepatuInput {
  final String brand;
  final String name;
  final String category;
  final String price;
  final String diskon;
  final String color;
  final String imagePath;
  final String imageName;

  KatalogSepatuInput({
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.diskon,
    required this.color,
    required this.imagePath,
    required this.imageName,
  });

  FormData formData() => FormData.fromMap({
        "brand": brand,
        "name": name,
        "category": category,
        "price": price,
        "diskon": diskon,
        "color": color,
        "file": MultipartFile.fromFileSync(imagePath, filename: imageName),
      });
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
}
