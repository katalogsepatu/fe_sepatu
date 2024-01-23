import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'listOfColors.dart';
import 'productImage.dart';

class Body extends StatelessWidget {
  final KatalogSepatuModel;
  const Body({
    Key? key,
    required this.KatalogSepatuModel,
  }) : super(key: key);
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
                )),
            child: Column(
              children: <Widget>[
                Hero(
                    tag: '${KatalogSepatuModel.id}',
                    child: KatalogSepatuModelImage(
                      size: size,
                      image: KatalogSepatuModel.image,
                    )),
                ListOfColors()
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
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 15),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.shopping_cart_rounded),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: 15),
                    height: 45,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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
