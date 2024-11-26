import 'package:flutter/cupertino.dart';
import 'people_management.dart'; // 引入人員管理頁面的檔案

void main() {
  runApp(const CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: PeopleManagementPage(), // 設定首頁為 PeopleManagementPage
  ));
}
