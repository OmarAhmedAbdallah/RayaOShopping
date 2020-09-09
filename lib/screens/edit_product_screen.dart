import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oshopping/Model/user.dart';
import 'package:oshopping/providers/user_provider.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  User _user;

  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _user = Provider.of<UserProvider>(context, listen: false).appUser();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('.png') &&
              !_imageUrlController.text.endsWith('.jpg') &&
              !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      _btnController.reset();
      return;
    }
    _form.currentState.save();

    Provider.of<UserProvider>(context, listen: false).updateUser(_user);
    _btnController.success();
    Timer(Duration(seconds: 1), () {
      _btnController.reset();
    });
  }

  Widget button() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RoundedLoadingButton(
            child: Text(
              tr("save"),
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            controller: _btnController,
            onPressed: _saveForm,
            width: 100,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/'),
            );
            Navigator.of(context).pushNamed(MainScreen.routeName);
          },
          child: Icon(
            LineAwesomeIcons.arrow_left,
            size: ScreenUtil().setSp(AppTheme.kSpacingUnit.w * 3),
          ),
        ),
        SizedBox(width: AppTheme.kSpacingUnit.w * 3),
      ],
    );
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: AppTheme.kSpacingUnit.w * 5),
            header,
            Expanded(
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _user.email,
                      decoration: InputDecoration(labelText: tr("email")),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return tr('empty_email');
                        } else if (!value.contains('@')) {
                          return tr('wrong_email_format');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _user = User(
                          email: value,
                          firstName: _user.firstName,
                          lastName: _user.lastName,
                          phone: _user.phone,
                          password: _user.password,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _user.firstName,
                      decoration: InputDecoration(labelText: tr("firstName")),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      focusNode: _firstNameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return tr('firstNameHint');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _user = User(
                          email: _user.email,
                          firstName: value,
                          lastName: _user.lastName,
                          phone: _user.phone,
                          password: _user.password,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _user.lastName,
                      decoration: InputDecoration(labelText: tr("lastName")),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      focusNode: _lastNameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return tr('lastNameHint');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _user = User(
                          email: _user.email,
                          firstName: _user.firstName,
                          lastName: value,
                          phone: _user.phone,
                          password: _user.password,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _user.phone,
                      decoration:
                          InputDecoration(labelText: tr("profile_phone")),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value.isEmpty) {
                          return tr('MobileHint');
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _user = User(
                          email: _user.email,
                          firstName: _user.firstName,
                          lastName: _user.lastName,
                          phone: value,
                          password: _user.password,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: button(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
