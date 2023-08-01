import 'package:api_with_database/screens/home/controller/home_controller.dart';
import 'package:api_with_database/screens/home/model/api_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/db_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    DBHelper.db.checkDB();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: controller.GetData(),
          builder: (context, snapshot) {
            controller.l1.value = snapshot.data!.articles;
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 10, right: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 22),
                        ),
                        IconButton(
                          onPressed: () {
                            Get.toNamed('/download');
                          },
                          icon: Icon(Icons.download),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Latest",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Container(
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
                                            "${controller.l1[index].source.name}",
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 34,
                                            width: 200,
                                            child: Text(
                                              "${controller.l1[index].author}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 100,
                                            width: 200,
                                            child: Text(
                                              "${controller.l1[index].title}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: InkWell(
                                            onTap: () {
                                              Get.toNamed('/details',
                                                  arguments: index);
                                            },
                                            child: Image.network(
                                                "${controller.l1[index].urlToImage}",
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    ],
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
                          itemCount: controller.l1.length,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
