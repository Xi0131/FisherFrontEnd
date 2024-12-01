import 'dart:io';

import 'package:flutter/cupertino.dart';

// 人員卡片
class PersonnelCard extends StatelessWidget {
  final String name;
  final String number;
  final String image; // 假設這是員工圖片的路徑或 URL
  final VoidCallback onTap;

  const PersonnelCard({
    super.key,
    required this.name,
    required this.number,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, //長方形大小
              height: 180, //圓形大小
              decoration: const BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: image.isNotEmpty
                  ? ClipOval(
                      child: Image.file(
                        File(image), // 顯示本地圖片
                        fit: BoxFit.cover,
                        width: 300,
                        height: 180,
                      ),
                    )
                  : const Icon(
                      CupertinoIcons.person,
                      size: 90,
                      color: CupertinoColors.white,
                    ),
            ),
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.black,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "No. $number",
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontSize: 40,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
