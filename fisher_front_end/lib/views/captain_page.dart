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
  List<int> workingHour = List.generate(48, (index) => 0);
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
      "isRecorded": true
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
  // {
  //   "workerID": 123,
  //   "isSelected": false,
  //   "isRecorded": false
  // }

  @override
  void initState() {
    setState(() {
      workerList.sort(
        (a, b) {
          if (a['isRecorded'] == true && b['isRecorded'] == true) {
            return 1;
          } else {
            return 0;
          }
        },
      );
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
      // i cant think about any better implementation at the moment :(
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

  void onSetWorkingHour(List<int> newWorkingHour) {
    for (int i = 0; i < 48; i++) {
      workingHour[i] = newWorkingHour[i];
    }
  }

  void onSaveInfo() {
    for (Map<String, dynamic> worker in workerStatus) {
      if (worker['isSelected']) {
        // for()
        worker['isSelected'] = false;
        worker['isRecorded'] = true;
      }
    }
    // send save through api
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CTNavigatorBar(context: context),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DatePicker(date: date, onUpdateDate: onUpdateDate),
            // show workers
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              width: 1200,
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
                  itemBuilder: (context, index) => IdCard(
                    workerID: workerList[index]['workerID'],
                    workerImage: Image.asset('default.png'),
                    workerName: workerList[index]['workerName'],
                    workerType: workerList[index]['workerType'],
                    isRecorded: workerList[index]['isRecorded'],
                    onWorkerSelect: onWorkerSelect,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            WorkingHourPicker(
              timeSelected: workingHour,
              onSetWorkingHour: onSetWorkingHour,
            ),
            const SizedBox(height: 30),
            CupertinoButton(
              color: CupertinoColors.systemGrey6,
              onPressed: onSaveInfo,
              child: const SizedBox(
                height: 40,
                width: 100,
                child: Center(
                  child: Text(
                    'Save data',
                    style: TextStyle(
                        fontSize: 20, color: CupertinoColors.activeBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
