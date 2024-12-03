import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui; // 為了使用 ui.Image，需要導入 dart:ui
import 'signature_pad.dart'; // 確保導入 signature_pad.dart

class CrewCalendar extends StatefulWidget {
  const CrewCalendar({super.key});

  @override
  State<CrewCalendar> createState() => _CrewCalendarState();
}

class _CrewCalendarState extends State<CrewCalendar> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 月份選擇器
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.left_chevron),
                onPressed: () {
                  setState(() {
                    if (selectedMonth == 1) {
                      selectedMonth = 12;
                      selectedYear--;
                    } else {
                      selectedMonth--;
                    }
                  });
                },
              ),
              CupertinoButton(
                child: Row(
                  children: [
                    Text(
                      '$selectedYear年 ${_getMonthName(selectedMonth)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    const Icon(CupertinoIcons.chevron_down),
                  ],
                ),
                onPressed: () => _showPicker(context),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.right_chevron),
                onPressed: () {
                  setState(() {
                    if (selectedMonth == 12) {
                      selectedMonth = 1;
                      selectedYear++;
                    } else {
                      selectedMonth++;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        // 星期標題
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: ['一', '二', '三', '四', '五', '六', '日']
                .map(
                  (e) => Expanded(
                    child: Center(
                      child: Text(
                        e,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        // 月曆網格
        Expanded(
          child: _buildCalendarGrid(),
        ),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    int daysInMonth = _getDaysInMonth(selectedYear, selectedMonth);
    int firstWeekday = _getFirstWeekdayOfMonth(selectedYear, selectedMonth);

    // 計算需要顯示的總單元格數量
    int totalCells = ((daysInMonth + firstWeekday - 1) / 7).ceil() * 7;

    return LayoutBuilder(
      builder: (context, constraints) {
        double gridWidth = constraints.maxWidth;
        double gridHeight = constraints.maxHeight;

        // 減小格子之間的間距
        double cellMargin = 1.0;

        // 計算格子的寬度和高度，確保不會超出可用空間
        double cellWidth = (gridWidth - cellMargin * 2 * 7) / 7;
        int numberOfRows = (totalCells / 7).ceil();
        double cellHeight =
            (gridHeight - cellMargin * 2 * numberOfRows) / numberOfRows;

        return GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(), // 禁用滾動
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 一週7天
            childAspectRatio: cellWidth / cellHeight, // 根據計算結果設定寬高比
            crossAxisSpacing: cellMargin * 2,
            mainAxisSpacing: cellMargin * 2,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            int dayNum = index - firstWeekday + 2;
            if (index < firstWeekday - 1 || dayNum > daysInMonth) {
              // 空白單元格
              return Container(
                margin: EdgeInsets.all(cellMargin),
              );
            } else {
              // 日期單元格
              return GestureDetector(
                onTap: () {
                  _showDayDetail(context, dayNum);
                },
                child: Container(
                  margin: EdgeInsets.all(cellMargin),
                  alignment: Alignment.center,
                  child: Text('$dayNum'),
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showPicker(BuildContext context) {
    int tempYear = selectedYear;
    int tempMonth = selectedMonth;

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          children: [
            // 操作按鈕
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: const Text('取消'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text('確定'),
                  onPressed: () {
                    setState(() {
                      selectedYear = tempYear;
                      selectedMonth = tempMonth;
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            // 年月選擇器
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: tempYear - 2000,
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (int index) {
                        tempYear = 2000 + index;
                      },
                      children: List<Widget>.generate(50, (int index) {
                        return Center(
                          child: Text('${2000 + index}年'),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                        initialItem: tempMonth - 1,
                      ),
                      itemExtent: 32,
                      onSelectedItemChanged: (int index) {
                        tempMonth = index + 1;
                      },
                      children: List<Widget>.generate(12, (int index) {
                        return Center(
                          child: Text('${index + 1}月'),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDayDetail(BuildContext context, int day) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('$selectedYear年$selectedMonth月$day日'),
        content: Column(
          children: [
            const SizedBox(height: 10),
            const Text('顯示當天的詳細工作情況（時數）'),
            const SizedBox(height: 16),
            // 替換簽名區域為簽名按鈕
            CupertinoButton(
              child: const Text('點擊簽名'),
              onPressed: () {
                Navigator.pop(context); // 關閉當前對話框
                _showSignaturePad(context, day);
              },
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showSignaturePad(BuildContext context, int day) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => SignaturePad(
          onSignComplete: (ui.Image image) {
            // 在這裡處理簽名圖片（例如，保存或顯示）
            // 現在，我們只是顯示一個確認對話框
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('簽名已保存'),
                content: const Text('您的簽名已成功保存。'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('確定'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  int _getFirstWeekdayOfMonth(int year, int month) {
    // 在 Dart 中，星期一為 1，星期天為 7
    int weekday = DateTime(year, month, 1).weekday;
    return weekday;
  }

  int _getDaysInMonth(int year, int month) {
    if (month == 12) {
      return DateTime(year + 1, 1, 0).day;
    } else {
      return DateTime(year, month + 1, 0).day;
    }
  }

  String _getMonthName(int month) {
    const months = [
      '一月',
      '二月',
      '三月',
      '四月',
      '五月',
      '六月',
      '七月',
      '八月',
      '九月',
      '十月',
      '十一月',
      '十二月',
    ];
    return months[month - 1];
  }
}
