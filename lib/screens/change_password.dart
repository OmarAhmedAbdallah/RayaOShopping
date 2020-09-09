import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/http_exception.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/themes/light_color.dart';
import 'package:oshopping/widgets/shared_widgets/bezierContainer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({Key key, this.title}) : super(key: key);
  static const routeName = '/change-password';
  final String title;

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'password': '',
  };
  final _passwordController = TextEditingController();
  final _passwordNewController = TextEditingController();
  String passwordData = "";
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    asyncInitState();
  }

  void asyncInitState() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedUserData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    passwordData = extractedUserData['password'];
  }

  var _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(""),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text(tr('Done')),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushNamed(MainScreen.routeName);
            },
          )
        ],
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
                color: Colors.grey.shade200,
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
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    // Sign user up
    try {
      await Provider.of<Auth>(context, listen: false).changePassword(
        _authData['password'],
      );
      var errorMessage = tr('chng_pass_success');
      _showSuccessDialog(errorMessage);
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height + 100;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: tr("old_password")),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return tr('empty_password');
                          } else if (passwordData != value) {
                            return tr('wrongPass');
                          }
                        },
                        onSaved: (value) {},
                      ),

                      TextFormField(
                        decoration:
                            InputDecoration(labelText: tr("new_password")),
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
                          _authData['password'] = value;
                        },
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: InputDecoration(
                            labelText: tr("confirm_new_password")),
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordNewController.text) {
                            return tr('password_dont_match');
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //End Form
                      SizedBox(
                        height: 20,
                      ),
                      if (_isLoading)
                        CircularProgressIndicator()
                      else
                        _submitButton(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
