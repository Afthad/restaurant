

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant_app/routes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 

  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init('${appDocDir.path}/db');
  await Hive.openBox('prefs');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scrollBehavior: const ScrollBehavior(
        
      ),
      initialRoute: '/placeOrderScreen',
      theme: ThemeData(),

      getPages: AppRouter.routes,
     
    );
  }
}
