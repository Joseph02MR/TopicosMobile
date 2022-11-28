import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/new/users.dart';
import 'package:ecommerce_int2/screens/settings/settings_page.dart';
import 'package:ecommerce_int2/services/remote_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  final Users userdata;

  ChangePasswordPage(this.userdata);
  
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  //TextEditingController old = TextEditingController();
  TextEditingController new_pass = TextEditingController();
  TextEditingController conf_pass = TextEditingController();


  Future<bool> update_user_data() async {
    if(new_pass.text == conf_pass.text){
      Map<String, String> body = {
        "password": new_pass.text,
      };
      return RemoteService().updateUser(body, widget.userdata.id);
    }
    else{
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
                          'Error during password update: passwords don\'t match',
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
    return false;
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
                          'password updated successfully',
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
                          'Error during password update',
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
    double width = MediaQuery.of(context).size.width;
    double bottomPadding = MediaQuery.of(context).padding.bottom;

    Widget changePasswordButton = InkWell(
      onTap: () {
        _showSimpleModalDialog(context);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => SettingsPage(widget.userdata)));
        },
      child: Container(
        height: 80,
        width: width / 1.5,
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
          child: Text("Confirm Change",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          bottom: true,
          child: LayoutBuilder(
            builder: (b, constraints) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 48.0, top: 16.0),
                            child: Text(
                              'Change Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                          ),
                          /*Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Text(
                              'Enter your current password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextField(
                                controller: old,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Existing Password',
                                    hintStyle: TextStyle(fontSize: 12.0)),
                              )),
                              
                           */
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24, bottom: 12.0),
                            child: Text(
                              'Enter new password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextField(
                                controller: new_pass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'New Password',
                                    hintStyle: TextStyle(fontSize: 12.0)),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 24, bottom: 12.0),
                            child: Text(
                              'Retype new password',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: TextField(
                                controller: conf_pass,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Retype Password',
                                    hintStyle: TextStyle(fontSize: 12.0)),
                              )),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 8.0,
                              bottom: bottomPadding != 20 ? 20 : bottomPadding),
                          width: width,
                          child: Center(child: changePasswordButton),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
