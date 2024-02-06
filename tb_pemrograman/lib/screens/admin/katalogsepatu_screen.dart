import 'package:flutter/material.dart';
import 'package:tb_pemrograman/models/katalog_sepatu.dart';
import 'package:tb_pemrograman/services/api_services.dart';
import 'package:tb_pemrograman/widget/katalogsepatu_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

class KatalogSepatuScreen extends StatefulWidget {
  const KatalogSepatuScreen({super.key});

  @override
  State<KatalogSepatuScreen> createState() => _KatalogSepatuScreenState();
}

class _KatalogSepatuScreenState extends State<KatalogSepatuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brand = TextEditingController();
  final _name = TextEditingController();
  final _category = TextEditingController();
  final _price = TextEditingController();
  final _diskon = TextEditingController();
  final _color = TextEditingController();
  String _result = '-';

  PlatformFile? file;
  String? _namaFile;
  String? _pathFile;

  final ApiServices _dataService = ApiServices();
  List<KatalogSepatuModel> _katalogsepatuModel = [];

  KatalogSepatuResponse? katalogsepatuRes;

  bool isEdit = false;
  String idKatalogSepatu = '';

  @override
  void dispose() {
    _brand.dispose();
    _name.dispose();
    _category.dispose();
    _price.dispose();
    _diskon.dispose();
    _color.dispose();
    super.dispose();
  }

  String? _validateKatalogSepatu(String? value) {
    if (value == null || value.isEmpty) {
      return 'Data tidak boleh kosong';
    }
    if (!RegExp(r'^[A-Z]').hasMatch(value)) {
      return 'Data harus diawali dengan huruf kapital';
    }

    if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Data hanya boleh mengandung huruf';
    }
    return null;
  }

  // bool _validateFile(String? pathFile) {
  //   if (pathFile == null) {
  //     return true;
  //   }
  //   return false;
  // }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    file = result.files.single;

    setState(() {
      _namaFile = file!.name;
      _pathFile = file!.path;
    });
  }

  Future<void> refreshKatalogSepatuList() async {
    final user = await _dataService.getAllKatalogSepatu();
    setState(() {
      if (_katalogsepatuModel.isNotEmpty) _katalogsepatuModel.clear();
      if (user != null) _katalogsepatuModel.addAll(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SHOE CATALOG",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange.shade800,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _brand,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Brand Sepatu',
                  hintText: 'Masukkan beand sepatu',
                  suffixIcon: _brand.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _brand.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _name,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Nama Sepatu',
                  hintText: 'Masukkan nama sepatu',
                  suffixIcon: _name.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _name.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _category,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Category Sepatu',
                  hintText: 'Masukkan category sepatu',
                  suffixIcon: _category.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _category.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _price,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Price Sepatu',
                  hintText: 'Masukkan price sepatu',
                  suffixIcon: _price.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _price.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _diskon,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Diskon',
                  hintText: 'Masukkan diskon sepatu',
                  suffixIcon: _diskon.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _diskon.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              TextFormField(
                controller: _color,
                validator: _validateKatalogSepatu,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  labelText: 'Color Sepatu',
                  hintText: 'Masukkan color sepatu',
                  suffixIcon: _color.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _color.clear();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 8.0),
              buildFilePicker(context),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 8.0,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          print(_pathFile.toString());
                          print(_namaFile.toString());
                          if (_brand.text.isEmpty ||
                              _name.text.isEmpty ||
                              _category.text.isEmpty ||
                              _price.text.isEmpty ||
                              _diskon.text.isEmpty ||
                              _color.text.isEmpty) {
                            displaySnackbar('Semua field harus diisi');
                            return;
                          }
                          final postModel = KatalogSepatuInput(
                            brand: _brand.text,
                            name: _name.text,
                            category: _category.text,
                            price: _price.text,
                            diskon: _diskon.text,
                            color: _color.text,
                            imagePath: _pathFile.toString(),
                            imageName: _namaFile.toString(),
                          );
                          KatalogSepatuResponse? res;

                          if (isEdit) {
                            res = await _dataService.putKatalogSepatu(
                                idKatalogSepatu, postModel);
                          } else {
                            res =
                                await _dataService.postKatalogSepatu(postModel);
                          }

                          setState(() {
                            katalogsepatuRes = res;
                            isEdit = false;
                          });
                          _brand.clear();
                          _name.clear();
                          _category.clear();
                          _price.clear();
                          _diskon.clear();
                          _color.clear();
                          _namaFile = null;
                          _pathFile = null;
                          await refreshKatalogSepatuList();
                        },
                        child: Text(isEdit ? 'UPDATE' : 'POST'),
                      ),
                      if (isEdit)
                        ElevatedButton(
                          onPressed: () {
                            _brand.clear();
                            _name.clear();
                            _category.clear();
                            _price.clear();
                            _diskon.clear();
                            _color.clear();
                            setState(() {
                              isEdit = false;
                            });
                          },
                          child: const Text('Cancel Update',
                              style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  )
                ],
              ),
              hasilCard(context),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          await refreshKatalogSepatuList();
                          setState(() {});
                        },
                        child: const Text('Refresh Data'),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _result = '-';
                          _katalogsepatuModel.clear();
                          katalogsepatuRes = null;
                        });
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'List Sepatu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: _katalogsepatuModel.isEmpty
                    ? Text(_result)
                    : _buildListKatalogSepatu(),
              ),
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

  Widget buildFilePicker(BuildContext context) {
    return TextField(
      controller: TextEditingController(text: _namaFile),
      readOnly: true,
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        labelText: 'Image Sepatu',
        hintText: 'Masukkan image sepatu',
        suffixIcon: _namaFile != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _namaFile = null;
                  });
                },
              )
            : IconButton(
                icon: const Icon(Icons.attach_file),
                onPressed: () async {
                  _pickFile();
                },
              ),
      ),
    );
  }

  Widget _buildListKatalogSepatu() {
    return ListView.separated(
        itemBuilder: (context, index) {
          final katalogsepatuList = _katalogsepatuModel[index];
          return Card(
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: katalogsepatuList.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(katalogsepatuList.brand),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      final katalogsepatus = await _dataService
                          .getSingleKatalogSepatu(katalogsepatuList.id);
                      setState(() {
                        if (katalogsepatus != null) {
                          _brand.text = katalogsepatus.brand;
                          _name.text = katalogsepatus.name;
                          _category.text = katalogsepatus.category;
                          _price.text = katalogsepatus.price;
                          _diskon.text = katalogsepatus.diskon;
                          _color.text = katalogsepatus.color;
                          // _namaFile = katalogsepatus.image;
                          isEdit = true;
                          idKatalogSepatu = katalogsepatus.id;
                        }
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      _showDeleteConfirmationDialog(
                          katalogsepatuList.id, katalogsepatuList.brand);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: _katalogsepatuModel.length);
  }

  Widget hasilCard(BuildContext context) {
    return Column(children: [
      if (katalogsepatuRes != null)
        KatalogSepatuCard(
          katalogsepatuRes: katalogsepatuRes!,
          onDismissed: () {
            setState(() {
              katalogsepatuRes = null;
            });
          },
        )
      else
        const Text(''),
    ]);
  }

  void _showDeleteConfirmationDialog(String id, String brand) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus data $brand ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                KatalogSepatuResponse? res =
                    await _dataService.deleteKatalogSepatu(id);
                setState(() {
                  katalogsepatuRes = res;
                });
                Navigator.of(context).pop();
                await refreshKatalogSepatuList();
              },
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
  }
}
