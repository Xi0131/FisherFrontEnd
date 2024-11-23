import 'package:fisher_front_end/widgets/date_picker.dart';
import 'package:fisher_front_end/widgets/id_card.dart';
import 'package:flutter/cupertino.dart';

class CaptainPage extends StatefulWidget {
  const CaptainPage({super.key});

  @override
  State<CaptainPage> createState() => _CaptainPageState();
}

class _CaptainPageState extends State<CaptainPage> {
  DateTime date = DateTime.now();
  int workingTimeSelected = 0;

  // List of items
  final List<Map<String, dynamic>> items = [
    {
      "workerName": "Name 1",
      "workerType": "Type 1",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 2",
      "workerType": "Type 2",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 3",
      "workerType": "Type 3",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 4",
      "workerType": "Type 4",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 5",
      "workerType": "Type 5",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 6",
      "workerType": "Type 6",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 7",
      "workerType": "Type 7",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 8",
      "workerType": "Type 8",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 1",
      "workerType": "Type 1",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 2",
      "workerType": "Type 2",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 3",
      "workerType": "Type 3",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 4",
      "workerType": "Type 4",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 5",
      "workerType": "Type 5",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 6",
      "workerType": "Type 6",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 7",
      "workerType": "Type 7",
      "workingTime": 0,
      "isSelected": false
    },
    {
      "workerName": "Name 8",
      "workerType": "Type 8",
      "workingTime": 0,
      "isSelected": false
    },
  ];

  void onUpdateDate(DateTime newDate) {
    setState(
      () => date = newDate,
    );
  }

  void _toggleTime(int index) {
    setState(() {
      workingTimeSelected =
          workingTimeSelected ^ (2 << index); // Toggle highlight state
    });
  }

  void onSaveInfo() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DatePicker(date: date, onUpdateDate: onUpdateDate),

        // show workers
        SizedBox(
          height: 300,
          width: 800,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5, // Space between rows
                crossAxisSpacing: 5, // Space between columns
                childAspectRatio: 1.5, // Width / Height ratio
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return IdCard(
                  workerImage: Image.asset('default.png'),
                  workerName: items[index]['workerName'],
                  workerType: items[index]['workerType'],
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              24,
              (items) {
                return SizedBox(
                  height: 25,
                  width: 25,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: const SizedBox(),
                    onPressed: () {},
                  ),
                );
              },
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              24,
              (index) {
                return SizedBox(
                  height: 25,
                  width: 25,
                  child: CupertinoButton(
                    color: CupertinoColors.activeBlue,
                    child: const SizedBox(),
                    onPressed: () {},
                  ),
                );
              },
            )),
        const SizedBox(
          height: 10,
        ),
        // The row widget here is to leave space for addition button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton(
              color: CupertinoColors.systemGrey6,
              onPressed: onSaveInfo,
              child: const Text(
                'Save data',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
