import 'package:fisher_front_end/views/captain_page.dart';
import 'package:fisher_front_end/widgets/ct_nav_list.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'captainPage':
      return CupertinoPageRoute(builder: (context) => const CaptainPage());
    case 'ctNavList':
      return CupertinoPageRoute(builder: (context) => const CTNavList());
    default:
      return CupertinoPageRoute(
          builder: (context) => const CaptainPage()); // Default fallback
  }
}
