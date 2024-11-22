import 'package:flutter/cupertino.dart';

class CaptainPage extends StatefulWidget {
  const CaptainPage({super.key});

  @override
  State<CaptainPage> createState() => _CaptainPageState();
}

class _CaptainPageState extends State<CaptainPage> {
  DateTime date = DateTime.now();

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: CupertinoButton(
                  child: Text('${date.month}-${date.day}-${date.year}',
                      style: const TextStyle(
                        fontSize: 22.0,
                      )),
                  onPressed: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: date,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          // This shows day of week alongside day of month
                          showDayOfWeek: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                          },
                        ),
                      )),
            ),
          ],
        ),
      ],
    );
  }
}
