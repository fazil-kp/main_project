import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens/student/student_screen.dart';
import '../view_model/riverpod.dart';
import 'app_bar.dart';

class CustomScaffold extends ConsumerWidget {
  final Widget? childWidget;
  final String? enums;
  final bool? hideScaffold;
  const CustomScaffold({super.key, this.childWidget, this.enums, this.hideScaffold = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return hideScaffold == false
        ? Scaffold(
            backgroundColor: ref.watch(studentVM).isLightTheme ? white : const Color(0xff131313),
            body: Column(
              children: [
                CustomAppBar(enums: enums, childWidget: childWidget),
                Expanded(child: childWidget ?? const StudentScreen()),
              ],
            ),
          )
        : Scaffold(body: childWidget);
  }
}
