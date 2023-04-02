import 'dart:async';

import 'package:ecs_helper/components/EcsMessage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EcsEventToast extends StatefulWidget {
  Rx<EcsMessage> message;
  Widget child;

  EcsEventToast({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  @override
  _EcsEventToastState createState() => _EcsEventToastState();
}

class _EcsEventToastState extends State<EcsEventToast> {
  StreamSubscription? event;

  @override
  void initState() {
    super.initState();

    event = widget.message.listen((msg) {
      if (mounted && !msg.hasExecuted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              msg.message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );

        msg.hasExecuted = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    event?.cancel();
    super.dispose();
  }
}
