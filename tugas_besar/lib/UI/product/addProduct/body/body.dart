import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveData() async {
    // Replace the following line with the logic to save your data
    // For example, you can save a string, a file, or any other data type
    var dataToSave = "This is the data to be saved.";

    // Save the data or perform any desired action here
    // For demonstration purposes, we'll print the data
    print("Data saved: $dataToSave");

    // Add additional logic here to save or process the data as needed
    // For example, you can call a function to upload the data to a server
    // uploadDataToServer(dataToSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Produk'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                ),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(
                  labelText: 'Category',
                ),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
              ),
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(
                  labelText: 'Color',
                ),
              ),
              if (_image != null)
                Image.file(
                  _image!,
                  width: 200,
                  height: 200,
                )
              else
                const Text('Pilih Gambar'),
              ElevatedButton(
                onPressed: _getImage,
                child: const Text('Pilih Gambar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Pilih gambar terlebih dahulu'),
                      ),
                    );
                    return;
                  }

                  _saveData(); // Call the save data method

                  final params = {
                    'brand': _brandController.text,
                    'name': _nameController.text,
                    'category': _categoryController.text,
                    'price': _priceController.text,
                    'color': _colorController.text,
                    'gambar': _image!.path,
                  };

                  // Perform the necessary actions here
                  // For example, make an API call to save the data
                  // and handle the response accordingly
                },
                child: const Text('Save'),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
