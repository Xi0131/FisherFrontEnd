import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class AddPersonnelPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd; // 用於回調新增的資料
  final List<String> existingNumbers; // 現有編號列表

  const AddPersonnelPage({
    super.key,
    required this.onAdd,
    required this.existingNumbers,
  });

  @override
  AddPersonnelPageState createState() => AddPersonnelPageState();
}

class AddPersonnelPageState extends State<AddPersonnelPage> {
  // 控制輸入框的控制器
  late TextEditingController nameController;
  late TextEditingController numberController;
  late TextEditingController passportController;
  late TextEditingController countryController;
  late TextEditingController ageController;

  File? _image; // 用於保存圖片
  //當用戶選擇圖片時，觸發此方法
  Future<void> _pickImage() async {
    //IPad
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // 保存選擇的圖片
      });
    }
  }

  // // Work Type 選擇值
  String selectedWorkType = "Select Work Type"; // 預設選擇值
  final List<String> workTypes = [
    "Select Work Type",
    "Fisherman",
    "Deckhands",
    "FishProcessors",
    "Engineers",
    "Chef"
  ];

  // 用於顯示錯誤訊息的布林值
  bool isNameEmpty = false;
  bool isNumberEmpty = false;
  bool isWorkTypeEmpty = false;
  bool isNumberDuplicate = false;

  @override
  void initState() {
    super.initState();
    // 初始化每個 TextEditingController，預設為空
    nameController = TextEditingController();
    numberController = TextEditingController();
    passportController = TextEditingController();
    countryController = TextEditingController();
    ageController = TextEditingController();
  }

  @override
  void dispose() {
    // 釋放 TextEditingController 資源
    nameController.dispose();
    numberController.dispose();
    passportController.dispose();
    countryController.dispose();
    ageController.dispose();
    super.dispose();
  }

  // *** 新增方法：檢查必填欄位並提示錯誤 ***
  void validateAndAdd() {
    setState(() {
      isNameEmpty = nameController.text.trim().isEmpty;
      isNumberEmpty = numberController.text.trim().isEmpty;
      isWorkTypeEmpty = selectedWorkType == "Select Work Type";
      // 檢查編號是否重複
      isNumberDuplicate =
          widget.existingNumbers.contains(numberController.text.trim());
    });
    // 如果所有必填項都填寫，新增人員
    if (!isNameEmpty &&
        !isNumberEmpty &&
        !isWorkTypeEmpty &&
        !isNumberDuplicate) {
      widget.onAdd({
        "name": nameController.text,
        "number": numberController.text,
        "passport": passportController.text,
        "country": countryController.text,
        "age": ageController.text,
        "role": selectedWorkType,
        "image": _image?.path ?? "", // 加入圖片路徑
      });
      Navigator.pop(context); // 返回主頁面
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        //上一頁
        leading: CupertinoButton(
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
                //上傳大頭照
                padding: EdgeInsets.zero, // 去掉預設的 padding
                onPressed: _pickImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CupertinoColors.systemGrey5,
                  ),
                  child: _image == null
                      ? const Icon(CupertinoIcons.photo, size: 50)
                      : ClipOval(
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: 200,
                            height: 200,
                          ),
                        ),
                ),
              ),
              //頭像圓形
              // Container(
              //   width: 200, // 藍色圈圈大小
              //   height: 200, // 藍色圈圈大小
              //   decoration: const BoxDecoration(
              //     color: CupertinoColors.activeBlue,
              //     shape: BoxShape.circle,
              //   ),
              //   child: const Icon(
              //     CupertinoIcons.person,
              //     size: 100, // 圓圈內的小人圖標大小
              //     color: CupertinoColors.white,
              //   ),
              // ),
              const SizedBox(height: 20),

              // 輸入框
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
              // Work Type 選單
              CupertinoButton(
                padding: EdgeInsets.zero, // 去除內邊距
                onPressed: () => _showWorkTypePicker(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isWorkTypeEmpty
                          ? CupertinoColors.destructiveRed // 如果為空，顯示紅色邊框
                          : CupertinoColors.lightBackgroundGray, // 否則顯示灰色邊框
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
                          style: TextStyle(
                            fontSize: 24,
                            color: selectedWorkType == "Select Work Type"
                                ? CupertinoColors.systemGrey // 預設顯示灰色
                                : CupertinoColors.black, // 選擇後顯示黑色
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

              const SizedBox(height: 40),

              // 按鈕
              CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20), // 按鈕大小
                onPressed: validateAndAdd, // *** 按下時檢查必填欄位 ***
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 24), // 按鈕文字大小
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 通用的輸入框構造方法
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
                    isWorkTypeEmpty = selectedWorkType == "Select Work Type";
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
            // CupertinoButton(
            //   child: const Text("Confirm"),
            //   onPressed: () => Navigator.pop(context),
            // ),
          ],
        ),
      ),
    );
  }
}
