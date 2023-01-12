

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:restaurant_app/pages/order_screen.dart';
import 'package:restaurant_app/pages/success_screen.dart';


class Routes {
  static const String orderScreen = '/placeOrderScreen';
static const String successScreen = '/';
}

class AppRouter {
  static List<GetPage> routes = [
    GetPage(
        name: Routes.orderScreen,
        page: () => const PlaceOrderScreen()),

    GetPage(
        name: Routes.successScreen,
        page: () => const SuccessScreen(
        
            )),
  ];
}
