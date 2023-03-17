import 'package:flutter/material.dart';

class EcsSpacerLarge extends StatelessWidget {
  late bool isVertical;

  EcsSpacerLarge.vertical({Key? key}) : super(key: key) {
    isVertical = true;
  }

  EcsSpacerLarge.horizontal({Key? key}) : super(key: key) {
    isVertical = false;
  }

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? const SizedBox(
            height: 32,
          )
        : const SizedBox(
            width: 32,
          );
  }
}
