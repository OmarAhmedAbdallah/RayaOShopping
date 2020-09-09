import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/Model/http_exception.dart';
import 'package:oshopping/providers/auth.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/themes/light_color.dart';
import '../shared_widgets/bezierContainer.dart';
import 'loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);
  static const routeName = '/sign-up';
  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'lastName': '',
    'firstName': '',
    'phone': '',
    'password': '',
  };
  final _passwordController = TextEditingController();

  var _isLoading = false;
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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: LightColor.lightGrey,
                  filled: true))
        ],
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
          tr('register_title'),
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(LoginPage.routeName);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr('AlreadyHaveAccount'),
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              tr('login'),
              style: TextStyle(
                  color: LightColor.secondaryColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.purple,
          ),
          children: [
            TextSpan(
              text: 'Ra',
              style: TextStyle(color: LightColor.brandFirstColor, fontSize: 30),
            ),
            TextSpan(
              text: ' Ya',
              style:
                  TextStyle(color: LightColor.brandSecondColor, fontSize: 30),
            ),
          ]),
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
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['firstName'],
        _authData['lastName'],
        _authData['phone'],
        _authData['password'],
      );
      if (Auth.isAuth) {
        Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
      }
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
      _showErrorDialog("");
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Widget _emailPasswordWidget() {
  //   return Column(
  //     children: <Widget>[
  //       _entryField(tr("full_name")),
  //       _entryField(tr("email")),
  //       _entryField(tr("password"), isPassword: true),
  //     ],
  //   );
  // }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(tr("full_name")),
        _entryField(tr("email")),
        _entryField(tr("password"), isPassword: true),
      ],
    );
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
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
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
                      SizedBox(
                        height: 50,
                      ),
                      //_emailPasswordWidget(),
                      //start Form
                      TextFormField(
                        decoration: InputDecoration(labelText: tr("email")),
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
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: tr("firstName")),
                        validator: (value) {
                          if (value.isEmpty) {
                            return tr('firstNameHint');
                          }
                        },
                        onSaved: (value) {
                          _authData['firstName'] = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: tr("lastName")),
                        validator: (value) {
                          if (value.isEmpty) {
                            return tr('lastNameHint');
                          }
                        },
                        onSaved: (value) {
                          _authData['lastName'] = value;
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: tr("MobileLable")),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return tr('MobileHint');
                          }
                        },
                        onSaved: (value) {
                          _authData['phone'] = value;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: tr("password")),
                        obscureText: true,
                        controller: _passwordController,
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
                        decoration:
                            InputDecoration(labelText: tr("confirm_password")),
                        obscureText: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
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
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(height: height * .01),
                      _loginAccountLabel(),
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
