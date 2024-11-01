import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project/helper/constants.dart';

import '../common_widgets/scaffold.dart';
import 'web_route_list.dart';
import 'mobile_route_list.dart';

final GoRouter coreRoute = GoRouter(
  initialLocation: "/",
  redirectLimit: 3,
  errorBuilder: (context, state) {
    return CustomScaffold(
      childWidget: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const NoDataFound(message: "Page Not Found"),
            ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text("Back"),
            ),
          ],
        ),
      ),
    );
  },
  navigatorKey: Const.navigatorKey,
  routes: _buildRoutes(),
);

List<RouteBase> _buildRoutes() {
  return [
    GoRoute(
      path: '/',
      parentNavigatorKey: Const.navigatorKey,
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
        },
        child: const CustomScaffold(),

        // FutureBuilder(
        //   future: login(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState != ConnectionState.done) {
        //       return const Splash();
        //     } else if (snapshot.hasError) {
        //       return const SizedBox(
        //         child: Text("Error"),
        //       );
        //     } else {
        //       if (snapshot.data == true) {
        //         return const CustomScaffold();
        //       } else {
        //         return const LoginScreen();
        //       }
        //     }
        //   },
        // ),
      ),
      routes: [..._mainRoutes(), ..._mobileRoutes()],
    ),
  ];
}

Future<bool> login() async {
  return true;
}

List<GoRoute> _mainRoutes() {
  List<GoRoute> mainGoRoutes = [];

  for (var mainCoreRoute in mainRouteList) {
    mainGoRoutes.add(
      GoRoute(
        path: mainCoreRoute.routeName!,
        name: mainCoreRoute.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
          key: state.pageKey,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: CurveTween(curve: Curves.easeInOutSine).animate(animation), child: child);
          },
          child: mainCoreRoute.widget!,
        ),
      ),
    );
  }

  return mainGoRoutes;
}

List<GoRoute> _mobileRoutes() {
  List<GoRoute> mobMainGoRoutes = [];

  for (var mobRoute in mobileRouteList) {
    mobMainGoRoutes.add(
      GoRoute(
        path: mobRoute.routeName!,
        name: mobRoute.routeName,
        pageBuilder: (BuildContext context, GoRouterState state) => CustomTransitionPage(
          key: state.pageKey,
          reverseTransitionDuration: const Duration(microseconds: 400),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation), child: child);
          },
          child: mobRoute.widget!,
        ),
      ),
    );
  }

  return mobMainGoRoutes;
}
