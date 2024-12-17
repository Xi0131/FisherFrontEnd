import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CrewInfo extends StatefulWidget {
  final int workerId;
  const CrewInfo({super.key, required this.workerId});

  @override
  State<CrewInfo> createState() => _CrewInfoState();
}

class _CrewInfoState extends State<CrewInfo> {
  Map<String, dynamic>? _workerInfo;

  @override
  void initState() {
    super.initState();
    _loadWorkerInfo();
  }

  Future<void> _loadWorkerInfo() async {
    try {
      final worker = await _getWorkerInfo(widget.workerId);
      if (worker.isNotEmpty) {
        setState(() {
          _workerInfo = worker;
        });
      } else {
        setState(() {
          _workerInfo = {};
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _workerInfo = {};
      });
    }
  }

  Future<Map<String, dynamic>> _getWorkerInfo(int workerId) async {
    // 將 :worker_id 替換成實際的 workerId
    final url = Uri.parse('http://35.229.208.250:3000/api/workerEdit/$workerId');

    print('Request URL: $url'); // 輸出請求的 URL 進行確認
    final response = await http.get(url);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // 確保 API 返回的是單一物件
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load worker info');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_workerInfo == null) {
      return const Center(child: CupertinoActivityIndicator());
    }

    return Container(
      color: CupertinoColors.systemGrey5,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: CupertinoColors.activeBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                CupertinoIcons.person_solid,
                size: 60,
                color: CupertinoColors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _workerInfo?['name'] ?? '未知姓名',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '編號: ${_workerInfo?['worker_id'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              '國籍: ${_workerInfo?['country'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              '護照號碼: ${_workerInfo?['passport_number'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 6),
            Text(
              '工種: ${_workerInfo?['job_title'] ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
