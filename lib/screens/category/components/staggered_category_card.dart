import 'package:ecommerce_int2/models/new/order.dart';
import 'package:flutter/material.dart';

import '../../../app_properties.dart';
import '../../../services/remote_service.dart';

class OrderCard extends StatelessWidget {
  final Color begin;
  final Color end;
  final String orderName;
  final Order order;

  OrderCard({
    required this.begin,
    required this.end,
    required this.orderName,
    required this.order

  });

  List<String>? searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [begin, end],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
              alignment: Alignment(-1, 0),
              child: Text(
                orderName,
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () => {
                  //Navigator.of(context)
                  //    .push(MaterialPageRoute(builder: (_) => NotificationsPage()))

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Container(
                              constraints: BoxConstraints(maxHeight: 450),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order data',
                                          style: TextStyle(
                                            color: darkGrey,
                                            fontSize: 22,
                                          ),
                                        ),
                                        CloseButton()
                                      ],
                                    ),
                                    Text(
                                      'Date',
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      order.date.toString().split(" ").first,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Status',
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      order.status,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      order.destAddress,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Products',
                                      style: TextStyle(
                                        color: darkGrey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Flexible(
                                      child: ListView.builder(
                                        itemCount: order.prods_aux.length,
                                        itemBuilder: (_, index) => Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 4.0,
                                          ),
                                          child: Text(
                                            order.prods_aux[index],
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              color: darkGrey,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ),
                            ));
                      })
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(24))),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'View more',
                    style: TextStyle(color: end, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
