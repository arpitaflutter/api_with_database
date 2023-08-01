import 'package:api_with_database/screens/home/controller/home_controller.dart';
import 'package:api_with_database/screens/utils/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu_custom/focused_menu.dart';
import 'package:focused_menu_custom/modals.dart';
import 'package:get/get.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text(
            "Downloaded News",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Obx(
            () => controller.DownloadData.isNotEmpty
                ? ListView.builder(
                  itemBuilder: (context, index) {
                    // return Text("${controller.DownloadData[index].name}");
                    return Column(
                      children: [
                        FocusedMenuHolder(
                          menuItems: [
                            FocusedMenuItem(
                              title: Text("Delete News Data"),
                              onPressed: () {
                                DBHelper.db.deleteDB(
                                    id: controller
                                        .DownloadData[index].id!);
                                controller.readData();
                              },
                            )
                          ],
                          onPressed: () {},
                          child: Container(
                            height: 170,
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: 3, bottom: 10, right: 3, top: 10),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${controller.DownloadData[index].name}",
                                      style: TextStyle(
                                          color: Colors.grey.shade600),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${controller.DownloadData[index].author}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: 100,
                                      width: 200,
                                      child: Text(
                                        "${controller.DownloadData[index].title}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight:
                                                FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:
                                        BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(10),
                                    child: Image.network(
                                        "${controller.DownloadData[index].image}",
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                      ],
                    );
                  },
                  itemCount: controller.DownloadData.length,
                )
                : Center(
                    child: Text(
                      "Please Download The News",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
