import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../models/new/users.dart';

class AddressForm extends StatefulWidget {
  final Users userdata;

  AddressForm(this.userdata);

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  //Color active = Colors.red;
  bool text_editing = true;
  TextEditingController Street = TextEditingController();
  TextEditingController Zip = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController Country = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    Fill_form();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection.index == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  void update_editing() {
    setState(() {
      text_editing = text_editing ? false : true;
    });
  }

  void Fill_form() {
    Street.text = widget.userdata.street;
    Zip.text = widget.userdata.zip;
    City.text = widget.userdata.city;
    Country.text = widget.userdata.country;
  }

  Future<bool> update_user_data() async {
    Map<String, String> body = {
      "street": Street.text,
      "zip": Zip.text,
      "city": City.text,
      "country": Country.text
    };
    var aux = RemoteService().updateUser(body, widget.userdata.id);
    if (await aux) {
      widget.userdata.street = Street.text;
      widget.userdata.zip = Zip.text;
      widget.userdata.city = City.text;
      widget.userdata.country = Country.text;
    }
    return aux;
  }

  _showSimpleModalDialog(context) async {
    try {
      await update_user_data();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Info',
                              style: TextStyle(
                                color: darkGrey,
                                fontSize: 22,
                              ),
                            ),
                            CloseButton()
                          ],
                        ),
                        Text(
                          'Address data updated successfully',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ));
          });
    } catch (Error) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                child: Container(
                  constraints: BoxConstraints(maxHeight: 150),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Info',
                              style: TextStyle(
                                color: darkGrey,
                                fontSize: 22,
                              ),
                            ),
                            CloseButton()
                          ],
                        ),
                        Text(
                          'Error during data update',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget addThisCard = InkWell(
      onTap: () => {
        _showSimpleModalDialog(context),
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ProfilePage(widget.userdata))),
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Update address",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) => GestureDetector(
          onPanDown: (val) {},
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            controller: scrollController,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: kToolbarHeight),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Address data',
                          style: TextStyle(
                            color: darkGrey,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CloseButton()
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(16.0),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              enabled: text_editing,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(16)
                              ],
                              controller: Street,
                              onChanged: (val) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'street'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              enabled: text_editing,
                              controller: Zip,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'zip code'),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              enabled: text_editing,
                              controller: City,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'City'),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 16.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.grey[200],
                            ),
                            child: TextField(
                              enabled: text_editing,
                              controller: Country,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Country'),
                              onChanged: (val) {
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.0),
                    Center(
                        child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: addThisCard,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
