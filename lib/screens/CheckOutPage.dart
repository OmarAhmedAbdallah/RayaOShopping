import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:oshopping/Model/city.dart';
import 'package:oshopping/Model/government.dart';
import 'package:oshopping/providers/cart.dart';
import 'package:oshopping/providers/orders.dart';
import 'package:oshopping/providers/user_provider.dart';
import 'package:oshopping/themes/CustomTextStyle.dart';
import 'package:oshopping/widgets/app_bar.dart';
import 'package:oshopping/widgets/app_base.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import 'main_screen.dart';

class CheckOutPage extends StatefulWidget {
  static const routeName = '/checkOutPage_screen';
  final Map<String, List<String>> orderId;
  CheckOutPage(this.orderId);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final userProvider = UserProvider();
  List<Object> countriesDDl = [];
  final List<DropdownMenuItem> countries = [];
  bool invalidCity = false;
  bool invalidCountry = false;
  bool invalidPayment = false;
  int _myActivity;
  int _myCity;
  Future _getGoves;
  String _picked = "";
  bool _showcity = true;
  List<DropdownMenuItem> cities = [];
  int firstTime = 0;
  String address = "";
  String phone = "";
  Future<bool> buildFutures() async {
    return true;
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _saveForm() async {
    final cart = Provider.of<Cart>(context);
    final isValid = _formKey.currentState.validate();
    if (_myCity == null || _myCity == 0) {
      setState(() {
        invalidCity = true;
      });
    } else {
      setState(() {
        invalidCity = false;
      });
    }
    if (_myActivity == null || _myActivity == 0) {
      setState(() {
        invalidCountry = true;
      });
    } else {
      setState(() {
        invalidCountry = false;
      });
    }
    if (_picked == "") {
      setState(() {
        invalidPayment = true;
      });
    } else {
      setState(() {
        invalidPayment = false;
      });
    }
    if (!isValid) {
      _btnController.reset();
      return;
    }
    if (address == "") {}
    if (phone == "") {}
    _formKey.currentState.save();

    await Provider.of<Orders>(context, listen: false)
        .checkOut(_myActivity, _myCity, phone, address, _picked);
    // Provider.of<Orders>(context, listen: false).addOrder(
    //   cart.items.values.toList(),
    //   cart.totalAmount,
    // );
    cart.clear();
    _btnController.success();
    
    Timer(Duration(seconds: 1), () {
      _btnController.reset();
      Navigator.of(context).pushNamed(MainScreen.routeName);
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
  void initState() {
    super.initState();
    // _myActivity = '';
    // _myActivityResult = '';
  }

  String accountname = "";

  //form builder
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final cart = Provider.of<Cart>(context);
    String args = ModalRoute.of(context).settings.arguments;
    if (firstTime == 0) {
      _getGoves = userProvider.getGovernments();
      firstTime = 1;
    }
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Builder(builder: (context) {
          return AppBase(
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: ApplicationTopBar(pageName: tr("AboutUs")),
                  ),
                  regionSection(),
                  priceSection(cart),
                  button()
                  // RaisedButton(
                  //   onPressed: () {
                  //     /*Navigator.of(context).push(new MaterialPageRoute(
                  //               builder: (context) => OrderPlacePage()));*/
                  //     showThankYouBottomSheet(context);
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(4.0),
                  //     child: Text(
                  //       tr("ORDERNOW"),
                  //       style: CustomTextStyle.textFormFieldMedium.copyWith(
                  //           color: Colors.white,
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  //   color: Colors.pink,
                  //   textColor: Colors.white,
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("assets/images/helpImage.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                                "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: CustomTextStyle.textFormFieldMedium.copyWith(
                                fontSize: 14, color: Colors.grey.shade800),
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Track Order",
                        style: CustomTextStyle.textFormFieldMedium
                            .copyWith(color: Colors.white),
                      ),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(fontSize: 12, color: Colors.grey.shade800),
      ),
    );
  }

  addressAction() {
    return Container(
      child: Row(
        children: <Widget>[
          Spacer(
            flex: 2,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              "Edit / Change",
              style: CustomTextStyle.textFormFieldSemiBold
                  .copyWith(fontSize: 12, color: Colors.indigo.shade700),
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 3,
          ),
          Container(
            height: 20,
            width: 1,
            color: Colors.grey,
          ),
          Spacer(
            flex: 3,
          ),
          FlatButton(
            onPressed: () {},
            child: Text("Add New Address",
                style: CustomTextStyle.textFormFieldSemiBold
                    .copyWith(fontSize: 12, color: Colors.indigo.shade700)),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }

  standardDelivery() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border:
              Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Standard Delivery",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Get it by 20 jul - 27 jul | Free Delivery",
                style: CustomTextStyle.textFormFieldMedium.copyWith(
                  color: Colors.black,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  checkoutItem() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: ListView.builder(
            itemBuilder: (context, position) {
              return checkoutListItem();
            },
            itemCount: 3,
            shrinkWrap: true,
            primary: false,
            scrollDirection: Axis.vertical,
          ),
        ),
      ),
    );
  }

  checkoutListItem() {}

  regionSection() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FutureBuilder(
            future: _getGoves,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                default:
                  if (snapshot.hasError) {
                    return Container(
                      height: 500,
                      color: Colors.amber,
                    );
                  } else {
                    if (snapshot.data != null) {
                      // countries = [];
                      // countriesDDl = [];
                      for (Government gov in snapshot.data) {
                        countries.add(DropdownMenuItem(
                          child: Text(gov.name),
                          value: gov.code,
                        ));
                      }
                      return SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          autovalidate: false,
                          child: Column(
                            children: <Widget>[
                              SearchableDropdown.single(
                                iconSize: 25.0,
                                items: countries,
                                value: _myActivity,
                                hint: tr("SelectCountry"),
                                searchHint: tr("SelectCountry"),
                                onChanged: (value) async {
                                  setState(() {
                                    _myActivity = value;
                                    _showcity = false;
                                  });
                                  List<City> citiesTemp =
                                      await userProvider.getCities(value);
                                  setState(() {
                                    cities = [];
                                    for (City city in citiesTemp) {
                                      cities.add(DropdownMenuItem(
                                        child: Text(city.name),
                                        value: city.code,
                                      ));
                                    }
                                    _myCity = 0;
                                    _showcity = true;
                                    // setState(() {
                                    //   invalidCountry = false;
                                    // });
                                  });
                                },
                                doneButton: tr("Done"),
                                displayItem: (item, selected) {
                                  return (Row(children: [
                                    selected
                                        ? Icon(
                                            Icons.radio_button_checked,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.radio_button_unchecked,
                                            color: Colors.grey,
                                          ),
                                    SizedBox(
                                      width: 7,
                                      height: 15,
                                    ),
                                    Expanded(
                                      child: item,
                                    ),
                                  ]));
                                },
                                isExpanded: true,
                              ),
                              invalidCountry
                                  ? Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            tr("mandatory"),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              _showcity
                                  ? SearchableDropdown.single(
                                      iconSize: 25.0,
                                      items: cities,
                                      value: '',
                                      hint: tr("SelectCity"),
                                      searchHint: tr("SelectCity"),
                                      onChanged: (value) {
                                        setState(() {
                                          _myCity = value;
                                        });
                                      },
                                      doneButton: tr("Done"),
                                      displayItem: (item, selected) {
                                        return (Row(children: [
                                          selected
                                              ? Icon(
                                                  Icons.radio_button_checked,
                                                  color: Colors.grey,
                                                )
                                              : Icon(
                                                  Icons.radio_button_unchecked,
                                                  color: Colors.grey,
                                                ),
                                          SizedBox(
                                            width: 7,
                                            height: 15,
                                          ),
                                          Expanded(
                                            child: item,
                                          ),
                                        ]));
                                      },
                                      isExpanded: true,
                                    )
                                  : SizedBox(
                                      child: CircularProgressIndicator(),
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                              invalidCity
                                  ? Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            tr("mandatory"),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration:
                                      InputDecoration(labelText: tr("address")),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return tr('addressHint');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      address = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: tr("profile_phone")),
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return tr('MobileHint');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      phone = value;
                                    });
                                  },
                                ),
                              ),
                              RadioButtonGroup(
                                orientation:
                                    GroupedButtonsOrientation.HORIZONTAL,
                                margin: const EdgeInsets.only(top: 12.0),
                                onSelected: (String selected) => setState(() {
                                  _picked = selected;
                                }),
                                labels: <String>[
                                  tr("cach"),
                                  tr("bank"),
                                ],
                                picked: _picked,
                                itemBuilder: (Radio rb, Text txt, int i) {
                                  return Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0, horizontal: 12),
                                        child: txt,
                                      ),
                                      rb,
                                    ],
                                  );
                                },
                              ),
                              invalidPayment
                                  ? Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Text(
                                            tr("mandatory"),
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    } else
                      return CircularProgressIndicator();
                  }
              }
            },
          ),
        ],
      ),
    );
  }

  priceSection(Cart cart) {
    if (cart != null)
      return Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.grey.shade200)),
            padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  createPriceItem(
                      tr("Total"),
                      getFormattedCurrency(
                         cart.totalAmount.toString()),
                      Colors.grey.shade700),
                ]),
          ),
        ),
      );
    else
      Container();
  }

  String getFormattedCurrency(String amount) {
    return amount.toString() + "AED";
  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: Colors.grey.shade700, fontSize: 12),
          ),
          Text(
            value,
            style: CustomTextStyle.textFormFieldMedium
                .copyWith(color: color, fontSize: 12),
          )
        ],
      ),
    );
  }
}
