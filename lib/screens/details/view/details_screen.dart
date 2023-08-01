import 'package:api_with_database/screens/download/model/download_model.dart';
import 'package:api_with_database/screens/home/controller/home_controller.dart';
import 'package:api_with_database/screens/utils/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    int index = Get.arguments;
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: controller.GetData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error}"));
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            "${controller.l1[index].urlToImage}",
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 460,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.l1[index].author}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Description :",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${controller.l1[index].description}",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Content :",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${controller.l1[index].content}",
                            style: TextStyle(
                                color: Colors.grey.shade600, fontSize: 16),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              DownNewsModel model = DownNewsModel(
                                description: controller.l1[index].description,
                                author: controller.l1[index].author,
                                image: controller.l1[index].urlToImage,
                                content: controller.l1[index].content,
                                name: controller.l1[index].source.name,
                                title: controller.l1[index].title
                              );

                              DBHelper.db.insertDB(d1: model);
                              Get.toNamed('/download');
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Download",
                                  style: TextStyle(fontSize: 16,color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
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