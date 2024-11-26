import 'package:flutter/material.dart';

class CrewDatePicker extends StatelessWidget {
  const CrewDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 月份標題
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.arrow_left), // 向左切換月份
              Text(
                'July 2024',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.arrow_right), // 向右切換月份
            ],
          ),
        ),
        // 日期方格
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 一週七天
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: 31, // 假設顯示 31 天
            itemBuilder: (context, index) {
              int day = index + 1;
              return GestureDetector(
                onTap: () {
                  // 點擊日期顯示對話框
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('$day 日工作狀態'),
                      content: const Text('顯示當天的詳細工作'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('關閉'),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text('$day'), // 日期
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
