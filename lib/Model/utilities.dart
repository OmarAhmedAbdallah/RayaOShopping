import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Utilities with ChangeNotifier {
  static String lang = "en";
  static String url = "https://alrayapack.com";
  static String loginAPI = "/api/auth/login";
  static String registerAPI = "/api/auth/register";
  static String categoryAPI = "/api/homepage/menu";
  static String homeSliderAPI = "/api/homepage/slider";
  static String profileAPI = "/api/user/profile";
  static String singleCategoryAPI = "/api/category/";
  static String addFavouritAPI = "/api/wishlist";
  static String cartAPI = "/api/cart";
  static String searchAPI = "/api/search";
  static String aboutAPI = "/api/about";
  static String termsAPI = "/api/terms";
  static String generateTokenAPI = "/api/generateToken";
  static String governmentsAPI = "/api/governments";
  static String citiesAPI = "/api/cities";
  static String checkoutAPI = "/api/checkout";
  static String checkoutCustomAPI = "/api/customized";
  static String changePasswordAPI = "/api/user/change-password";
  static String getOrdersAPI = "/api/orders";
  static String orderImageAPI = "/api/orderImage";
  static String forgetPassAPI = "/api/generate";
  static String resetPasswordAPI = "/api/auth/forget-password";

  Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }

  static getSizedBox({double width, double height}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Map<String, String> headers = {
    "Content-Type": "application/x-www-form-urlencoded",
    "Content-type": "application/json"
  };
}
