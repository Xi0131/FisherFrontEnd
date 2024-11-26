import 'package:flutter/cupertino.dart';

class EditPersonnelPage extends StatefulWidget {
  final Map<String, String> person;
  final VoidCallback onDelete;
  final Function(Map<String, String>) onSave; // 添加保存回調

  const EditPersonnelPage({
    super.key,
    required this.person,
    required this.onDelete,
    required this.onSave,
  });

  @override
  EditPersonnelPageState createState() => EditPersonnelPageState();
}

class EditPersonnelPageState extends State<EditPersonnelPage> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController birthdayController;
  late TextEditingController countryController;
  late TextEditingController roleController;

  @override
  void initState() {
    super.initState();
    // 初始化每個 TextEditingController，並設置初始值
    nameController = TextEditingController(text: widget.person['name']);
    numberController = TextEditingController(text: widget.person['number']);
    birthdayController = TextEditingController(text: widget.person['birthday']);
    countryController = TextEditingController(text: widget.person['country']);
    roleController = TextEditingController(text: widget.person['role']);
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
        // middle: Text('Edit ${widget.person['name']}'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(80),
        child: Column(
          children: [
            Container(
              width: 200, // 藍色圈圈大小
              height: 200, // 藍色圈圈大小
              decoration: const BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(CupertinoIcons.person,
                  size: 100, color: CupertinoColors.white),//裡面的小人size
            ),
            const SizedBox(height: 20),
            // 之後都是輸入框
            CupertinoTextField(
              placeholder: "Name",
              controller: nameController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), //字體大小
            ),
            const SizedBox(height: 10),// 與上面的間隔
            CupertinoTextField(
              placeholder: "Number",
              controller: numberController,
              padding: const EdgeInsets.all(30), // 輸入格長度 16
              style: const TextStyle(fontSize: 24), //字體大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Birthday",
              controller: birthdayController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), //字體大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Country",
              controller: countryController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), //字體大小
            ),
            const SizedBox(height: 10),
            CupertinoTextField(
              placeholder: "Work Type",
              controller: roleController,
              padding: const EdgeInsets.all(30),
              style: const TextStyle(fontSize: 24), //字體大小
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton.filled(//
                  child: const Text(
                      "OK",
                      style: TextStyle(fontSize: 24), // OK 按鈕文字大小
                  ),

                  onPressed: () {
                    // 傳回更新的資料
                    widget.onSave({
                      "name": nameController.text,
                      "number": numberController.text,
                      "birthday": birthdayController.text,
                      "country": countryController.text,
                      "role": roleController.text,
                    });
                    Navigator.pop(context); // 返回主頁面
                  },
                ),
                CupertinoButton(
                  color: CupertinoColors.destructiveRed,
                  child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => Center(
                        child: Container(
                          width: 950, // 設定對話框寬度
                          padding: const EdgeInsets.all(10), // 設置內邊距
                          decoration: BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.circular(40), // 圓角設置
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // 垂直方向自適應內容
                            children: [
                              const Text(
                                "Are you sure?",
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Do you really want to delete this person?",
                                style: TextStyle(fontSize: 40),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  CupertinoButton(
                                    color: CupertinoColors.systemGrey,
                                    child: const Text(
                                      "No",
                                      style: TextStyle(fontSize: 35),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context); // 關閉對話框
                                    },
                                  ),
                                  CupertinoButton(
                                    color: CupertinoColors.destructiveRed,
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(fontSize: 35),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context); // 關閉對話框
                                      widget.onDelete(); // 執行刪除邏輯
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
