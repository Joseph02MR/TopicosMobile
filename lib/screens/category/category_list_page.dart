import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/new/users.dart';
import 'package:ecommerce_int2/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/new/order.dart';
import 'components/staggered_category_card.dart';

class CategoryListPage extends StatefulWidget {
  final Users userdata;
  var isLoaded = false;
  CategoryListPage(this.userdata);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState extends State<CategoryListPage> {
  /*List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadgets',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/jeans_5.png',
    ),
    Category(
      Color(0xffF123C4),
      Color(0xff668CEA),
      'Appliances',
      'assets/jeans_5.png',
    ),
  ];
   */

  List<Order>? searchResults = [];
  //TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //searchResults = categories
    get_data();
  }

  get_data() async {
    searchResults = await RemoteService().getUserOrders(widget.userdata.id);
    print(searchResults?.length);
    if (searchResults != null) {
      setState(() {
        widget.isLoaded = true;
      });
      searchResults?.forEach((element) {
        get_products(element);
      });
      return;
    }
  }

  void get_products(Order order) async {
    try{
      order.prods_aux = (await RemoteService().getOrderProducts(order.products))!;
      print(order.prods_aux.length);
    }catch(error){
      order.prods_aux = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xffF9F9F9),
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment(-1, 0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Text(
                  'Orders List',
                  style: TextStyle(
                    color: darkGrey,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.isLoaded,
                child: Flexible(
              child: ListView.builder(
                itemCount: searchResults?.length,
                itemBuilder: (_, index) => Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: OrderCard(
                    //begin: searchResults[index].begin,
                    //end: searchResults[index].end,
                    begin: Color(0xffFCE183),
                    end: Color(0xffF68D7F),
                    orderName: "Order ${index + 1}",
                    order: searchResults![index],
                    //assetPath: searchResults[index].image,
                  ),
                ),
              ),
            ), replacement: const Center(
              child: CircularProgressIndicator(),
            )),
          ],
        ),
      ),
    );
  }
}
