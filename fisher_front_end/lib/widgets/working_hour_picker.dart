import 'package:flutter/cupertino.dart';

class WorkingHourPicker extends StatefulWidget {
  final int workingTimeSelected12;
  final int workingTimeSelected24;
  final Function(int) onUpdate12;
  final Function(int) onUpdate24;
  const WorkingHourPicker({
    super.key,
    required this.workingTimeSelected12,
    required this.workingTimeSelected24,
    required this.onUpdate12,
    required this.onUpdate24,
  });

  @override
  State<WorkingHourPicker> createState() => _WorkingHourPickerState();
}

class _WorkingHourPickerState extends State<WorkingHourPicker> {
  int _workingTimeSelected12 = 0;
  int _workingTimeSelected24 = 0;

  @override
  void initState() {
    _workingTimeSelected12 = widget.workingTimeSelected12;
    _workingTimeSelected24 = widget.workingTimeSelected24;
    super.initState();
  }

  void _toggleTime12(int index) {
    setState(() {
      _workingTimeSelected12 = _workingTimeSelected12 ^ (2 << index);
      widget.onUpdate12(_workingTimeSelected12);
    });
  }

  void _toggleTime24(int index) {
    setState(() {
      _workingTimeSelected24 = _workingTimeSelected24 ^ (2 << index);
      widget.onUpdate12(_workingTimeSelected24);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              12,
              (index) {
                return const Row(
                  children: [
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Text('1'),
                    ),
                    SizedBox(
                      height: 25,
                      width: 25,
                    ),
                  ],
                );
              },
            )),
        const SizedBox(height: 10),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              24,
              (index) {
                return Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: _workingTimeSelected12 & (2 << index) != 0
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: _workingTimeSelected12 & (2 << index) != 0
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.systemGrey4, // Default border color
                      width: 2.0,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => _toggleTime12(index),
                    child: const SizedBox(),
                  ),
                );
              },
            )),
        const SizedBox(height: 10),
        Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              24,
              (index) {
                return Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: _workingTimeSelected24 & (2 << index) != 0
                        ? CupertinoColors.activeBlue
                        : CupertinoColors.systemGrey4,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: _workingTimeSelected24 & (2 << index) != 0
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.systemGrey4, // Default border color
                      width: 2.0,
                    ),
                  ),
                  child: CupertinoButton(
                    onPressed: () => _toggleTime24(index),
                    child: const SizedBox(),
                  ),
                );
              },
            )),
      ],
    );
  }
}
