import 'package:flutter/widgets.dart';
import 'package:shop_app/screens/cart/cart_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  CartScreen.routeName: (context) => CartScreen(),
};
