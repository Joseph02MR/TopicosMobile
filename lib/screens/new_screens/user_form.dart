import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/services/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import '../../models/new/users.dart';

class UserForm extends StatefulWidget {
  final Users userdata;

  UserForm(this.userdata);

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  //Color active = Colors.red;
  bool text_editing = true;
  TextEditingController Name = TextEditingController();
  TextEditingController Lastname = TextEditingController();
  TextEditingController Username = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Phone = TextEditingController();

  ScrollController scrollController = ScrollController();

  List _genders = ["male", "female"];

  late List<DropdownMenuItem<String>> _dropDownMenuItems;
  late String _currentGender = widget.userdata.gender;

  @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentGender = widget.userdata.gender == _dropDownMenuItems[0].value!
        ? _dropDownMenuItems[0].value!
        : _dropDownMenuItems[1].value!;
    Fill_form();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection.index == 1) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  void changedDropDownItem(String? selectedGender) {
    setState(() {
      _currentGender = selectedGender!;
    });
  }

  void update_editing() {
    setState(() {
      text_editing = text_editing ? false : true;
    });
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String gender in _genders) {
      items.add(new DropdownMenuItem(value: gender, child: new Text(gender)));
    }
    return items;
  }

  void Fill_form() {
    Name.text = widget.userdata.name;
    Lastname.text = widget.userdata.lastname;
    Username.text = widget.userdata.username;
    Email.text = widget.userdata.email;
    Phone.text = widget.userdata.phone;
  }

  Future<bool> update_user_data() async {
    Map<String, String> body = {
      "name": Name.text,
      "lastname": Lastname.text,
      "username": Username.text,
      "email": Email.text,
      "phone": Phone.text,
      "gender": _currentGender
    };
    var aux = RemoteService().updateUser(body, widget.userdata.id);
    if (await aux) {
      widget.userdata.name = Name.text;
      widget.userdata.lastname = Lastname.text;
      widget.userdata.username = Username.text;
      widget.userdata.email = Email.text;
      widget.userdata.phone = Phone.text;
      widget.userdata.gender = _currentGender;
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
                          'User data updated successfully',
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
          child: Text("Update profile",
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
                          'Profile data',
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
                      height: 400,
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
                              controller: Name,
                              onChanged: (val) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Name'),
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
                              controller: Lastname,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Lastname'),
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
                              controller: Email,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Email'),
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
                              controller: Username,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Username'),
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
                              controller: Phone,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Phone'),
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
                              child: new DropdownButton(
                                value: _currentGender,
                                items: _dropDownMenuItems,
                                onChanged: changedDropDownItem,
                              )),
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
