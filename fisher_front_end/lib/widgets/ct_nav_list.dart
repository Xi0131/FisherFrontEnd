import 'package:flutter/cupertino.dart';

class CTNavList extends StatelessWidget {
  const CTNavList({super.key});

  @override
  Widget build(BuildContext context) {
    int numberOfNotices = 0;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => Navigator.pop(context),
          child: const SizedBox(child: Icon(CupertinoIcons.back)),
        ),
      ),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          header: const Text('Management'),
          children: [
            CupertinoListTile.notched(
              title: const Text('Working Hour Management'),
              leading: Container(
                width: double.infinity,
                height: double.infinity,
                color: CupertinoColors.activeGreen,
              ),
              trailing: const Icon(CupertinoIcons.right_chevron),
              // should be modify one combine with login page
              onTap: () => Navigator.pop(context),
            ),
            CupertinoListTile.notched(
              title: const Text('Worker Management'),
              leading: Container(
                width: double.infinity,
                height: double.infinity,
                color: CupertinoColors.activeOrange,
              ),
              trailing: const Icon(CupertinoIcons.right_chevron),
              onTap: null,
            ),
            CupertinoListTile.notched(
              title: const Text('Notifications'),
              leading: Container(
                width: double.infinity,
                height: double.infinity,
                color: CupertinoColors.systemRed,
              ),
              trailing: Text('$numberOfNotices'),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}
