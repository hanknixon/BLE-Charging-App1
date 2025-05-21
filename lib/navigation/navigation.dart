
import 'package:flutter/material.dart';

import 'navbars.dart';
import '../utils/ui.dart';
import '../screen_views/welcome_v.dart';


final backBtnVisible = ValueNotifier<bool>(false); 

class NavigatorMain {
  static NavStack<NavStackRecord> navStack = NavStack();

  static Navigator navigator() {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => WelcomeV());
      },
    );
  }

  static reset() {
    NavigatorMain.navStack.clear();
    TopNavBar.poppingWidget = null;
    TopNavBar.poppingWidgetContext = null;
    TopNavBar.shouldNavigateBack = true;

    Future.delayed(const Duration(milliseconds: MCUI.backBtnDisplayDelayMilSec))
        .then((val) {
      backBtnVisible.value = false;
    });
  }
}

abstract class PopTargetWidget {
  void pepare(BuildContext context);
}

abstract class PoppingWidget {
  void pepareToPop(BuildContext context) async { }
}

class NavStackRecord {
  Widget backWidget;
  BuildContext backContext;

  NavStackRecord(this.backWidget, this.backContext);
}

class NavStack<T> {
  final _list = <T>[];

  void push(T value) => _list.add(value);
  T pop() => _list.removeLast();
  void clear() => _list.clear();
  T get peek => _list.last;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

