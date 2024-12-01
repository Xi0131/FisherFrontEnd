import 'package:flutter/cupertino.dart';
import 'package:fisher_front_end/widgets/crew_view/crew_info.dart';
import 'package:fisher_front_end/widgets/crew_view/crew_calendar.dart';

class CrewPage extends StatefulWidget {
  @override
  _CrewPageState createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('船員資訊'),
        // 添加返回鍵（登出）
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back),
          onPressed: () {
            // 彈出確認登出對話框
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: Text('登出'),
                content: Text('確定要登出嗎？'),
                actions: [
                  CupertinoDialogAction(
                    child: Text('取消'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoDialogAction(
                    child: Text('確定'),
                    onPressed: () {
                      Navigator.pop(context); // 關閉對話框
                      // 執行登出操作，例如導航到登入頁面
                      // Navigator.pushReplacementNamed(context, 'loginPage');
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
            // 左側：船員資訊
            Expanded(
              flex: 1,
              child: CrewInfo(),
            ),
            // 右側：月曆
            Expanded(
              flex: 3, // 增加右側月曆的佔比
              child: CrewCalendar(),
            ),
          ],
        ),
      ),
    );
  }
}
