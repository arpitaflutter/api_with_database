import 'package:api_with_database/screens/utils/api_helper.dart';
import 'package:api_with_database/screens/utils/db_helper.dart';
import 'package:get/get.dart';

import '../model/api_model.dart';

class HomeController extends GetxController
{

  RxList l1 = [].obs;
  RxList DownloadData = [].obs;

  Future<NewsModel> GetData()
  async {
    NewsModel n1 = await ApiHelper.helper.getApi();
    return n1;
  }

  Future<void> readData()
  async {
    DownloadData.value = await DBHelper.db.readDB();
  }
}