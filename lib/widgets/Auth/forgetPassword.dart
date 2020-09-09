import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:provider/provider.dart';

import '../shared_widgets/bezierContainer.dart';
import 'loginPage.dart';

class ForgetPage extends StatefulWidget {
  ForgetPage({Key key, this.title}) : super(key: key);
  static const routeName = '/forget-password';
  final String title;

  @override
  _ForgetPageState createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  var _isReset = false;
  final _passwordController = TextEditingController();
  final _passwordNewController = TextEditingController();
  Map<String, String> _authData = {'email': ''};
  String password = "";
  String code = "";
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushNamed(LoginPage.routeName);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(tr('Back'),
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushNamed(MainScreen.routeName);
        FocusScope.of(context).requestFocus(new FocusNode());
        _submit();
        // Navigator.of(context).pushNamed(ProductsOverviewScreen.routeName);
        // Navigator.of(context).pushNamed(NavigationHomeScreen.routeName);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: LightColor.grey,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [LightColor.secondaryColor, LightColor.lightWhite],
          ),
        ),
        child: Text(
          tr('change_password'),
          style: TextStyle(fontSize: 20, color: LightColor.black),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(tr('errorBox')),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(tr('Okay')),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _formKey.currentState.save();
    try {
      await Provider.of<Auth>(context, listen: false).forgetPassword(
          _authData['email'],
          code: code,
          password: password,
          isReset: _isReset);
      if (_isReset) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.of(context).pushNamed(LoginPage.routeName);
      }
      setState(() {
        _isReset = true;
      });
    } on HttpException catch (error) {
      var errorMessage = error.toString();
      // if (error.toString().contains('EMAIL_EXISTS')) {
      //   errorMessage = 'This email address is already in use.';
      // } else if (error.toString().contains('INVALID_EMAIL')) {
      //   errorMessage = 'This is not a valid email address';
      // } else if (error.toString().contains('WEAK_PASSWORD')) {
      //   errorMessage = 'This password is too weak.';
      // } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
      //   errorMessage = 'Could not find a user with that email.';
      // } else if (error.toString().contains('INVALID_PASSWORD')) {
      //   errorMessage = 'Invalid password.';
      // }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(error.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        Image.asset(
                          "assets/images/logoSm.png",
                          width: 150,
                        ),
                        SizedBox(height: 50),
                        //start Form
                        !_isReset
                            ? TextFormField(
                                decoration:
                                    InputDecoration(labelText: tr("email")),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return tr('empty_email');
                                  } else if (!value.contains('@')) {
                                    return tr('wrong_email_format');
                                  }
                                },
                                onSaved: (value) {
                                  _authData['email'] = value;
                                },
                              )
                            : Container(),
                        _isReset
                            ? Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    child: Text(
                                      tr("resetMsg"),
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        _isReset
                            ? TextFormField(
                                enabled: true,
                                keyboardType: TextInputType.number,
                                decoration:
                                    InputDecoration(labelText: tr("Code")),
                                validator: (value) {
                                  setState(() {
                                    code = value;
                                  });
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        _isReset
                            ? TextFormField(
                                decoration: InputDecoration(
                                    labelText: tr("new_password")),
                                obscureText: true,
                                controller: _passwordNewController,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return tr('empty_password');
                                  } else if (value.length < 7) {
                                    return tr('wrong_password_format');
                                  }
                                },
                                onSaved: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              )
                            : Container(),
                        _isReset
                            ? TextFormField(
                                enabled: true,
                                decoration: InputDecoration(
                                    labelText: tr("confirm_new_password")),
                                obscureText: true,
                                validator: (value) {
                                  if (value != _passwordNewController.text) {
                                    return tr('password_dont_match');
                                  }
                                },
                              )
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        //End Form
                        if (_isLoading)
                          CircularProgressIndicator()
                        else
                          _submitButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
}
