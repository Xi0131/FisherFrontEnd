import 'package:flutter/cupertino.dart';

class AddPersonnelPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd; // 用於回調新增的資料

  const AddPersonnelPage({
    super.key,
    required this.onAdd,
  });

  @override
  AddPersonnelPageState createState() => AddPersonnelPageState();
}

class AddPersonnelPageState extends State<AddPersonnelPage> {
  // 控制輸入框的控制器
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController birthdayController;
  late TextEditingController countryController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    // 初始化每個 TextEditingController，預設為空
    nameController = TextEditingController();
    numberController = TextEditingController();
    birthdayController = TextEditingController();
    countryController = TextEditingController();
    roleController = TextEditingController();
  }

  @override
  void dispose() {
    // 釋放 TextEditingController 資源
    nameController.dispose();
    numberController.dispose();
    birthdayController.dispose();
    countryController.dispose();
    roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context), // 返回上一頁
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(80),
        child: Column(
          children: [
            // 頭像圓形
            Container(
              width: 200, // 藍色圈圈大小
              height: 200, // 藍色圈圈大小
              decoration: const BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person,
                size: 100, // 圓圈內的小人圖標大小
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 20),

            // 輸入框
            CupertinoTextField(
              placeholder: "Name",
              controller: nameController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), // 輸入框文字大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Number",
              controller: numberController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), // 輸入框文字大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Birthday",
              controller: birthdayController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), // 輸入框文字大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Country",
              controller: countryController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), // 輸入框文字大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Work Type",
              controller: roleController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), // 輸入框文字大小
            ),
            const SizedBox(height: 30),

            // 按鈕
            CupertinoButton.filled(
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 20), // 按鈕大小
              child: const Text(
                "Add",
                style: TextStyle(fontSize: 24), // 按鈕文字大小
              ),
              onPressed: () {
                // 新增資料
                widget.onAdd({
                  "name": nameController.text,
                  "number": numberController.text,
                  "birthday": birthdayController.text,
                  "country": countryController.text,
                  "role": roleController.text,
                });
                Navigator.pop(context); // 返回主頁面
              },
            ),
          ],
        ),
      ),
    );
  }
}
