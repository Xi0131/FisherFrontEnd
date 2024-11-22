import 'package:flutter/cupertino.dart';

class IdCard extends StatefulWidget {
  const IdCard({super.key});

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  bool _isHighlighted = false;

  void _toggleHighlight() {
    setState(() {
      _isHighlighted = !_isHighlighted; // Toggle highlight state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: _isHighlighted
              ? CupertinoColors.activeBlue // Highlight color
              : CupertinoColors.systemGrey6, // Default border color
          width: 2.0,
        ),
      ),
      child: CupertinoButton(
        child: Text('click me'),
        onPressed: _toggleHighlight,
      ),
    );
  }
}
