import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'edit.dart' ;//導入 EditPersonnelPage
import 'add_people.dart';

class PeopleManagementPage extends StatefulWidget {
  const PeopleManagementPage({super.key});

  @override
  PeopleManagementPageState createState() => PeopleManagementPageState();
}

class PeopleManagementPageState extends State<PeopleManagementPage> {
  final List<Map<String, String>> personnel = [
    //{"name": "John", "number": "001", "role": "Fisherman", "passport": "1990-01-01", "country": "USA", "image": "path_to_image"},
    //{"name": "Jane", "number": "002", "role": "Deckhands", "passport": "1995-02-02", "country": "Canada", "image": "path_to_image"},
    // {"name": "John", "number": "001", "role": "Fisherman", "passport": "1990-01-01", "country": "USA"},
    // {"name": "Jane", "number": "002", "role": "Deckhands", "passport": "1995-02-02", "country": "Canada"},
    // {"name": "Tom", "number": "003", "role": "FishProcessors", "passport": "1988-03-03", "country": "UK"},
  ];

  String selectedCategory = 'All';
  final List<String> categories = [
    'All',
    'Fisherman',
    'Deckhands',
    'FishProcessors',
    'Engineers',
    'Chef',
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredPersonnel = selectedCategory == 'All'
        ? personnel
        : personnel
        .where((person) => person['role'] == selectedCategory)
        .toList();

    return CupertinoPageScaffold(
      // *** 新增 navigationBar ***
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton( // *** 新增左側返回按鈕 ***
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
      // *** navigationBar 區域結束 ***
      child: Column(
        children: [
          // 頂部分類按鈕
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 5),
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: categories.map((category) {
                  bool isSelected = category == selectedCategory;
                  return Expanded( // 使用 Expanded 讓按鈕等分螢幕寬度
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // 控制按鈕間距
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? CupertinoColors.activeBlue
                                : CupertinoColors.lightBackgroundGray,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center( // 讓文字置中
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? CupertinoColors.white
                                    : CupertinoColors.black,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),


          // 卡片區域
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 每行顯示 5 個卡片
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4, // 調整卡片比例
              ),
              itemCount: filteredPersonnel.length + 1, // 包含新增按鈕
              itemBuilder: (context, index) {
                if (index == filteredPersonnel.length) { //如果按了新增按鈕
                  return AddNewButton(onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => AddPersonnelPage(
                          onAdd: (newPerson) {
                            setState(() {
                              personnel.add(newPerson); // 新增人員
                            });
                          },
                          existingNumbers: personnel.map((person) => person['number']!).toList(),
                        ),
                      ),
                    );
                  });
                }

                final person = filteredPersonnel[index];// 人員卡片點擊
                final originalIndex = personnel.indexWhere((p) => p['number'] == person['number']); // 確保正確匹配原始數據
                return PersonnelCard(
                  name: person["name"]!,
                  number: person["number"]!,
                  image: person["image"] ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditPersonnelPage(
                          person: Map<String, String>.from(personnel[originalIndex]), // 使用原始數據
                          onDelete: () {
                            setState(() {
                              personnel.removeAt(originalIndex); // 刪除原始數據
                            });
                            Navigator.pop(context);
                          },
                          onSave: (updatedPerson) {
                            setState(() {
                              personnel[originalIndex] = updatedPerson; // 更新原始數據
                            });
                          },
                          existingNumbers: personnel.map((person) => person['number']!).toList(),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 人員卡片
class PersonnelCard extends StatelessWidget {
  final String name;
  final String number;
  final String image; // 假設這是員工圖片的路徑或 URL
  final VoidCallback onTap;

  const PersonnelCard({
    super.key,
    required this.name,
    required this.number,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,//長方形大小
              height: 180,//圓形大小
              decoration: const BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: image.isNotEmpty
                  ? ClipOval(
                child: Image.file(
                  File(image),  // 顯示本地圖片
                  fit: BoxFit.cover,
                  width: 300,
                  height: 180,
                ),
              )
                  : const Icon(
                CupertinoIcons.person,
                size: 90,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(

              "No. $number",
              style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 新增按鈕
class AddNewButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddNewButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Icon(
              CupertinoIcons.add_circled,
              size: 180,
              color: CupertinoColors.activeBlue,
            ),
            SizedBox(height: 10),
            Text(
              "Add New",
              style: TextStyle(
                color: CupertinoColors.activeBlue,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:fisher_front_end/views/edit_personnel_page.dart'; //導入 EditPersonnelPage
// import 'package:flutter/cupertino.dart';
// import 'add_people.dart';

// class WorkerManagementPage extends StatefulWidget {
//   const WorkerManagementPage({super.key});

//   @override
//   WorkerManagementPageState createState() => WorkerManagementPageState();
// }

// class WorkerManagementPageState extends State<WorkerManagementPage> {
//   final List<Map<String, String>> personnel = [
//     {
//       "name": "John",
//       "number": "001",
//       "role": "Fisherman",
//       "birthday": "1990-01-01",
//       "country": "USA"
//     },
//     {
//       "name": "Jane",
//       "number": "002",
//       "role": "Deckhands",
//       "birthday": "1995-02-02",
//       "country": "Canada"
//     },
//     {
//       "name": "Tom",
//       "number": "003",
//       "role": "FishProcessors",
//       "birthday": "1988-03-03",
//       "country": "UK"
//     },
//   ];

//   String selectedCategory = 'All';
//   final List<String> categories = [
//     'All',
//     'Fisherman',
//     'Deckhands',
//     'FishProcessors',
//     'Engineers',
//     'Cook',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, String>> filteredPersonnel = selectedCategory == 'All'
//         ? personnel
//         : personnel
//             .where((person) => person['role'] == selectedCategory)
//             .toList();

//     return CupertinoPageScaffold(
//       child: Column(
//         children: [
//           // 頂部分類按鈕
//           Padding(
//             padding: const EdgeInsets.only(top: 20, bottom: 10),
//             child: SizedBox(
//               height: 80,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: categories.map((category) {
//                   bool isSelected = category == selectedCategory;
//                   return Expanded(
//                     // 使用 Expanded 讓按鈕等分螢幕寬度
//                     child: Padding(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 10), // 控制按鈕間距
//                       child: CupertinoButton(
//                         padding: EdgeInsets.zero,
//                         onPressed: () {
//                           setState(() {
//                             selectedCategory = category;
//                           });
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           decoration: BoxDecoration(
//                             color: isSelected
//                                 ? CupertinoColors.activeBlue
//                                 : CupertinoColors.lightBackgroundGray,
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           child: Center(
//                             // 讓文字置中
//                             child: Text(
//                               category,
//                               style: TextStyle(
//                                 color: isSelected
//                                     ? CupertinoColors.white
//                                     : CupertinoColors.black,
//                                 fontSize: 35,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),

//           // 卡片區域
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 5, // 每行顯示 5 個卡片
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 childAspectRatio: 3 / 4, // 調整卡片比例
//               ),
//               itemCount: filteredPersonnel.length + 1, // 包含新增按鈕
//               itemBuilder: (context, index) {
//                 if (index == filteredPersonnel.length) {
//                   return AddNewButton(onTap: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => AddPersonnelPage(
//                           onAdd: (newPerson) {
//                             setState(() {
//                               personnel.add(newPerson); // 新增人員
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                     // 添加人員邏輯
//                     // showCupertinoDialog(
//                     //   context: context,
//                     //   builder: (context) => CupertinoAlertDialog(
//                     //     title: const Text("Add New"),
//                     //     content: const Text("Add new personnel feature."),
//                     //     actions: [
//                     //       CupertinoDialogAction(
//                     //         onPressed: () => Navigator.pop(context),
//                     //         child: const Text("OK"),
//                     //       ),
//                     //     ],
//                     //   ),
//                     // );
//                   });
//                 }

//                 final person = filteredPersonnel[index]; // 人員卡片點擊
//                 final originalIndex = personnel.indexWhere(
//                     (p) => p['number'] == person['number']); // 確保正確匹配原始數據
//                 return PersonnelCard(
//                   name: person["name"]!,
//                   number: person["number"]!,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                         builder: (context) => EditPersonnelPage(
//                           person: Map<String, String>.from(
//                               personnel[originalIndex]), // 使用原始數據
//                           onDelete: () {
//                             setState(() {
//                               personnel.removeAt(originalIndex); // 刪除原始數據
//                             });
//                             Navigator.pop(context);
//                           },
//                           onSave: (updatedPerson) {
//                             setState(() {
//                               personnel[originalIndex] =
//                                   updatedPerson; // 更新原始數據
//                             });
//                           },
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 人員卡片
// class PersonnelCard extends StatelessWidget {
//   final String name;
//   final String number;
//   final VoidCallback onTap;

//   const PersonnelCard({
//     super.key,
//     required this.name,
//     required this.number,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//       onPressed: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: CupertinoColors.systemGrey6,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 300, //長方形大小
//               height: 180, //圓形大小
//               decoration: const BoxDecoration(
//                 color: CupertinoColors.activeBlue,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 CupertinoIcons.person,
//                 size: 90,
//                 color: CupertinoColors.white,
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               name,
//               style: const TextStyle(
//                 fontSize: 40,
//                 fontWeight: FontWeight.bold,
//                 color: CupertinoColors.black,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "No. $number",
//               style: const TextStyle(
//                 color: CupertinoColors.systemGrey,
//                 fontSize: 40,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // 新增按鈕
// class AddNewButton extends StatelessWidget {
//   final VoidCallback onTap;

//   const AddNewButton({super.key, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoButton(
//       onPressed: onTap,
//       child: Container(
//         width: 300,
//         decoration: BoxDecoration(
//           color: CupertinoColors.systemGrey6,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         padding: const EdgeInsets.all(15),
//         child: const Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               CupertinoIcons.add_circled,
//               size: 180,
//               color: CupertinoColors.activeBlue,
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Add New",
//               style: TextStyle(
//                 color: CupertinoColors.activeBlue,
//                 fontSize: 40,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
