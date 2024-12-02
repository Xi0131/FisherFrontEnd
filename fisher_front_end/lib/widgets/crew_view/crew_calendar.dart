import 'package:flutter/cupertino.dart';

class CrewCalendar extends StatefulWidget {
  @override
  _CrewCalendarState createState() => _CrewCalendarState();
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
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.left_chevron),
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
              GestureDetector(
                onTap: () => _showPicker(context),
                child: Row(
                  children: [
                    Text(
                      '$selectedYear ${_getMonthName(selectedMonth)}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Icon(CupertinoIcons.chevron_down),
                  ],
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.right_chevron),
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
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                .map(
                  (e) => Expanded(
                    child: Center(
                      child: Text(
                        e,
                        style: TextStyle(fontWeight: FontWeight.bold),
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
          physics: NeverScrollableScrollPhysics(), // 禁用滾動
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
                  child: Text('取消'),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: Text('確定'),
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
            SizedBox(height: 10),
            Text('顯示當天的詳細工作情況（時數）'),
            SizedBox(height: 16),
            // 簽名區域（這裡可以替換成實際的簽名元件）
            Container(
              height: 100,
              color: CupertinoColors.systemGrey4,
              child: Center(child: Text('簽名區域')),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            child: Text('取消'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: Text('確認'),
            onPressed: () {
              // 在這裡處理簽名確認的邏輯
              Navigator.pop(context);
            },
          ),
        ],
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
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
