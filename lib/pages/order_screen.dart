import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/controllers/order_controller.dart';
import 'package:restaurant_app/pages/success_screen.dart';
import 'package:restaurant_app/prefs/prefs.dart';
import 'package:restaurant_app/widgets/common_widgets.dart';
import 'package:restaurant_app/widgets/product_list_widget.dart';

import '../models/products_model.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  @override
  initState() {
    super.initState();
    getData();
  }

  List<Products> listCategories = [];
  Cat1? bestSeller;
  void getData() {
    List<Cat1> values = [];

    if (PrefsDb.getOrders.isNotEmpty) {
      for (var e in PrefsDb.getOrders) {
        if (values.any((element) => element.name == e['name'])) {
          values.where((element) => element.name == e['name']).first.count =
              e['count'] + e['count'];
        } else {
          values.add(Cat1(
              count: e['count'],
              instock: true,
              name: e['name'],
              price: e['price']));
        }
      }
      //values = List<Cat1>.from(PrefsDb.getOrders.map((x) => Cat1.fromJson(x)));
 bestSeller = values.reduce((value, element) {
        if (value.count > element.count) {
          return value;
        } else {
          return element;
        }
      });
     values.sort((a, b) => b.count.compareTo(a.count));

     if (values.length > 3) {
        values = values.sublist(0, 3);
      }
      
     

      listCategories.add(
          Products(name: 'Popular Items', isOpen: isOpen, products: values));
    }
    products.forEach((key, value) {
      listCategories.add(Products(
          name: key,
          isOpen: false,
          products: List<Cat1>.from(value!.map((x) => Cat1.fromJson(x)))));
    });
    setState(() {});
  }

  OrderController controller = Get.put(OrderController());
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                textWidget(text: 'Place Order Screen', fontSize: 18),
                const SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listCategories.length,
                    itemBuilder: ((context, index) {
                      return CategoryListWidget(
                        action: () {
                          listCategories[index].isOpen =
                              !listCategories[index].isOpen;
                          setState(() {});
                        },
                        isOpen: listCategories[index].isOpen,
                        categoryName: listCategories[index].name,
                        count: listCategories[index].products.length.toString(),
                        widget: listCategories[index].isOpen
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Container(
                                  color: Colors.grey[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: listCategories[index]
                                          .products
                                          .map((e) => Column(
                                                children: [
                                                  ListTile(
                                                    trailing: e.instock!
                                                        ? Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              controller
                                                                      .checkCart(
                                                                          e.name!)
                                                                      .value
                                                                  ? Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              18),
                                                                          border: Border.all(
                                                                              color: Colors.orange,
                                                                              width: 2)),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              controller.reduceCount(e.name!);
                                                                            },
                                                                            child:
                                                                                CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              minRadius: 12,
                                                                              child: textWidget(text: '-', fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange),
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 5),
                                                                          CircleAvatar(
                                                                            minRadius:
                                                                                12,
                                                                            backgroundColor:
                                                                                Colors.orange,
                                                                            child: textWidget(
                                                                                text: controller.cartItems.isNotEmpty ? (controller.cartItems.where((p0) => p0.name == e.name).first.count.toString()) : '0',
                                                                                color: Colors.white,
                                                                                fontSize: 12),
                                                                          ),
                                                                          const SizedBox(
                                                                              width: 5),
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                controller.addToCart(e);
                                                                              },
                                                                              child: CircleAvatar(
                                                                                  minRadius: 12,
                                                                                  backgroundColor: Colors.transparent,
                                                                                  child: Icon(
                                                                                    Icons.add,
                                                                                    size: 12,
                                                                                    color: Colors.orange,
                                                                                  ))),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        controller
                                                                            .addToCart(e);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(18),
                                                                            border: Border.all(color: Colors.orange, width: 2)),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 16,
                                                                              vertical: 8),
                                                                          child: textWidget(
                                                                              text: 'Add',
                                                                              color: Colors.orange,
                                                                              fontWeight: FontWeight.w500),
                                                                        ),
                                                                      ),
                                                                    )
                                                            ],
                                                          )
                                                        : textWidget(
                                                            text:
                                                                'Out of Stock',
                                                            color: Colors.red),
                                                    title: Row(
                                                      children: [
                                                        textWidget(
                                                            text: e.name!,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        bestSeller?.name ==
                                                                e.name
                                                            ? Container(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .pink,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: textWidget(
                                                                      text:
                                                                          'BestSeller',
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : Container()
                                                      ],
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    subtitle: textWidget(
                                                        color: Colors.grey,
                                                        text: "\$${e.price!}"),
                                                  ),
                                                  const Divider()
                                                ],
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      );
                    })),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.orange,
                    onPressed: () async {
                      if (controller.totalPrice.value != 0) {
                        await controller.saveOrder();
                        controller.clearCart();
                        Get.to(SuccessScreen());
                      } else {
                        Get.snackbar('Add Some products',
                            'Please add some products to checkout');
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                            text: 'Place Order',
                            color: Colors.white,
                            fontSize: 16),
                        textWidget(
                            text: '  \$${controller.totalPrice.value}',
                            color: Colors.white),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Map products = {
  "cat1": [
    {"name": "XYZ", "price": 100, "instock": true},
    {"name": "ABC", "price": 934, "instock": false},
    {"name": "OTR", "price": 945, "instock": true},
    {"name": "SLG", "price": 343, "instock": true},
    {"name": "KGN", "price": 342, "instock": true},
    {"name": "GDS", "price": 234, "instock": true},
    {"name": "KNL", "price": 934, "instock": true},
    {"name": "GLM", "price": 320, "instock": true},
    {"name": "DKF", "price": 394, "instock": false},
    {"name": "VFS", "price": 854, "instock": true}
  ],
  "cat2": [
    {"name": "NA", "price": 124, "instock": true},
    {"name": "DS", "price": 953, "instock": true},
    {"name": "HF", "price": 100, "instock": true},
    {"name": "FJ", "price": 583, "instock": true},
    {"name": "LS", "price": 945, "instock": false},
    {"name": "TR", "price": 394, "instock": true},
    {"name": "PD", "price": 35, "instock": true},
    {"name": "AL", "price": 125, "instock": true},
    {"name": "TK", "price": 129, "instock": true},
    {"name": "PG", "price": 294, "instock": true}
  ],
  "cat3": [
    {"name": "A", "price": 294, "instock": true},
    {"name": "B", "price": 125, "instock": true},
    {"name": "C", "price": 256, "instock": true},
    {"name": "D", "price": 100, "instock": true},
    {"name": "E", "price": 100, "instock": true},
    {"name": "F", "price": 530, "instock": true},
    {"name": "G", "price": 100, "instock": true},
    {"name": "H", "price": 100, "instock": true},
    {"name": "I", "price": 395, "instock": true}
  ],
  "cat4": [
    {"name": "J", "price": 100, "instock": true},
    {"name": "K", "price": 100, "instock": true},
    {"name": "L", "price": 125, "instock": false},
    {"name": "M", "price": 530, "instock": true},
    {"name": "N", "price": 100, "instock": true},
    {"name": "O", "price": 395, "instock": true},
    {"name": "P", "price": 100, "instock": true},
    {"name": "Q", "price": 400, "instock": true},
    {"name": "R", "price": 100, "instock": true},
    {"name": "S", "price": 256, "instock": true}
  ],
  "cat5": [
    {"name": "T", "price": 100, "instock": false},
    {"name": "U", "price": 100, "instock": true},
    {"name": "V", "price": 395, "instock": true},
    {"name": "W", "price": 100, "instock": true},
    {"name": "X", "price": 100, "instock": false},
    {"name": "Y", "price": 125, "instock": true},
    {"name": "Z", "price": 530, "instock": true}
  ],
  "cat6": [
    {"name": "ABCD", "price": 400, "instock": true},
    {"name": "PROS", "price": 256, "instock": true},
    {"name": "NFDD", "price": 200, "instock": true},
    {"name": "LFKR", "price": 200, "instock": true}
  ]
};
