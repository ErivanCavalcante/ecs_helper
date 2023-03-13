import 'package:flutter/material.dart';

class EcsSpacerSmall extends StatelessWidget {
  late bool isVertical;

  EcsSpacerSmall.vertical({Key? key}) : super(key: key) {
    isVertical = true;
  }

  EcsSpacerSmall.horizontal({Key? key}) : super(key: key) {
    isVertical = false;
  }

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? const SizedBox(
            height: 8,
          )
        : const SizedBox(
            width: 8,
          );
  }
}
