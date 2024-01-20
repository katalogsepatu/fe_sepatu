// class Product {
//     Product({
//         required this.id,
//         required this.nama,
//         required this.seller,
//         required this.idKategori,
//         required this.deskripsi,
//         required this.harga,
//         required this.stok,
//         required this.gambar,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.kategori,
//     });

//     int id;
//     String nama;
//     int seller;
//     int idKategori;
//     String deskripsi;
//     int harga;
//     int stok;
//     String gambar;
//     DateTime createdAt;
//     dynamic updatedAt;
//     String kategori;

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         nama: json["nama"].toString(),
//         seller: json["seller"],
//         idKategori: json["id_kategori"],
//         deskripsi: json["deskripsi"].toString(),
//         harga: json["harga"],
//         stok: json["stok"],
//         gambar: json["gambar"].toString(),
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"],
//         kategori: json["kategori"].toString(),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "nama": nama,
//         "seller": seller,
//         "id_kategori": idKategori,
//         "deskripsi": deskripsi,
//         "harga": harga,
//         "stok": stok,
//         "gambar": gambar,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt,
//         "kategori": kategori,
//     };
// }

// //DIGUNAKAN UNTUK GET ALL DATA
// // class KatalogSepatuModel {
// //   final String id;
// //   final String brand;
// //   final String name;
// //   final String category;
// //   final String price;
// //   final String color;
// //   final String image;

// //   KatalogSepatuModel({
// //     required this.id,
// //     required this.brand,
// //     required this.name,
// //     required this.category,
// //     required this.price,
// //     required this.color,
// //     required this.image,
// //   });

// //   factory KatalogSepatuModel.fromJson(Map<String, dynamic> json) =>
// //       KatalogSepatuModel(
// //           id: json["_id"],
// //           brand: json["brand"],
// //           name: json["name"],
// //           category: json["category"],
// //           price: json["price"],
// //           color: json["color"],
// //           image: json["image"]);

// //   Map<String, dynamic> toJson() => {
// //         "_id": id,
// //         "brand": brand,
// //         "name": name,
// //         "category": category,
// //         "price": price,
// //         "color": color,
// //         "image": image
// //       };
// // }

// // //DIGUNAKAN UNTUK FORM INPUT
// // class KatalogSepatuInput {
// //   final String brand;
// //   final String name;
// //   final String category;
// //   final String price;
// //   final String color;
// //   final String image;

// //   KatalogSepatuInput({
// //     required this.brand,
// //     required this.name,
// //     required this.category,
// //     required this.price,
// //     required this.color,
// //     required this.image,
// //   });

// //   Map<String, dynamic> toJson() => {
// //         "brand": brand,
// //         "name": name,
// //         "category": category,
// //         "price": price,
// //         "color": color,
// //         "image": image
// //       };
// // }

// // //DIGUNAKAN UNTUK RESPONSE
// // class KatalogSepatuResponse {
// //   final String? insertedId;
// //   final String message;
// //   final int status;

// //   KatalogSepatuResponse({
// //     this.insertedId,
// //     required this.message,
// //     required this.status,
// //   });

// //   factory KatalogSepatuResponse.fromJson(Map<String, dynamic> json) =>
// //       KatalogSepatuResponse(
// //         insertedId: json["inserted_id"],
// //         message: json["message"],
// //         status: json["status"],
// //       );
// // }
