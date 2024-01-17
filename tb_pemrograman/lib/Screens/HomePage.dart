import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tb_pemrograman/Component/defaultElements.dart';
import 'package:tb_pemrograman/Models/ShoeListModel.dart';
import 'package:tb_pemrograman/Models/categoriesModels.dart';
import 'package:tb_pemrograman/Models/katalog_sepatu.dart';
import 'package:tb_pemrograman/Screens/itemsCard.dart';
import 'package:tb_pemrograman/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final _formKey = GlobalKey<FormState>();
  final _brandCtl = TextEditingController();
  final _nameCtl = TextEditingController();
  String _result = '-';
  final ApiServices _dataService = ApiServices();
  List<KatalogSepatuModel> _katalogSepatuMdl = [];
  KatalogSepatuResponse? ctRes;
  bool isEdit = false;
  String idContact = '';
  String token = '';

  late SharedPreferences logindata;
  String email = '';

  Future<void> refreshContactList() async {
    final users = await _dataService.getAllKatalogSepatu();
    setState(() {
      if (_katalogSepatuMdl.isNotEmpty) _katalogSepatuMdl.clear();
      if (users != null) _katalogSepatuMdl.addAll(users);
    });
  }

  @override
  void initState() {
    super.initState();
    inital();
  }

  void inital() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString('email').toString();
      token = logindata.getString('token').toString();
    });
  }

  @override
  void dispose() {
    _brandCtl.dispose();
    _nameCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DefaultElements.kdefaultbgcolor,
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppBar(),
              buildProductSection(),
              SizedBox(
                height: 20,
              ),
              // buildCategoriesSection(context),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    itemCount: shoeListModel.length,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => Itemcards(
                      shoeListModel: shoeListModel[index],
                      index: index,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  buildAppBar() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/menu.svg",
              height: 25,
            ),
            Expanded(
              child: Container(),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "X",
                    style: TextStyle(
                      color: DefaultElements.kprimarycolor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
                TextSpan(
                  text: "E",
                  style: TextStyle(
                    color: DefaultElements.ksecondrycolor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
            Expanded(
              child: Container(),
            ),
            SvgPicture.asset(
              "assets/icons/search_icon.svg",
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildProductSection() {
    return Padding(
      padding: EdgeInsets.only(left: 25, top: 10, right: 25),
      child: Row(
        children: [
          Text(
            "New Product",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            "Sort by",
            style: TextStyle(
              color: DefaultElements.knavbariconcolor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            size: 15,
            color: DefaultElements.knavbariconcolor,
          )
        ],
      ),
    );
  }

  buildCategoriesSection(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: categoriesModel.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      selectedIndex == index
                          ? BoxShadow(
                              color: DefaultElements.knavbariconcolor,
                              blurRadius: 10,
                              offset: Offset(0, -1))
                          : BoxShadow()
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "${categoriesModel[index].image}",
                      height: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${categoriesModel[index].title}",
                      style: TextStyle(
                        color: selectedIndex == index
                            ? DefaultElements.kprimarycolor
                            : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFF475629),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.category_outlined,
            color: Colors.white,
            size: 32,
          ),
          InkWell(
            onTap: () {
              // showSlidingBottomSheet(
              //   context,
              //   builder: (context) {
              //     return SlidingSheetDialog(
              //       elevation: 8,
              //       cornerRadius: 16,
              //       builder: (context, state) {
              //         return BottomCartSheet();
              //       },
              //     );
              //   },
              // );
            },
            child: Icon(
              CupertinoIcons.cart_fill,
              color: Colors.white,
              size: 32,
            ),
          ),
          Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 32,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 32,
          ),
        ],
      ),
    );
  }
}
