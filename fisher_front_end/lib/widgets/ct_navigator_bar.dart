import 'package:flutter/cupertino.dart';

class CTNavigatorBar extends StatefulWidget
    implements ObstructingPreferredSizeWidget {
  final BuildContext context;
  const CTNavigatorBar({super.key, required this.context});

  @override
  State<CTNavigatorBar> createState() => _CTNavigatorBarState();

  @override
  Size get preferredSize => const Size.fromHeight(44.0);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}

class _CTNavigatorBarState extends State<CTNavigatorBar> {
  bool _hasNotification = false;
  // State to control the red dot visibility
  void _toggleNotification() {
    setState(() {
      _hasNotification = !_hasNotification; // Toggle notification state
    });
  }

  void _showDialog(BuildContext context) {
    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Logout'),
        content: const Text('Do you want to logout?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () => _showDialog(context),
          child: const SizedBox(child: Icon(CupertinoIcons.back)),
        ),
        middle: const Text('Worker Management'),
        trailing: Stack(
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(0),
              onPressed: () {
                _toggleNotification();
              },
              child: const SizedBox(
                child: Icon(CupertinoIcons.settings),
              ),
            ),
            if (_hasNotification) // Show red dot if notification exists
              Positioned(
                right: 4, // Adjust position relative to the icon
                top: 4,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: CupertinoColors.systemRed,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ));
  }
}
