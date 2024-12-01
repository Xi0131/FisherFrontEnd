import 'package:flutter/cupertino.dart';

class CrewInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 確保 Container 填滿可用的垂直空間
      color: CupertinoColors.systemGrey5,
      child: Padding(
        padding: EdgeInsets.all(8), // 減小整個區塊的 padding，使區塊變小
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 放大圖片
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.person_solid,
                size: 60, // 增加圖標大小
                color: CupertinoColors.white,
              ),
            ),
            SizedBox(height: 12),
            // 放大文字
            Text(
              '船員姓名',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6),
            Text(
              '編號: 1234567',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 6),
            Text(
              '國籍: Taiwan',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 6),
            Text(
              '護照號碼: A12345678',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 6),
            Text(
              '工種: Engineer',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
