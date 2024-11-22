import 'package:fisher_front_end/views/captain_page.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'captainPage':
      return CupertinoPageRoute(builder: (context) => const CaptainPage());
    default:
      return CupertinoPageRoute(
          builder: (context) => const CaptainPage()); // Default fallback
  }
}
