import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CrewCalendar extends StatefulWidget {
  const CrewCalendar({Key? key}) : super(key: key);

  @override
  _CrewCalendarState createState() => _CrewCalendarState();
}

class _CrewCalendarState extends State<CrewCalendar> {
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double gridPadding = 16.0;
    final double cellSpacing = 8.0;
    final double cellSize = (screenWidth - gridPadding * 2 - cellSpacing * 6) / 7;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10.0,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // 年份和月份選擇
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$selectedYear | ${_getMonthName(selectedMonth).toUpperCase()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right),
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
            const SizedBox(height: 10),
            // 星期標頭
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Text('Mon'),
                Text('Tue'),
                Text('Wed'),
                Text('Thu'),
                Text('Fri'),
                Text('Sat'),
                Text('Sun'),
              ],
            ),
            const SizedBox(height: 10),
            // 滾動月曆網格
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  shrinkWrap: true, // 嵌套滾動
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7, // 一週七天
                    crossAxisSpacing: cellSpacing,
                    mainAxisSpacing: cellSpacing,
                    childAspectRatio: 1.0, // 保持正方形
                  ),
                  itemCount: _getGridItemCount(selectedYear, selectedMonth),
                  itemBuilder: (context, index) {
                    final daysInMonth =
                    DateUtils.getDaysInMonth(selectedYear, selectedMonth);
                    final firstWeekday = _getFirstWeekdayOfMonth(selectedYear, selectedMonth);

                    if (index < firstWeekday - 1) {
                      return const SizedBox(); // 空白方格
                    } else {
                      int day = index - (firstWeekday - 2);
                      if (day > daysInMonth) {
                        return const SizedBox();
                      }
                      return GestureDetector(
                        onTap: () {
                          // 點擊日期顯示詳情
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                  '$selectedYear年${_getMonthName(selectedMonth)}$day日'),
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
                            color: Colors.grey[100],
                          ),
                          child: Text('$day'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(BuildContext context) {
    int tempYear = selectedYear;
    int tempMonth = selectedMonth;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("取消"),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        selectedYear = tempYear;
                        selectedMonth = tempMonth;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("確定"),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: DateTime.now().year - tempYear + 25,
                        ),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          tempYear = DateTime.now().year - 25 + index;
                        },
                        children: List.generate(
                          50,
                              (index) => Center(
                            child: Text(
                              '${DateTime.now().year - 25 + index}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(width: 1, color: Colors.grey),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: tempMonth - 1,
                        ),
                        itemExtent: 40,
                        onSelectedItemChanged: (index) {
                          tempMonth = index + 1;
                        },
                        children: List.generate(
                          12,
                              (index) => Center(
                            child: Text(
                              _getMonthName(index + 1),
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _getFirstWeekdayOfMonth(int year, int month) {
    return DateTime(year, month, 1).weekday;
  }

  int _getGridItemCount(int year, int month) {
    final daysInMonth = DateUtils.getDaysInMonth(year, month);
    final firstWeekday = _getFirstWeekdayOfMonth(year, month);
    return daysInMonth + firstWeekday - 1;
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[month - 1];
  }
}
