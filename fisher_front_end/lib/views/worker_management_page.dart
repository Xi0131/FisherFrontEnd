import 'package:fisher_front_end/widgets/worker_management/add_new_button.dart';
import 'package:fisher_front_end/widgets/worker_management/personnel_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:fisher_front_end/views/edit_personnel_page.dart'; //導入 EditPersonnelPage
import 'add_people.dart';

class WorkerManagementPage extends StatefulWidget {
  const WorkerManagementPage({super.key});

  @override
  State<WorkerManagementPage> createState() => _WorkerManagementPageState();
}

class _WorkerManagementPageState extends State<WorkerManagementPage> {
  final List<Map<String, String>> personnel = [];

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
        middle: const Text('Crew Management'),
      ),
      // *** navigationBar 區域結束 ***
      child: Column(
        children: [
          // 頂部分類按鈕
          Padding(
            padding: const EdgeInsets.only(top: 80, bottom: 5),
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: categories.map((category) {
                  bool isSelected = category == selectedCategory;
                  return Expanded(
                    // 使用 Expanded 讓按鈕等分螢幕寬度
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10), // 控制按鈕間距
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
                          child: Center(
                            // 讓文字置中
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? CupertinoColors.white
                                    : CupertinoColors.black,
                                fontSize: 25,
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
                if (index == filteredPersonnel.length) {
                  //如果按了新增按鈕
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
                          existingNumbers: personnel
                              .map((person) => person['number']!)
                              .toList(),
                        ),
                      ),
                    );
                  });
                }

                final person = filteredPersonnel[index]; // 人員卡片點擊
                final originalIndex = personnel.indexWhere(
                    (p) => p['number'] == person['number']); // 確保正確匹配原始數據
                return PersonnelCard(
                  name: person["name"]!,
                  number: person["number"]!,
                  image: person["image"] ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => EditPersonnelPage(
                          person: Map<String, String>.from(
                              personnel[originalIndex]), // 使用原始數據
                          onDelete: () {
                            setState(() {
                              personnel.removeAt(originalIndex); // 刪除原始數據
                            });
                            Navigator.pop(context);
                          },
                          onSave: (updatedPerson) {
                            setState(() {
                              personnel[originalIndex] =
                                  updatedPerson; // 更新原始數據
                            });
                          },
                          existingNumbers: personnel
                              .map((person) => person['number']!)
                              .toList(),
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
