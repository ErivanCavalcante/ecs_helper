import 'package:flutter/material.dart';

class EcsSpacerMedium extends StatelessWidget {
  late bool isVertical;

  EcsSpacerMedium.vertical({Key? key}) : super(key: key) {
    isVertical = true;
  }

  EcsSpacerMedium.horizontal({Key? key}) : super(key: key) {
    isVertical = false;
  }

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? const SizedBox(
            height: 16,
          )
        : const SizedBox(
            width: 16,
          );
  }
}
