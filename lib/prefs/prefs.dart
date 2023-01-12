import 'package:hive/hive.dart';

import '../models/products_model.dart';

class PrefsBoxKeys {
  static const mostOrderedItems = 'mostOrdered';
 
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');
  static List<dynamic>  get getOrders =>
      prefsBox.get(PrefsBoxKeys.mostOrderedItems, defaultValue: <dynamic>[]);

  static Box get box => prefsBox;
  
  static void saveOrders(List<Map<dynamic,dynamic>> mostOrderedItems) => prefsBox.put(
        PrefsBoxKeys.mostOrderedItems,
        mostOrderedItems,
      );

}