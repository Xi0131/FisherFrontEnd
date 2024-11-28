import 'package:flutter/cupertino.dart';

class CtNotificationPage extends StatefulWidget {
  const CtNotificationPage({super.key});

  @override
  State<CtNotificationPage> createState() => _CtNotificationPageState();
}

class _CtNotificationPageState extends State<CtNotificationPage> {
  // Sample list of notifications
  List<Map<String, dynamic>> notifications = [
    {
      "title": "New Message",
      "message": "You have received a new message.",
    },
    {
      "title": "Task Reminder",
      "message": "Don't forget to complete your task.",
    },
    {
      "title": "Update Available",
      "message": "A new update is ready to install.",
    },
    {
      "title": "Meeting Scheduled",
      "message": "Your meeting is scheduled for tomorrow.",
    },
  ];

  void _deleteNotification(Map<String, dynamic> notification) {
    setState(() {
      for (final element in notifications) {
        if (element['title'] == notification['title']) {
          notifications.remove(element);
        }
      }
      debugPrint('noti len = ${notifications.length.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          leading: CupertinoButton(
            padding: const EdgeInsets.all(0),
            onPressed: () => Navigator.pop(context),
            child: const SizedBox(child: Icon(CupertinoIcons.back)),
          ),
        ),
        child: SafeArea(
            child: notifications.isNotEmpty
                // case when there is notifications
                ? CupertinoListSection.insetGrouped(
                    children: [
                      for (final notification in notifications)
                        CupertinoListTile(
                          leading: const SizedBox(),
                          title: Text(notification['title']),
                          subtitle: Text(notification['message']),
                          trailing: CupertinoButton(
                            padding: const EdgeInsets.all(0),
                            child: const Icon(
                              CupertinoIcons.xmark,
                              color: CupertinoColors.destructiveRed,
                            ),
                            onPressed: () => _deleteNotification(notification),
                          ),
                        )
                    ],
                  )
                // case when there is no notifications
                : const Center(child: Text('There is no notifications left'))));
  }
}
