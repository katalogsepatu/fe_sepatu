import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Product/product.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';
import 'package:tugas_besar/constants.dart';

import 'components/body.dart';

class DetailScreen extends StatelessWidget {
  final KatalogSepatuModel katalogSepatuModel;

  const DetailScreen({Key? key, required this.katalogSepatuModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: Body(
        KatalogSepatuModel: KatalogSepatuModel,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaulPadding),
        color: Colors.white,
        icon: Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: kDefaulPadding),
          onPressed: () {},
          icon: Icon(Icons.favorite_border),
        )
      ],
    );
  }
}
