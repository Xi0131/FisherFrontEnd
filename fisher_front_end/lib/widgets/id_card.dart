import 'package:flutter/cupertino.dart';

class IdCard extends StatefulWidget {
  final Image workerImage;
  final String workerName;
  final String workerType;
  final bool isRecorded;
  const IdCard(
      {super.key,
      required this.workerImage,
      required this.workerName,
      required this.workerType,
      required this.isRecorded});

  @override
  State<IdCard> createState() => _IdCardState();
}

class _IdCardState extends State<IdCard> {
  bool _isHighlighted = false;
  Image _workerHeadImage = Image.asset('default.png');
  late String _workerName;
  late String _workerType;
  late bool _isRecorded;

  @override
  void initState() {
    _workerHeadImage = widget.workerImage;
    _workerName = widget.workerName;
    _workerType = widget.workerType;
    _isRecorded = widget.isRecorded;
    super.initState();
  }

  void _toggleHighlight() {
    setState(() {
      _isHighlighted = !_isHighlighted; // Toggle highlight state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: _isHighlighted
                ? CupertinoColors.activeBlue // Highlight color
                : CupertinoColors.systemGrey4, // Default border color
            width: 2.0,
          ),
        ),
        child: CupertinoButton(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          onPressed: _toggleHighlight,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 80,
                child: _workerHeadImage,
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 80,
                    child: Text(
                      _workerName,
                      softWrap: false,
                      style: const TextStyle(fontSize: 15),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      _workerType,
                      style: const TextStyle(fontSize: 10),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
