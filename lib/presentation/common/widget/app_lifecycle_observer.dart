import 'package:flutter/material.dart';

class AppLifecycleObserver with WidgetsBindingObserver {
  late final Function() onClose;

  void initialize(Function() onClose) {
    this.onClose = onClose;
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onClose();
    }
  }
}
