import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Category/category.dart';
import 'package:tugas_besar/Models/errormsg.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';
// import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/main/main.dart';
import 'package:tugas_besar/Widget/Components/rounded_button.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';

class EditKatalogSepatu extends StatefulWidget {
  final KatalogSepatuModel katalogSepatuModel;

  const EditKatalogSepatu({Key? key, required this.katalogSepatuModel})
      : super(key: key);

  @override
  _EditKatalogSepatuState createState() => _EditKatalogSepatuState();
}

class _EditKatalogSepatuState extends State<EditKatalogSepatu> {
  final _formProductKey = GlobalKey<FormState>();
  late TextEditingController brand, name, price, color;
  late ErrorMSG response;
  late bool _success = false;
  late String _imagePath = "";
  late String _imageURL = "";
  late List<Category> categories = [];
  late int idCategory = 0;

  @override
  void initState() {
    super.initState();
    brand = TextEditingController(text: widget.katalogSepatuModel.brand);
    name = TextEditingController(text: widget.katalogSepatuModel.name);
    price =
        TextEditingController(text: widget.katalogSepatuModel.price.toString());
    color =
        TextEditingController(text: widget.katalogSepatuModel.color.toString());
    _imageURL = widget.katalogSepatuModel.image;
    // idCategory = widget.katalogSepatuModel.categoryId;

    // Add your code to fetch categories if needed
    // categories = await _dataService.getCategories();
  }

  final ImagePicker _picker = ImagePicker();
  XFile? img;

  Future<void> gallery() async {
    final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagePath = _image!.path;
      img = _image;
    });
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return "Field cannot be empty";
    }
    return null;
  }

  Future<void> save() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Processing"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 4),
              Text("Loading..."),
            ],
          ),
        );
      },
    );

    if (_formProductKey.currentState!.validate()) {
      _formProductKey.currentState!.save();
      var params = {
        'id': widget.katalogSepatuModel.id,
        'brand': brand.text,
        'name': name.text,
        'category': idCategory.toString(),
        'price': price.text,
        'color': color.text,
      };

      // Replace the next line with your API service call
      // Response response = await _dataService.putKatalogSepatu(widget.katalogSepatuModel.id.toString(), params);

      // Simulate a response
      try {
        // Replace the next line with your Dio API service call
        // Response response = await _dataService.putKatalogSepatu(widget.katalogSepatuModel.id.toString(), params);

        // Simulate a response
        Response<Map<String, dynamic>> response = Response(
          data: {'success': true, 'message': 'Product updated successfully'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );

        _success = response.data?['success'] ?? false;

        final snackBar = SnackBar(
          content: Text(response.data?['message'] ?? 'Unknown response'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        if (_success) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
          );
        }
      } catch (e) {
        print("Error: $e");
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Product"),
        backgroundColor: kPrimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formProductKey,
          child: ListView(
            children: [
              TextFormField(
                controller: brand,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Brand",
                  icon: Icon(Iconsax.box),
                ),
                validator: validator,
              ),
              TextFormField(
                controller: name,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Product Name",
                  icon: Icon(Iconsax.box),
                ),
                validator: validator,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: DropdownButtonFormField<int>(
                  hint: Text("Select Category"),
                  value: idCategory == 0 ? null : idCategory,
                  decoration: InputDecoration(
                    icon: const Icon(Iconsax.category),
                  ),
                  items: categories.map((item) {
                    return DropdownMenuItem<int>(
                      child: Text(item.kategori),
                      value: item.id,
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idCategory = value ?? 0;
                    });
                  },
                  // validator: validator,
                ),
              ),
              TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price",
                  icon: Icon(Iconsax.ticket),
                ),
                validator: validator,
              ),
              TextFormField(
                controller: color,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Color",
                  icon: Icon(Iconsax.shopping_bag),
                ),
                validator: validator,
              ),
              SizedBox(
                height: 16,
              ),
              Text("Add Photos"),
              InkWell(
                onTap: gallery,
                child: img == null
                    ? Image.network(
                        _imageURL,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(_imagePath),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 16,
              ),
              RoundedButton(
                text: "Save Product",
                press: save,
                color: kPrimaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic displaySnackbar(String msg) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }
}
