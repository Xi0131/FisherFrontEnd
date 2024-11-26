import 'package:fisher_front_end/views/captain_page.dart';
import 'package:fisher_front_end/views/crew_page.dart';
import 'package:fisher_front_end/views/login_page.dart';
import 'package:fisher_front_end/views/worker_management_page.dart';
import 'package:fisher_front_end/widgets/navigation_bar/ct_nav_list.dart';
import 'package:flutter/cupertino.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'captainPage':
      return CupertinoPageRoute(builder: (context) => const CaptainPage());
    case 'ctNavList':
      return CupertinoPageRoute(builder: (context) => const CTNavList());
    case 'loginPage':
      return CupertinoPageRoute(builder: (context) => const LoginPage());
    case 'workerManagementPage':
      return CupertinoPageRoute(
          builder: (context) => const WorkerManagementPage());
    case 'crewWidget':
      return CupertinoPageRoute(builder: (context) => const CrewWidget());
    default:
      return CupertinoPageRoute(
          builder: (context) => const CaptainPage()); // Default fallback
  }
}
