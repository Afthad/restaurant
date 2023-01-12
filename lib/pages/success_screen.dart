import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/routes.dart';
import 'package:restaurant_app/widgets/common_widgets.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return Future.value(false);
      },
      child: Scaffold(body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(text: 'Order Successful'),
            MaterialButton(
              child: textWidget(text: 'GO TO ORDER SCREEN'),
              onPressed: (){
              Get.offAllNamed(Routes.orderScreen);
            })
          ],
        ),
      )),
    );
  }
}