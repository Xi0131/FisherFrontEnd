import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // 新增這行
import 'signature_painter.dart';

class SignaturePad extends StatefulWidget {
  final String date;
  final int workerId;
  const SignaturePad({
    super.key,
    required this.date,
    required this.workerId,
  });

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<List<Offset>> _strokes = [];
  List<Offset> _currentStroke = [];
  Size? _canvasSize;
  bool _isSubmitting = false;

  Future<void> _signToCheck(int workerId, String date, ui.Image signatureImage) async {
    final pngBytes = await _imageToPngBytes(signatureImage);

    final uri = Uri.parse('http://35.229.208.250:3000/api/workerPage/oemo');
    final request = http.MultipartRequest('POST', uri)
      ..fields['worker_id'] = workerId.toString()
      ..fields['date'] = date
      ..files.add(
        http.MultipartFile.fromBytes(
          'signature',
          pngBytes,
          filename: 'signature.png',
          contentType: MediaType('image', 'png'),
        ),
      );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 200) {
      throw Exception('Failed to sign to check');
    }
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

  Future<List<int>> _imageToPngBytes(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('簽名'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _strokes.isNotEmpty && !_isSubmitting
              ? () async {
            setState(() {
              _isSubmitting = true;
            });
            try {
              final img = await _renderSignatureToImage();
              await _signToCheck(widget.workerId, widget.date, img);
              setState(() {
                _isSubmitting = false;
              });
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('簽名已保存'),
                  content: const Text('您的簽名已成功上傳。'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('確定'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            } catch (e) {
              setState(() {
                _isSubmitting = false;
              });
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('錯誤'),
                  content: Text('上傳簽名時發生錯誤：$e'),
                  actions: [
                    CupertinoDialogAction(
                      child: const Text('確定'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            }
          }
              : null,
          child: _isSubmitting ? const CupertinoActivityIndicator() : const Text('確認'),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('取消'),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
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
}
