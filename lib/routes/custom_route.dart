import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:oshopping/routes/route_handlers.dart';
import 'package:oshopping/screens/CheckOutPage.dart';
import 'package:oshopping/screens/CustomForm.dart';
import 'package:oshopping/screens/about_us.dart';
import 'package:oshopping/screens/change_password.dart';
import 'package:oshopping/screens/edit_product_screen.dart';
import 'package:oshopping/screens/favourite_screen.dart';
import 'package:oshopping/screens/profile.dart';
import 'package:oshopping/screens/subCategoryCustom_screen.dart';
import 'package:oshopping/screens/subCategory_screen.dart';
import 'package:oshopping/screens/term_conditions.dart';
import 'package:oshopping/screens/user_products_screen.dart';
import 'package:oshopping/widgets/Auth/forgetPassword.dart';
import 'package:oshopping/widgets/Auth/loginPage.dart';
import 'package:oshopping/screens/cart_screen.dart';
import 'package:oshopping/screens/main_screen.dart';
import 'package:oshopping/screens/orders_screen.dart';
import 'package:oshopping/screens/prodeuct_overview_screen.dart';
import 'package:oshopping/screens/product_details_screen.dart';
import 'package:oshopping/widgets/Auth/signup.dart';
import 'package:oshopping/widgets/LanguageView.dart';
import 'package:oshopping/widgets/navigation_home_screen.dart';

class CustomRoute {
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return LoginPage();
    });
    router.define(MainScreen.routeName, handler: mainScreenHandler);
    router.define(LoginPage.routeName, handler: loginPageHandler);
    router.define(SignUpPage.routeName, handler: signUpPageHandler);
    router.define(ProductDetailsScreen.routeName,
        handler: productDetailsHandler);
    router.define(CartScreen.routeName, handler: cartScreenHandler);
    router.define(ProductsOverviewScreen.routeName,
        handler: productsOverviewHandler);
    router.define(OrdersScreen.routeName, handler: ordersScreenHandler);
    router.define(ProfileScreen.routeName, handler: profileScreenHandler);
    router.define(UserProductsScreen.routeName,
        handler: userProductsScreenHandler);
    router.define(EditProductScreen.routeName,
        handler: editProductScreenHandler);
    router.define(NavigationHomeScreen.routeName,
        handler: navigationHomeScreenHandler);
    router.define(AboutUsScreen.routeName, handler: aboutUsScreenHandler);
    router.define(ForgetPage.routeName, handler: forgetPageHandler);
    router.define(LanguageView.routeName, handler: languageViewHandler);
    router.define(Favourite_screen.routeName, handler: favouritescreenHandler);
    router.define(CheckOutPage.routeName, handler: checkOutPagescreenHandler);
    router.define(ChangePasswordPage.routeName, handler: changePasswordScreenHandler);
    router.define(SubCategoriesCustomTabs.routeName, handler: subCategoriesCustomTabsScreenHandler);
    router.define(CustomForm.routeName, handler: customFormScreenHandler);
    router.define(TermsAndConditionsScreen.routeName, handler: termsAndConditionsHandler);
    // router.define(SubCategoriesTabs.routeName,
    //     handler: subCategoriesTabsscreenHandler);
  }
}
