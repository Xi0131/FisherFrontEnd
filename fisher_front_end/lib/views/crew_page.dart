import 'package:fisher_front_end/widgets/crew_view/crew_calendar.dart';
import 'package:fisher_front_end/widgets/crew_view/crew_id_card.dart';
import 'package:flutter/material.dart';

class CrewWidget extends StatelessWidget {
  const CrewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.grey[200],
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 左側：船員資訊
            Expanded(
              flex: 1,
              child: CrewIdCard(),
            ),
            VerticalDivider(width: 1, color: Colors.black54),
            // 右側：月曆
            Expanded(
              flex: 3,
              child: CrewCalendar(),
            ),
          ],
        ),
      ),
    );
  }
}
