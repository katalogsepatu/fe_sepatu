import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Product/product.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/product/detailProduct/detailProduct_screen.dart';
import 'package:tugas_besar/Widget/Components/searchBox.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: kSecondaryLightColor,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Tittle(),
                SearchBox(),
              ],
            ),
          ),
          // Expanded(
          //   child: FutureBuilder<List<KatalogSepatuModel>>(
          //     future: APIService.getProductBySeller(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return Center(child: CircularProgressIndicator());
          //       } else {
          //         List<KatalogSepatuModel> products = snapshot.data!;
          //         return Container(
          //           margin: EdgeInsets.symmetric(horizontal: kDefaulPadding),
          //           child: GridView.builder(
          //               scrollDirection: Axis.vertical,
          //               shrinkWrap: true,
          //               itemCount: products.length,
          //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 2,
          //                 mainAxisSpacing: kDefaulPadding,
          //                 crossAxisSpacing: kDefaulPadding,
          //               ),
          //               itemBuilder: (context, index) => ProductCard(
          //                     itemIndex: index,
          //                     product: products[index],
          //                     press: () {
          //                       Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => DetailScreen(
          //                                     KatalogSepatuModel: products[index],
          //                                   )));
          //                     },
          //                   )),
          //         );
          //       }
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  Container Tittle() {
    return Container(
      margin: EdgeInsets.only(top: kDefaulPadding, left: kDefaulPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Welcome, Seller!",
            style: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w700,
                fontSize: 24),
          ),
          Text(
            "Add Your best Product",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class KatalogSepatuCard extends StatelessWidget {
   KatalogSepatuCard({
    Key? key,
    required this.itemIndex,
    required this.KatalogSepatuModel,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final KatalogSepatuModel;
  final VoidCallback press;
  final ApiServices _dataService = ApiServices();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.network(
               KatalogSepatuModel.image,
              fit: BoxFit.contain,
              height: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              KatalogSepatuModel.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
            Text(
              "\Rp. ${KatalogSepatuModel.price}",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
            Text(
              "\Stok ${KatalogSepatuModel.stok}",
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
