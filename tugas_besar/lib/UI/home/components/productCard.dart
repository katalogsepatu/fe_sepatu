import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';
import 'package:tugas_besar/constants.dart';

class KatalogSepatuCard extends StatelessWidget {
  final KatalogSepatuModel katalogSepatuModel;
  final VoidCallback press;

  const KatalogSepatuCard({Key? key, required this.katalogSepatuModel, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaulPadding,
        vertical: kDefaulPadding / 4,
      ),
      height: 160,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 136,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kSecondaryLightColor,
              boxShadow: [kDefaultShadow],
            ),
          ),
          Positioned(
            left: -20,
            child: Transform.rotate(
              angle: -180 / 360,
              child: Hero(
                tag: '${katalogSepatuModel.id}',
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
                  height: 140,
                  width: 200,
                  child: Image.network(
                    katalogSepatuModel.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: SizedBox(
              height: 136,
              width: size.width - 200,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kDefaulPadding, vertical: kDefaulPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      katalogSepatuModel.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      katalogSepatuModel.category,
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "\Rp.${katalogSepatuModel.price}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: press,
                          child: Container(
                            alignment: Alignment.center,
                            height: 25,
                            width: 60,
                            decoration: BoxDecoration(
                                color: kPrimaryLightColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Detail",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
