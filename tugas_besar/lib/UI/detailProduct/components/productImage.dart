import 'package:flutter/material.dart';
import 'package:tugas_besar/Service/apiService.dart';

import '../../../constants.dart';

class KatalogSepatuModelImage extends StatelessWidget {
  const KatalogSepatuModelImage({
    Key? key,
    required this.size,
    required this.image,
  }) : super(key: key);

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaulPadding / 4),
      height: size.width * 0.7,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: size.width * 0.6,
            width: size.width * 0.6,
            decoration: BoxDecoration(
              color: kPrimaryLightColor,
              shape: BoxShape.circle,
            ),
          ),
          Transform.rotate(
            angle: -180 / 360,
            child: Image.network(
              image, // Use the 'image' parameter instead of '_dataService.KatalogSepatuModel'
              height: size.width * 0.8,
              width: size.width * 0.8,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
