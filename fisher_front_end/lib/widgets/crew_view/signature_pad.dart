import 'package:fisher_front_end/widgets/crew_view/signature_painter.dart';
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
          onPressed: _strokes.isNotEmpty
              ? () async {
                  try {
                    // 預留處理簽名圖片的邏輯空間
                    debugPrint('生成簽名圖片，未來可在此處理圖片轉換或儲存邏輯');
                    _renderSignatureToImage();
                    // 返回上一頁
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      debugPrint('沒有頁面可以返回');
                    }
                  } catch (e) {
                    debugPrint('按下確認鍵時發生錯誤: $e');
                  }
                }
              : null,
          child: const Text('確認'), // 若無簽名內容，按鈕禁用
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('取消'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              debugPrint('沒有頁面可以返回');
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
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    final Offset localPosition =
                        box.globalToLocal(details.globalPosition);
                    setState(() {
                      _currentStroke = [localPosition];
                    });
                  },
                  onPanUpdate: (DragUpdateDetails details) {
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    final Offset localPosition =
                        box.globalToLocal(details.globalPosition);
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
