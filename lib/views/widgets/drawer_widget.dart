import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace_line_oa/constants/mkp_styles.dart';
import 'package:marketplace_line_oa/controllers/auth_controller.dart';
import 'package:marketplace_line_oa/controllers/drawer_controller.dart';
import 'package:marketplace_line_oa/models/resources.dart';

class DrawerComponent extends GetView<DrawerWidgetController> {
  const DrawerComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height - 40;
    return Drawer(
      child: GetBuilder<DrawerWidgetController>(
          init: DrawerWidgetController(),
          builder: (dc) {
            return Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      width: double.infinity,
                      color: Colors.grey.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: maxHeight * .05,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(dc.useLineProfile.value != null ? dc.useLineProfile.value!.pictureUrl! : 'https://cdn-icons-png.flaticon.com/512/847/847969.png?w=1480&t=st=1686625225~exp=1686625825~hmac=0600b3f35ffb2ca3946f4b4a0544d0f978fe4b198ec6d801543fd17a67cd44ba'),
                              radius: 50,
                              backgroundColor: Colors.blue,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(dc.useLineProfile.value != null ? dc.useLineProfile.value!.displayName : 'test ',
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black12),
                            ),
                          ],
                        ),
                      ),
                    )),
                Expanded(
                    flex: 10,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.favorite),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Favourite',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Users',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.settings),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.shopping_cart),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Orders',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.help),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Help',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
