import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oshopping/screens/CheckOutPage.dart';
import 'package:oshopping/screens/CustomForm.dart';
import 'package:oshopping/screens/about_us.dart';
import 'package:oshopping/screens/cart_screen.dart';
import 'package:oshopping/screens/change_password.dart';
import 'package:oshopping/screens/edit_product_screen.dart';
import 'package:oshopping/screens/favourite_screen.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/screens/orders_screen.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/screens/product_details_screen.dart';
import 'package:oshopping/screens/profile.dart';
import 'package:oshopping/screens/subCategoryCustom_screen.dart';
import 'package:oshopping/screens/subCategory_screen.dart';
import 'package:oshopping/screens/term_conditions.dart';
import 'package:oshopping/screens/user_products_screen.dart';
import 'package:oshopping/widgets/Auth/forgetPassword.dart';
import 'package:oshopping/widgets/Auth/loginPage.dart';
import 'package:oshopping/widgets/Auth/signup.dart';
import 'package:oshopping/widgets/LanguageView.dart';
import 'package:oshopping/widgets/navigation_home_screen.dart';


final mainScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainScreen();
});

final loginPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

final signUpPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignUpPage();
});

final productDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProductDetailsScreen();
});

final cartScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartScreen();
});

final productsOverviewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProductsOverviewScreen(params);
});

final ordersScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OrdersScreen();
});

final profileScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProfileScreen();
});

final userProductsScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserProductsScreen();
});

final editProductScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return EditProductScreen();
});


final navigationHomeScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NavigationHomeScreen();
});


final aboutUsScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutUsScreen();
});

final forgetPageHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ForgetPage();
});
final languageViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LanguageView();
});

final favouritescreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Favourite_screen();
});

final checkOutPagescreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CheckOutPage(params);
});
final changePasswordScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ChangePasswordPage();
});

final subCategoriesCustomTabsScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SubCategoriesCustomTabs();
});
final customFormScreenHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CustomForm(params);
});
final termsAndConditionsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TermsAndConditionsScreen();
});

