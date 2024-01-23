import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tugas_besar/Models/Category/category.dart';
import 'package:tugas_besar/Models/katalog_sepatu.dart';
import 'package:tugas_besar/Service/apiService.dart';
import 'package:tugas_besar/UI/detailProduct/detailScreen.dart';
import 'package:tugas_besar/UI/home/components/productCard.dart';
import 'package:tugas_besar/constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _dataService = ApiServices();
  late TextEditingController search;
  final PagingController<int, KatalogSepatuModel> _pagingController =
      PagingController(firstPageKey: 0);
  int selectedIndex = 0;
  String idKategori = "";

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
      final newItems = await _dataService.getAllKatalogSepatu();
      final itemList = newItems?.toList() ?? [];

      final isLastPage = itemList.length < _pagingController.itemList!.length;

      if (isLastPage) {
        _pagingController.appendLastPage(itemList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(itemList, nextPageKey);
      }
    } catch (error) {
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
          CategoryList(), // Added the CategoryList widget here
          SizedBox(height: 10),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                ),
                Container(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () => _pagingController.refresh(),
                    ),
                    child: PagedListView<int, KatalogSepatuModel>(
                      pagingController: _pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<KatalogSepatuModel>(
                        itemBuilder: (context, item, index) => Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    katalogSepatuModel: item,
                                  ),
                                ),
                              );
                            },
                            child: KatalogSepatuCard(
                              katalogSepatuModel: item,
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      katalogSepatuModel: item,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryList extends StatelessWidget {
  Null get selectedIndex => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kDefaulPadding / 2),
      height: 30,
      child: FutureBuilder<List<Category>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading categories: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No categories available'));
          } else {
            List<Category> categories = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Add your logic here
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    left: kDefaulPadding,
                    right: index == categories.length - 1 ? kDefaulPadding : 0,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: kDefaulPadding),
                  decoration: BoxDecoration(
                    color: index == selectedIndex
                        ? kPrimaryLightColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    categories[index].kategori,
                    style: TextStyle(
                      color:
                          index == selectedIndex ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          }
        },
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

Future<List<Category>> fetchData() async {
  // Your fetchData logic here
  return [];
}
