import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class SignaturePad extends StatefulWidget {
  final ValueChanged<ui.Image> onSignComplete;

  const SignaturePad({Key? key, required this.onSignComplete}) : super(key: key);

  @override
  _SignaturePadState createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  List<Offset?> _points = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('簽名'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('確認'),
          onPressed: () async {
            ui.Image image = await _renderSignatureToImage();
            widget.onSignComplete(image);
            Navigator.pop(context);
          },
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('取消'),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {
                RenderBox box = context.findRenderObject() as RenderBox;
                Offset point = box.globalToLocal(details.globalPosition);
                setState(() {
                  _points = List.from(_points)..add(point);
                });
              },
              onPanEnd: (DragEndDetails details) {
                setState(() {
                  _points.add(null); // 使用 null 來分隔不同的筆畫
                });
              },
              child: CustomPaint(
                painter: SignaturePainter(_points),
                size: Size.infinite,
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: CupertinoButton(
                color: CupertinoColors.systemGrey4,
                child: const Text('清除'),
                onPressed: () {
                  setState(() {
                    _points.clear();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image> _renderSignatureToImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final signaturePainter = SignaturePainter(_points);
    signaturePainter.paint(canvas, Size(400, 400));

    final picture = recorder.endRecording();
    final img = await picture.toImage(400, 400);
    return img;
  }
}

class SignaturePainter extends CustomPainter {
  final List<Offset?> points;

  SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CupertinoColors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => oldDelegate.points != points;
}
