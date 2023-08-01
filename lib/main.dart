import 'package:api_with_database/screens/details/view/details_screen.dart';
import 'package:api_with_database/screens/download/view/download_screen.dart';
import 'package:api_with_database/screens/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => HomeScreen()),
        GetPage(name: '/details', page: () => DetailsScreen()),
        GetPage(name: '/download', page: () => DownloadScreen())
      ],
    ),
  );
}