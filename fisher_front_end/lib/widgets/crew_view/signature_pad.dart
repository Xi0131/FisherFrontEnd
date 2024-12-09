import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class SignaturePad extends StatefulWidget {
  final ValueChanged<ui.Image> onSignComplete;

  const SignaturePad({super.key, required this.onSignComplete});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];
  Size? _canvasSize;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('簽名'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('確認'),
          onPressed: _strokes.isNotEmpty ? () async {
            try {
              // 預留處理簽名圖片的邏輯空間
              print('生成簽名圖片，未來可在此處理圖片轉換或儲存邏輯');

              // 返回上一頁
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              } else {
                print('沒有頁面可以返回');
              }
            } catch (e) {
              print('按下確認鍵時發生錯誤: $e');
            }
          } : null, // 若無簽名內容，按鈕禁用
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('取消'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              print('沒有頁面可以返回');
            }
          },
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            _canvasSize = Size(constraints.maxWidth, constraints.maxHeight);
            return Stack(
              children: [
                GestureDetector(
                  onPanDown: (DragDownDetails details) {
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final Offset localPosition = box.globalToLocal(details.globalPosition);
                    setState(() {
                      _currentStroke = [localPosition];
                    });
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final Offset localPosition = box.globalToLocal(details.globalPosition);
                    setState(() {
                      _currentStroke.add(localPosition);
                    });
                  },
                  onPanEnd: (DragEndDetails details) {
                    setState(() {
                      if (_currentStroke.isNotEmpty) {
                        _strokes.add(List.from(_currentStroke));
                        _currentStroke.clear();
                      }
                    });
                  },
                  child: CustomPaint(
                    painter: SignaturePainter(
                      strokes: _strokes,
                      currentStroke: _currentStroke,
                    ),
                    size: Size.infinite,
                  ),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    color: CupertinoColors.white.withOpacity(0.7),
                    child: CupertinoButton(
                      color: CupertinoColors.systemGrey4,
                      child: const Text('清除'),
                      onPressed: () {
                        setState(() {
                          _strokes.clear();
                          _currentStroke.clear();
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<ui.Image> _renderSignatureToImage() async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final signaturePainter = SignaturePainter(
      strokes: _strokes,
      currentStroke: _currentStroke,
    );

    final size = _canvasSize ?? const Size(400, 400);
    signaturePainter.paint(canvas, size);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    return img;
  }
}

class SignaturePainter extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Offset> currentStroke;

  SignaturePainter({
    required this.strokes,
    required this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CupertinoColors.black
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // 繪製已完成的筆畫
    for (var stroke in strokes) {
      if (stroke.length > 1) {
        for (int i = 0; i < stroke.length - 1; i++) {
          canvas.drawLine(stroke[i], stroke[i + 1], paint);
        }
      }
    }

    // 繪製當前正在繪製的筆畫
    if (currentStroke.length > 1) {
      for (int i = 0; i < currentStroke.length - 1; i++) {
        canvas.drawLine(currentStroke[i], currentStroke[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
