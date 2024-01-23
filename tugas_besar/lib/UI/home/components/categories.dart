import 'package:flutter/material.dart';
import 'package:tugas_besar/Models/Category/category.dart';
import 'package:tugas_besar/Service/apiService.dart';
import '../../../../constants.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;
  late List<Category> categories = [];
  final ApiServices _dataService = ApiServices();

  Future<void> getCategory() async {
    try {
      final response = await _dataService.getCategory('');
      if (response != null) {
        setState(() {
          categories = response
              .map((json) => Category.fromJson(json as Map<String, dynamic>))
              .toList();
        });
      } else {
        print('Error: Null response from getCategory');
      }
    } catch (error) {
      print('Error fetching categories: $error');
    }
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaulPadding / 2),
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
                left: kDefaulPadding,
                right: index == categories.length - 1 ? kDefaulPadding : 0),
            padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
            decoration: BoxDecoration(
                color: index == selectedIndex
                    ? kPrimaryLightColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              categories[index].kategori,
              style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
