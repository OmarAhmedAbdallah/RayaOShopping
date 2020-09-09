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

class CustomForm extends StatefulWidget {
  static const routeName = '/CustomForm_screen';
  final Map<String, List<String>> orderId;
  CustomForm(this.orderId);
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  final _formKey = GlobalKey<FormState>();

  final userProvider = UserProvider();
  List<Object> countriesDDl = [];
  final List<DropdownMenuItem> countries = [];
  final List<DropdownMenuItem> catDDL = [
    DropdownMenuItem(
      child: Text("Meal Box"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("Pizza box"),
      value: 2,
    ),
  ];
  final List<DropdownMenuItem> pizzaSizeDDL = [
    DropdownMenuItem(
      child: Text("22x22x4 cm"),
      value: 1,
    ),
    DropdownMenuItem(
      child: Text("28x28x4 cm"),
      value: 2,
    ),
    DropdownMenuItem(
      child: Text("33x33x4 cm"),
      value: 2,
    ),
  ];
  final List<DropdownMenuItem> sizeDDL = [
    DropdownMenuItem(
      child: Text("4oz"),
      value: 4,
    ),
    DropdownMenuItem(
      child: Text("8oz"),
      value: 8,
    ),
    DropdownMenuItem(
      child: Text("12oz"),
      value: 12,
    ),
  ];
  List<DropdownMenuItem> sizeDDLCat5 = [
    DropdownMenuItem(
      child: Text("200GSM"),
      value: 200,
    ),
    DropdownMenuItem(
      child: Text("250GSM"),
      value: 250,
    ),
    DropdownMenuItem(
      child: Text("300GSM"),
      value: 300,
    ),
    DropdownMenuItem(
      child: Text("350GSM"),
      value: 350,
    ),
    DropdownMenuItem(
      child: Text("400GSM"),
      value: 5,
    ),
  ];
  bool invalidCity = false;
  bool invalidCountry = false;
  bool invalidPayment = false;
  int _myCountry;
  int _myCatCat3;
  int _pizzaSize;
  int _myCity;
  bool isPizzaCat3 = false;
  bool invalidItemType = false;
  bool invalidsizeInGSM = true;
  bool istransparent = true;
  Future _getCounties;
  String _picked = tr("haveArtWork");
  String _pickedMaterial = tr("White Material");
  String _pickedMaterialBaseColor = tr("Transparent");
  bool _showcity = true;
  List<DropdownMenuItem> cities = [];
  int firstTime = 0;
  String address = "";
  String fullName = "";
  String email = "";
  String brandName = "";
  String phone = "";
  double height;
  double gusset1;
  double gusset2;
  double width;
  double quantity;
  double length;
  String subCategoryCustomId = "";
  int sizeInOz = 0;
  int sizeInGSM = 0;
  String color = "";
  bool isUAE = false;
  Future<bool> buildFutures() async {
    return true;
  }

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  void _saveForm() async {
    final cart = Provider.of<Cart>(context);
    final isValid = _formKey.currentState.validate();
    if (_myCountry == null || _myCountry == 0) {
      setState(() {
        invalidCountry = true;
      });
    } else {
      setState(() {
        invalidCountry = false;
      });
    }
    if (_myCountry == 1 && (_myCity == null || _myCity == 0)) {
      setState(() {
        invalidCity = true;
      });
    } else {
      setState(() {
        invalidCity = false;
      });
    }
    if (_myCatCat3 == null || _myCatCat3 == 0) {
      setState(() {
        invalidItemType = true;
      });
    } else {
      setState(() {
        invalidItemType = false;
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

    if (sizeInGSM == 0 &&
        (subCategoryCustomId == "5" || subCategoryCustomId == "7")) {
      setState(() {
        invalidsizeInGSM = false;
      });
    } else {
      setState(() {
        invalidsizeInGSM = true;
      });
    }

    if (!isValid) {
      _btnController.reset();
      return;
    }
    if (address == "") {}
    if (phone == "") {}
    _formKey.currentState.save();
    var tempsizeInOz = "";
    var tempMAterial = "";
    if (sizeInOz == 1) {
      tempsizeInOz = "4oz";
    } else if (sizeInOz == 2) {
      tempsizeInOz = "8oz";
    } else if (sizeInOz == 3) {
      tempsizeInOz = "12oz";
    }
    if (_pickedMaterial == "White Material") {
      tempMAterial = "White";
    } else {
      tempMAterial = "Brown";
    }

    if (_pickedMaterialBaseColor == tr("Transparent")) {
      color = "transparent";
    }
    await Provider.of<Orders>(context, listen: false).checkOutCustom(
        subCategoryCustomId,
        fullName,
        phone,
        email,
        brandName,
        _myCountry,
        _myCity,
        address,
        length,
        width,
        height,
        _picked,
        quantity,
        sizeInOz,
        tempMAterial,
        gusset1,
        _myCatCat3,
        _pizzaSize,
        sizeInGSM,
        color);
    // if (subCategoryCustomId == "1")
    //   await Provider.of<Orders>(context, listen: false).checkOutCustom(
    //       subCategoryCustomId,
    //       fullName,
    //       phone,
    //       email,
    //       brandName,
    //       _myCountry,
    //       _myCity,
    //       address,
    //       length,
    //       width,
    //       height,
    //       _picked,
    //       quantity,
    //       sizeInOz,
    //       tempMAterial,
    //       gusset1);
    // else if (subCategoryCustomId == "2") {
    //   await Provider.of<Orders>(context, listen: false).checkOutCustom(
    //       subCategoryCustomId,
    //       fullName,
    //       phone,
    //       email,
    //       brandName,
    //       _myCountry,
    //       _myCity,
    //       address,
    //       length,
    //       width,
    //       height,
    //       _picked,
    //       quantity,
    //       sizeInOz,
    //       tempMAterial,
    //       gusset1);
    // }
    // Provider.of<Orders>(context, listen: false).addOrder(
    //   cart.items.values.toList(),
    //   cart.totalAmount,
    // );
    // cart.clear();
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
    // _myCountry = '';
    // _myCountryResult = '';
  }

  String accountname = "";

  //form builder
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    final cart = Provider.of<Cart>(context);
    String args = ModalRoute.of(context).settings.arguments;
    subCategoryCustomId = args;
    if (subCategoryCustomId == "7")
      sizeDDLCat5 = [
        DropdownMenuItem(
          child: Text("LD"),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text("HD"),
          value: 2,
        ),
      ];
    if (subCategoryCustomId == "8")
      sizeDDLCat5 = [
        DropdownMenuItem(
          child: Text("25GSM"),
          value: 25,
        ),
        DropdownMenuItem(
          child: Text("30GSM"),
          value: 30,
        ),
        DropdownMenuItem(
          child: Text("35GSM"),
          value: 35,
        ),
        DropdownMenuItem(
          child: Text("40GSM"),
          value: 40,
        ),
      ];
    if (subCategoryCustomId == "10")
      sizeDDLCat5 = [
        DropdownMenuItem(
          child: Text("6x8cm"),
          value: 1,
        ),
        DropdownMenuItem(
          child: Text("7x11cm"),
          value: 2,
        ),
      ];
    if (firstTime == 0) {
      _getCounties = userProvider.getStaticCounties();
      firstTime = 1;
    }
    return Scaffold(
      body: Builder(builder: (context) {
        return AppBase(
          body: Column(
            children: <Widget>[
              PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: ApplicationTopBar(pageName: tr("AboutUs")),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: regionSection(),
                ),
              ),
            ],
          ),
        );
      }),
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
            future: _getCounties,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: "* " + tr("full_name")),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return tr('full_name_hint');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      fullName = value;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: "* " + tr("profile_phone")),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  decoration:
                                      InputDecoration(labelText: tr("email")),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value.isNotEmpty &&
                                        !value.contains('@')) {
                                      return tr('wrong_email_format');
                                    }
                                  },
                                  onSaved: (value) {
                                    email = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: "* " + tr("BrandName")),
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return tr('BrandNameHint');
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      brandName = value;
                                    });
                                  },
                                ),
                              ),
                              SearchableDropdown.single(
                                iconSize: 25.0,
                                items: countries,
                                value: _myCountry,
                                hint: "* " + tr("SelectCountry"),
                                searchHint: tr("SelectCountry"),
                                onChanged: (value) async {
                                  setState(() {
                                    _myCountry = value;
                                    _showcity = false;
                                  });
                                  if (value == 1) {
                                    setState(() {
                                      isUAE = true;
                                    });
                                    List<Government> citiesTemp =
                                        await userProvider.getGovernments();
                                    setState(() {
                                      cities = [];
                                      for (Government gov in citiesTemp) {
                                        cities.add(DropdownMenuItem(
                                          child: Text(gov.name),
                                          value: gov.code,
                                        ));
                                      }
                                      _myCity = 0;
                                      _showcity = true;
                                      // setState(() {
                                      //   invalidCountry = false;
                                      // });
                                    });
                                  } else {
                                    setState(() {
                                      isUAE = false;
                                    });
                                  }
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
                              isUAE
                                  ? _showcity
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
                                                      Icons
                                                          .radio_button_checked,
                                                      color: Colors.grey,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .radio_button_unchecked,
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
                                        )
                                  : Container(),
                              isUAE
                                  ? invalidCity
                                      ? Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                tr("mandatory"),
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Container()
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: "* " + tr("address")),
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
                              subCategoryCustomId == "3" ||
                                      subCategoryCustomId == "4" ||
                                      subCategoryCustomId == "6" ||
                                      subCategoryCustomId == "9"
                                  ? Row(
                                      children: <Widget>[
                                        RadioButtonGroup(
                                          orientation: GroupedButtonsOrientation
                                              .HORIZONTAL,
                                          margin:
                                              const EdgeInsets.only(top: 12.0),
                                          onSelected: (String selected) =>
                                              setState(() {
                                            _pickedMaterial = selected;
                                          }),
                                          labels: <String>[
                                            tr("White Material"),
                                            tr("Brown Material"),
                                          ],
                                          picked: _pickedMaterial,
                                          itemBuilder:
                                              (Radio rb, Text txt, int i) {
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 12),
                                                  child: txt,
                                                ),
                                                rb,
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  : Container(),
                              subCategoryCustomId == "7"
                                  ? RadioButtonGroup(
                                      orientation:
                                          GroupedButtonsOrientation.HORIZONTAL,
                                      margin: const EdgeInsets.only(top: 12.0),
                                      onSelected: (String selected) =>
                                          setState(() {
                                        _pickedMaterialBaseColor = selected;
                                        if (selected != "Transparent") {
                                          istransparent = false;
                                        }
                                      }),
                                      labels: <String>[
                                        tr("Transparent"),
                                        tr("AnotherColor"),
                                      ],
                                      picked: _pickedMaterialBaseColor,
                                      itemBuilder: (Radio rb, Text txt, int i) {
                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 12),
                                              child: txt,
                                            ),
                                            rb,
                                          ],
                                        );
                                      },
                                    )
                                  : Container(),
                              !istransparent
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        initialValue: "",
                                        decoration: InputDecoration(
                                            labelText: "* " + tr("Color")),
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return tr('mandatory');
                                          }
                                          setState(() {
                                            color = value;
                                          });
                                          return null;
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            brandName = value;
                                          });
                                        },
                                      ),
                                    )
                                  : Container(),
                              subCategoryCustomId == "3"
                                  ? SearchableDropdown.single(
                                      iconSize: 25.0,
                                      items: catDDL,
                                      value: _myCatCat3,
                                      hint: "* " + tr("SelectItemType"),
                                      searchHint: tr("SelectItemType"),
                                      onChanged: (value) async {
                                        setState(() {
                                          _myCatCat3 = value;
                                          if (value == 2) {
                                            isPizzaCat3 = true;
                                          } else
                                            isPizzaCat3 =false ;
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
                                  : Container(),
                              subCategoryCustomId == "3" && invalidItemType
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
                              subCategoryCustomId == "3" && isPizzaCat3
                                  ? SearchableDropdown.single(
                                      iconSize: 25.0,
                                      items: pizzaSizeDDL,
                                      value: _pizzaSize,
                                      hint: tr("SelectPizzaBoxSize"),
                                      searchHint: tr("SelectPizzaBoxSize"),
                                      onChanged: (value) async {
                                        setState(() {
                                          _pizzaSize = value;
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
                                  : Container(),
                              subCategoryCustomId == "1" ||
                                      isPizzaCat3 ||
                                      subCategoryCustomId == "4" ||
                                      subCategoryCustomId == "5" ||
                                      subCategoryCustomId == "6" ||
                                      subCategoryCustomId == "8" ||
                                      subCategoryCustomId == "9" ||
                                      subCategoryCustomId == "7"
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          subCategoryCustomId != "6" &&
                                                  subCategoryCustomId != "8" &&
                                                  subCategoryCustomId != "9" &&
                                                  subCategoryCustomId != "7" &&
                                                  subCategoryCustomId != "4"
                                              ? new Flexible(
                                                  child: new TextFormField(
                                                    initialValue: "",
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            tr("Length")),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value.isEmpty &&
                                                          (subCategoryCustomId ==
                                                                  "4" ||
                                                              subCategoryCustomId ==
                                                                  "5")) {
                                                        return tr('mandatory');
                                                      } else if (value
                                                          .isNotEmpty) {
                                                        double parsedValue2 =
                                                            double.tryParse(
                                                                value);

                                                        if (parsedValue2 ==
                                                            null) {
                                                          return tr(
                                                              'MustBeNum');
                                                        } else {
                                                          if (parsedValue2 <=
                                                              0) {
                                                            return tr(
                                                                'QuantityHint');
                                                          }
                                                        }
                                                        return null;
                                                      }
                                                    },
                                                    onSaved: (value) {
                                                      setState(() {
                                                        length =
                                                            double.tryParse(
                                                                value);
                                                      });
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          subCategoryCustomId != "6" &&
                                                  subCategoryCustomId != "8" &&
                                                  subCategoryCustomId != "9" &&
                                                  subCategoryCustomId != "7"
                                              ? SizedBox(
                                                  width: 20.0,
                                                )
                                              : Container(),
                                          new Flexible(
                                            child: new TextFormField(
                                              initialValue: "",
                                              decoration: InputDecoration(
                                                  labelText:
                                                      subCategoryCustomId == "8"
                                                          ?  tr("Width")
                                                          : tr("Width")),
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value.isEmpty &&
                                                    (subCategoryCustomId ==
                                                            "4" ||
                                                        subCategoryCustomId ==
                                                            "5" ||
                                                        subCategoryCustomId ==
                                                            "6" ||
                                                        subCategoryCustomId ==
                                                            "7" ||
                                                        subCategoryCustomId ==
                                                            "9")) {
                                                  return tr('mandatory');
                                                } else if (value.isNotEmpty) {
                                                  double parsedValue2 =
                                                      double.tryParse(value);

                                                  if (parsedValue2 == null) {
                                                    return tr('MustBeNum');
                                                  } else {
                                                    if (parsedValue2 <= 0) {
                                                      return tr('QuantityHint');
                                                    }
                                                  }
                                                }
                                                return null;
                                              },
                                              onSaved: (value) {
                                                setState(() {
                                                  width =
                                                      double.tryParse(value);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          new Flexible(
                                            child: new TextFormField(
                                              initialValue: "",
                                              decoration: InputDecoration(
                                                  labelText:
                                                      subCategoryCustomId == "8"
                                                          ? tr("Length")
                                                          : tr("Height")),
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              validator: (value) {
                                                if (value.isEmpty &&
                                                    (subCategoryCustomId ==
                                                            "4" ||
                                                        subCategoryCustomId ==
                                                            "5" ||
                                                        subCategoryCustomId ==
                                                            "6" ||
                                                        subCategoryCustomId ==
                                                            "7" ||
                                                        subCategoryCustomId ==
                                                            "9")) {
                                                  return tr('mandatory');
                                                } else if (value.isNotEmpty) {
                                                  double parsedValue2 =
                                                      double.tryParse(value);

                                                  if (parsedValue2 == null) {
                                                    return tr('MustBeNum');
                                                  } else {
                                                    if (parsedValue2 <= 0) {
                                                      return tr('MustBeNum');
                                                    }
                                                  }
                                                  return null;
                                                }
                                              },
                                              onSaved: (value) {
                                                setState(() {
                                                  height =
                                                      double.tryParse(value);
                                                });
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          subCategoryCustomId == "4" ||
                                                  subCategoryCustomId == "6" ||
                                                  subCategoryCustomId == "9" ||
                                                  subCategoryCustomId == "7"
                                              ? new Flexible(
                                                  child: new TextFormField(
                                                    initialValue: "",
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            tr("Gusset")),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return tr('mandatory');
                                                      } else if (value
                                                          .isNotEmpty) {
                                                        double parsedValue2 =
                                                            double.tryParse(
                                                                value);

                                                        if (parsedValue2 ==
                                                            null) {
                                                          return tr(
                                                              'MustBeNum');
                                                        } else {
                                                          if (parsedValue2 <=
                                                              0) {
                                                            return tr(
                                                                'MustBeNum');
                                                          }
                                                        }
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      setState(() {
                                                        gusset1 =
                                                            double.tryParse(
                                                                value);
                                                      });
                                                    },
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            width: 20.0,
                                          ),
                                          // subCategoryCustomId == "4" ||
                                          //         subCategoryCustomId == "6" ||
                                          //         subCategoryCustomId == "9" ||
                                          //         subCategoryCustomId == "7"
                                          //     ? new Flexible(
                                          //         child: new TextFormField(
                                          //           initialValue: "",
                                          //           decoration: InputDecoration(
                                          //               labelText:
                                          //                   tr("Gusset")),
                                          //           textInputAction:
                                          //               TextInputAction.next,
                                          //           keyboardType:
                                          //               TextInputType.text,
                                          //           validator: (value) {
                                          //             if (value.isEmpty) {
                                          //               return tr('mandatory');
                                          //             } else if (value
                                          //                 .isNotEmpty) {
                                          //               double parsedValue2 =
                                          //                   double.tryParse(
                                          //                       value);

                                          //               if (parsedValue2 ==
                                          //                   null) {
                                          //                 return tr(
                                          //                     'MustBeNum');
                                          //               } else {
                                          //                 if (parsedValue2 <=
                                          //                     0) {
                                          //                   return tr(
                                          //                       'MustBeNum');
                                          //                 }
                                          //               }
                                          //             }
                                          //             return null;
                                          //           },
                                          //           onSaved: (value) {
                                          //             setState(() {
                                          //               gusset2 =
                                          //                   double.tryParse(
                                          //                       value);
                                          //             });
                                          //           },
                                          //         ),
                                          //       )
                                          //     : Container(),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              subCategoryCustomId == "2"
                                  ? SearchableDropdown.single(
                                      iconSize: 25.0,
                                      items: sizeDDL,
                                      value: '',
                                      hint: tr("SelectSize"),
                                      searchHint: tr("SelectSize"),
                                      onChanged: (value) {
                                        setState(() {
                                          sizeInOz = value;
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
                                  : Container(),
                              subCategoryCustomId == "5" ||
                                      subCategoryCustomId == "7" ||
                                      subCategoryCustomId == "8" ||
                                      subCategoryCustomId == "10"
                                  ? SearchableDropdown.single(
                                      iconSize: 25.0,
                                      items: sizeDDLCat5,
                                      value: '',
                                      hint: subCategoryCustomId == "10"
                                          ? tr("SelectSize")
                                          : tr("MaterialType"),
                                      searchHint: subCategoryCustomId == "10"
                                          ? tr("SelectSize")
                                          : tr("MaterialType"),
                                      onChanged: (value) {
                                        setState(() {
                                          sizeInGSM = value;
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
                                  : Container(),
                              !invalidsizeInGSM
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
                              RadioButtonGroup(
                                orientation:
                                    GroupedButtonsOrientation.HORIZONTAL,
                                margin: const EdgeInsets.only(top: 12.0),
                                onSelected: (String selected) => setState(() {
                                  _picked = selected;
                                }),
                                labels: <String>[
                                  tr("haveArtWork"),
                                  tr("NothaveArtWork"),
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  initialValue: "",
                                  decoration: InputDecoration(
                                      labelText: "* " + tr("Quantity")),
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    double parsedValue2 =
                                        double.tryParse(value);
                                    if (subCategoryCustomId == "4" ||
                                        subCategoryCustomId == "7") {
                                      if (value.isEmpty) {
                                        return tr('QuantityHintCat4');
                                      } else if (parsedValue2 == null) {
                                        return tr('QuantityHintCat4');
                                      } else {
                                        if (parsedValue2 < 300) {
                                          return tr('QuantityHintCat4');
                                        }
                                        quantity = parsedValue2;
                                      }
                                    } else if (subCategoryCustomId == "1" ||
                                        subCategoryCustomId == "2" ||
                                        subCategoryCustomId == "3" ||
                                        subCategoryCustomId == "5" ||
                                        subCategoryCustomId == "6" ||
                                        subCategoryCustomId == "9") {
                                      if (value.isEmpty) {
                                        return tr('QuantityHint');
                                      } else if (parsedValue2 == null) {
                                        return tr('QuantityHint');
                                      } else {
                                        if (parsedValue2 < 5000) {
                                          return tr('QuantityHint');
                                        }
                                        quantity = parsedValue2;
                                      }
                                    } else if (subCategoryCustomId == "8") {
                                      if (value.isEmpty) {
                                        return tr('QuantityHint30000');
                                      } else if (parsedValue2 == null) {
                                        return tr('QuantityHint30000');
                                      } else {
                                        if (parsedValue2 < 30000) {
                                          return tr('QuantityHint30000');
                                        }
                                        quantity = parsedValue2;
                                      }
                                    } else if (subCategoryCustomId == "10") {
                                      if (value.isEmpty) {
                                        return tr('QuantityHint50000');
                                      } else if (parsedValue2 == null) {
                                        return tr('QuantityHint50000');
                                      } else {
                                        if (parsedValue2 < 50000) {
                                          return tr('QuantityHint50000');
                                        }
                                        quantity = parsedValue2;
                                      }
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      quantity = double.tryParse(value);
                                    });
                                  },
                                ),
                              ),
                              button()
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
                      getFormattedCurrency(cart.totalAmount.toString()),
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
