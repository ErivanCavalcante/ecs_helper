import 'package:flutter/material.dart';

enum SpacerSize {
  sm,
  md,
  lg,
}

class EcsSpacer extends StatelessWidget {
  final bool isVertical;
  final SpacerSize size;

  const EcsSpacer.vertical({
    Key? key,
    this.isVertical = true,
    required this.size,
  }) : super(key: key);

  const EcsSpacer.horizontal({
    Key? key,
    this.isVertical = true,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? SizedBox(
            height: _getSize(),
          )
        : SizedBox(
            width: _getSize(),
          );
  }

  double _getSize() {
    return switch (size) {
      SpacerSize.sm => 8,
      SpacerSize.md => 16,
      SpacerSize.lg => 32,
    };
  }
}
