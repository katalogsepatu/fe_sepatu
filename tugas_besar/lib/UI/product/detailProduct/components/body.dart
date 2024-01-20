import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Product/product.dart';
import 'package:tugas_besar/Models/errormsg.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/detailProduct/components/descriptionProduct.dart';
import 'package:tugas_besar/UI/detailProduct/components/listOfColors.dart';
import 'package:tugas_besar/UI/detailProduct/components/productImage.dart';
import 'package:tugas_besar/UI/main/main.dart';
import 'package:tugas_besar/UI/product/editProduct/editProduct_screen.dart';
import '../../../../constants.dart';

class Body extends StatelessWidget {
  final ApiServices _dataService = ApiServices();
  final KatalogSepatuModel;
  
  Body({
    Key? key,
    required this.KatalogSepatuModel,
  }) : super(key: key);

  Future<bool> deleteKatalogSepatu() async {
    late ErrorMSG response;
    late bool _success = false;
    var id = KatalogSepatuModel.id;

    response = await _dataService.deleteKatalogSepatu(id);
    _success = response.success;
    return _success;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: <Widget>[
                Hero(
                  tag: '${KatalogSepatuModel.id}',
                  child: KatalogSepatuModelImage(
                    size: size,
                    image: KatalogSepatuModel.image,
                  ),
                ),
                ListOfColors(),
              ],
            ),
          ),
          // DescriptionProduct(
          //   size: size,
          //   product: KatalogSepatuModel,
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditKatalogSepatu(
                          KatalogSepatuModel: KatalogSepatuModel,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 15),
                    height: 45,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Edit Product",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    bool _success = await deleteKatalogSepatu();

                    if (_success) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Product Deleted"),
                        ),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 15),
                    height: 45,
                    width: size.width * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xFFd62828),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Delete Product",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
