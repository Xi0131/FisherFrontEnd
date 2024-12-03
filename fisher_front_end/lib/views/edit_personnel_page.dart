import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditPersonnelPage extends StatefulWidget {
  final Map<String, String> person;
  final List<String> existingNumbers; // 傳入已有的編號列表
  final VoidCallback onDelete;
  final Function(Map<String, String>) onSave; // 添加保存回調

  const EditPersonnelPage({
    super.key,
    required this.person,
    required this.existingNumbers,
    required this.onDelete,
    required this.onSave,
  });

  @override
  EditPersonnelPageState createState() => EditPersonnelPageState();
}

class EditPersonnelPageState extends State<EditPersonnelPage> {
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController passportController;
  late TextEditingController countryController;
  late TextEditingController roleController;
  late TextEditingController ageController;

  File? _image; // 用來存儲選擇的圖片
  // 當用戶選擇圖片時觸發此方法
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 保存選擇的圖片
      });
    }
  }

  // // Work Type 選擇值
  String selectedWorkType = ""; // 初始工種設置
  final List<String> workTypes = [
    "Fisherman",
    "Deckhands",
    "FishProcessors",
    "Engineers",
    "Chef"
  ];

  // 用於顯示錯誤訊息的布林值
  bool isNameEmpty = false;
  bool isNumberEmpty = false;
  bool isNumberDuplicate = false; // 用於檢查編號是否重複

  @override
  void initState() {
    super.initState();
    // 初始化每個 TextEditingController，並設置初始值
    nameController = TextEditingController(text: widget.person['name']);
    numberController = TextEditingController(text: widget.person['number']);
    passportController = TextEditingController(text: widget.person['passport']);
    countryController = TextEditingController(text: widget.person['country']);
    roleController = TextEditingController(text: widget.person['role']);
    ageController = TextEditingController(text: widget.person['age']);
    // 初始化 selectedWorkType 為 person 資料中的工種（假設 'workType' 是 map 的一部分）
    selectedWorkType = widget.person['role'] ??
        "Select Work Type"; // 若 person 沒有 'workType'，則設為預設值
    // 初始化圖片為當前資料的圖片（如果有的話）
    _image =
        widget.person['image'] != "" ? File(widget.person['image']!) : null;
  }

  @override
  void dispose() {
    // 釋放 TextEditingController 資源
    nameController.dispose();
    numberController.dispose();
    passportController.dispose();
    countryController.dispose();
    roleController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // *** 新增方法：檢查必填欄位並提示錯誤 ***
  void validateAndAdd() {
    setState(() {
      isNameEmpty = nameController.text.trim().isEmpty;
      isNumberEmpty = numberController.text.trim().isEmpty;
      isNumberDuplicate =
          widget.existingNumbers.contains(numberController.text.trim()) &&
              numberController.text.trim() != widget.person['number'];
    });
    // 如果所有必填項都填寫，新增人員
    if (!isNameEmpty && !isNumberEmpty && !isNumberDuplicate) {
      Map<String, String> updatedPerson = {
        "name": nameController.text,
        "number": numberController.text,
        "passport": passportController.text,
        "country": countryController.text,
        "age": ageController.text,
        "role": selectedWorkType,
        "image": _image?.path ?? "", // 加入圖片路徑
      };
      widget.onSave(updatedPerson); // 調用保存回調
      Navigator.pop(context); // 返回主頁面
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // 返回鍵
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          // *** 新增左側返回按鈕 ***
          padding: EdgeInsets.zero, // 移除默認內邊距
          child: const Icon(
            CupertinoIcons.back, // 返回圖標
            size: 30, // 返回圖標大小
          ),
          onPressed: () {
            Navigator.pop(context); // 返回上一頁
          },
        ),
      ),
      child: SingleChildScrollView(
        // 滾動視窗
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: Column(
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero, // 去掉預設的 padding
                onPressed: _pickImage, // 點擊後選擇圖片
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.systemGrey5,
                  ),
                  child: _image == null
                      ? const Icon(CupertinoIcons.photo, size: 50) // 預設顯示圖標
                      : ClipOval(
                          child: Image.file(
                            _image!, // 顯示選擇的圖片
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              // 之後都是輸入框
              _buildTextField(
                controller: nameController,
                placeholder: "Name",
                isEmpty: isNameEmpty,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: numberController,
                placeholder: "Number",
                isEmpty: isNumberEmpty,
                isDuplicate: isNumberDuplicate,
              ),
              //age
              const SizedBox(height: 10),
              _buildCupertinoTextField(
                  placeholder: "Age", controller: ageController),

              const SizedBox(height: 10),
              _buildCupertinoTextField(
                  placeholder: "Passport", controller: passportController),

              const SizedBox(height: 10),
              _buildCupertinoTextField(
                  placeholder: "Country", controller: countryController),

              const SizedBox(height: 10),

              CupertinoButton(
                padding: EdgeInsets.zero, // 去除內邊距
                onPressed: () => _showWorkTypePicker(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CupertinoColors.lightBackgroundGray, // 否則顯示灰色邊框
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // 紅色米字號
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          '*',
                          style: TextStyle(
                            color: CupertinoColors.destructiveRed,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // 顯示選擇的工作類型或默認文本
                      Expanded(
                        child: Text(
                          selectedWorkType,
                          style: const TextStyle(
                            fontSize: 24,
                            color: CupertinoColors.black, // 選擇後顯示黑色
                          ),
                        ),
                      ),
                      // 下拉箭頭圖標
                      const Icon(
                        CupertinoIcons.chevron_down,
                        size: 24,
                        color: CupertinoColors.systemGrey, // 默認灰色箭頭
                      ),
                    ],
                  ),
                ),
              ),
              // CupertinoTextField(
              //   placeholder: "Work Type",
              //   controller: roleController,
              //   padding: const EdgeInsets.all(30),
              //   style: const TextStyle(fontSize: 24), //字體大小
              // ),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton.filled(
                    //
                    onPressed: validateAndAdd,
                    child: const Text(
                      "OK",
                      style: TextStyle(fontSize: 24), // OK 按鈕文字大小
                    ),
                  ),

                  // 刪除後確認是否要刪除
                  CupertinoButton(
                    color: CupertinoColors.destructiveRed,
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 24),
                    ),
                    onPressed: () {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: const Text('Are you sure?',
                                    style: TextStyle(fontSize: 30)),
                                content: const Text(
                                    'Do you really want to delete this person?',
                                    style: TextStyle(fontSize: 20)),
                                actions: [
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                      widget.onDelete(); // 執行刪除邏輯
                                    },
                                    child: const Text('Yes',
                                        style: TextStyle(fontSize: 20)),
                                  ),
                                ],
                              ));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 通用有米字號的輸入格
  Widget _buildTextField({
    required TextEditingController controller,
    required String placeholder,
    bool isEmpty = false,
    bool isDuplicate = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CupertinoTextField(
          placeholder: placeholder,
          controller: controller,
          padding: const EdgeInsets.only(top: 30, bottom: 30, left: 10),
          style: const TextStyle(
            fontSize: 24,
            color: CupertinoColors.black,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isEmpty || isDuplicate
                  ? CupertinoColors.destructiveRed // 如果為空或重複，顯示紅色邊框
                  : CupertinoColors.lightBackgroundGray, // 否則顯示灰色邊框
              width: 2,
            ),
          ),
          prefix: const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              '*', // 紅色米字號
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (isDuplicate) // 如果重複編號，提示錯誤
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "This number is already in use.", // 错误提示
              style: TextStyle(
                color: CupertinoColors.destructiveRed,
                fontSize: 16,
              ),
            ),
          ),
      ],
    );
  }

  //通用沒有米字號的輸入格
  Widget _buildCupertinoTextField({
    required String placeholder,
    required TextEditingController controller,
    EdgeInsetsGeometry padding =
        const EdgeInsets.only(top: 30, bottom: 30, left: 30),
    TextStyle textStyle = const TextStyle(fontSize: 24),
  }) {
    return CupertinoTextField(
      placeholder: placeholder,
      controller: controller,
      padding: padding,
      style: textStyle,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // 圓角邊框
        border: Border.all(
          color: CupertinoColors.lightBackgroundGray, // 邊框顏色
          width: 2, // 邊框寬度
        ),
      ),
    );
  }

  // 顯示 Work Type 選單
  void _showWorkTypePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            Expanded(
              child: CupertinoPicker(
                itemExtent: 50, // 每個選項的高度
                onSelectedItemChanged: (int index) {
                  setState(() {
                    selectedWorkType = workTypes[index];
                  });
                },
                children: workTypes
                    .map((type) => Center(
                          child: Text(
                            type,
                            style: const TextStyle(fontSize: 24),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
