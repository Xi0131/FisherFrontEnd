import 'package:fisher_front_end/widgets/ct_view/date_picker.dart';
import 'package:fisher_front_end/widgets/ct_view/id_card.dart';
import 'package:fisher_front_end/widgets/ct_view/working_hour_picker.dart';
import 'package:fisher_front_end/widgets/navigation_bar/ct_navigator_bar.dart';
import 'package:flutter/cupertino.dart';

class CaptainPage extends StatefulWidget {
  const CaptainPage({super.key});

  @override
  State<CaptainPage> createState() => _CaptainPageState();
}

class _CaptainPageState extends State<CaptainPage> {
  DateTime date = DateTime.now();
  int workingTimeSelected12 =
      0; // uses bitmask to save the first 12 hours working hour
  int workingTimeSelected24 =
      0; // uses bitmask to save the last 12 hours working hour

  // List of items
  List<Map<String, dynamic>> workerList = [
    {
      "workerID": 1,
      "workerName": "Name 1",
      "workerType": "Type 1",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 2,
      "workerName": "Name 2",
      "workerType": "Type 2",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 3,
      "workerName": "Name 3",
      "workerType": "Type 3",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 4,
      "workerName": "Name 4",
      "workerType": "Type 4",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 5,
      "workerName": "Name 5",
      "workerType": "Type 5",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 6,
      "workerName": "Name 6",
      "workerType": "Type 6",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 7,
      "workerName": "Name 7",
      "workerType": "Type 7",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 8,
      "workerName": "Name 8",
      "workerType": "Type 8",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 9,
      "workerName": "Name 1",
      "workerType": "Type 1",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 10,
      "workerName": "Name 2",
      "workerType": "Type 2",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 11,
      "workerName": "Name 3",
      "workerType": "Type 3",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 12,
      "workerName": "Name 4",
      "workerType": "Type 4",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 13,
      "workerName": "Name 5",
      "workerType": "Type 5",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 14,
      "workerName": "Name 6",
      "workerType": "Type 6",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 15,
      "workerName": "Name 7",
      "workerType": "Type 7",
      "workingTime": 0,
      "isRecorded": false
    },
    {
      "workerID": 16,
      "workerName": "Name 8",
      "workerType": "Type 8",
      "workingTime": 0,
      "isRecorded": true
    },
  ];

  List<Map<String, dynamic>> workerStatus = [];
  List<Map<String, dynamic>> workingHour = [];

  @override
  void initState() {
    setState(() {
      for (final element in workerList) {
        workerStatus.add({
          "workerID": element['workerID'],
          "isSelected": false,
          "isRecorded": element['isRecorded']
        });
      }
    });
    // debugPrint(workerStatus.toString());
    super.initState();
  }

  void onUpdateDate(DateTime newDate) {
    setState(
      () => date = newDate,
    );
  }

  void onWorkerSelect(int workerID) {
    setState(() {
      for (Map<String, dynamic> worker in workerStatus) {
        if (worker['workerID'] == workerID) {
          worker['isSelected'] = !worker['isSelected'];
          worker['isSelected']
              ? debugPrint('Worker $workerID is selected')
              : debugPrint('Worker $workerID is deselected');
          break;
        }
      }
    });
  }

  void onUpdate12(int newWorkingTimeSelected12) {
    setState(
      () => workingTimeSelected12 = newWorkingTimeSelected12,
    );
  }

  void onUpdate24(int newWorkingTimeSelected24) {
    setState(
      () => workingTimeSelected12 = newWorkingTimeSelected24,
    );
  }

  void onSaveInfo() {
    // setState(() {
    //   workerStatus = workerStatus
    //       .where(
    //         (element) => element['isRecorded'] == true,
    //       )
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CTNavigatorBar(context: context),
      child: SafeArea(
        child: Column(
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
                    childAspectRatio: 2, // Width / Height ratio
                  ),
                  itemCount: workerList.length,
                  itemBuilder: (context, index) {
                    return IdCard(
                      workerID: workerList[index]['workerID'],
                      workerImage: Image.asset('default.png'),
                      workerName: workerList[index]['workerName'],
                      workerType: workerList[index]['workerType'],
                      isRecorded: workerList[index]['isRecorded'],
                      onWorkerSelect: onWorkerSelect,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            WorkingHourPicker(
              workingTimeSelected12: workingTimeSelected12,
              workingTimeSelected24: workingTimeSelected24,
              onUpdate12: onUpdate12,
              onUpdate24: onUpdate24,
            ),
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
        ),
      ),
    );
  }
}
