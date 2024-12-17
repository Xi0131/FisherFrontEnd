import 'package:flutter/cupertino.dart';
import 'package:fisher_front_end/widgets/crew_view/crew_info.dart';
import 'package:fisher_front_end/widgets/crew_view/crew_calendar.dart';

class CrewPage extends StatefulWidget {
  const CrewPage({super.key});

  @override
  State<CrewPage> createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {
  // 假設這裡有 workerId
  final int workerId = 10; // 請根據實際情況替換為真實的 workerId

  void logout(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('船員資訊'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            showCupertinoDialog(
              useRootNavigator: false,
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text('登出'),
                content: const Text('確定要登出嗎？'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('取消'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text('確定'),
                    onPressed: () {
                      Navigator.pop(context); // 關閉對話框
                      Navigator.pop(context); // 返回上一頁
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              // 傳入 workerId
              child: CrewInfo(workerId: workerId),
            ),
            Expanded(
              flex: 3,
              // 傳入 workerId
              child: CrewCalendar(workerId: workerId),
            ),
          ],
        ),
      ),
    );
  }
}
