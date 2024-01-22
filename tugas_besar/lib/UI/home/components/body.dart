import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Category/category.dart';
import 'package:tugas_besar/Models/Product/product.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/detailProduct/detailScreen.dart';
import 'package:tugas_besar/UI/home/components/productCard.dart';
import 'package:tugas_besar/UI/product/components/body.dart';
import 'package:tugas_besar/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _dataService = ApiServices();
  final _formKey = GlobalKey<FormState>();
  String _result = '-';
  List<KatalogSepatuModel> _katalogsepatuMdl = [];
  KatalogSepatuResponse? ctRes;
  bool isEdit = false;
  late TextEditingController search;
  final PagingController<int, KatalogSepatuModel> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
  try {
    final newItems = await _dataService.getAllKatalogSepatu(pageKey, search.text);
    final isLastPage = newItems.length < _pagingController.pageSize;

    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  } catch (error) {
    // Handle the error appropriately
    _pagingController.error = error;
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Heading(),
          Container(
            margin: EdgeInsets.all(kDefaulPadding),
            padding: EdgeInsets.symmetric(
              horizontal: kDefaulPadding,
            ),
            decoration: BoxDecoration(
              color: kSecondaryLightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: search,
              onChanged: (value) {
                _pagingController.refresh();
              },
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                icon: Icon(
                  Icons.search,
                  color: kPrimaryColor,
                ),
                hintText: "Search..",
              ),
            ),
          ),
          // Rest of your code...
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaulPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Best Product",
            style: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          Text(
            "Perfect Choice!",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
