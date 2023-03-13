import 'package:flutter/material.dart';

enum EcsBlockButtonType {
  filled,
  icon,
  outlined,
  text,
}

class EcsBlockButton extends StatelessWidget {
  double height;
  Color? color;
  double elevation;
  Widget? icon;
  double? iconSize;
  Widget? child;
  VoidCallback? onPressed;
  EcsBlockButtonType type;

  EcsBlockButton.filled({
    Key? key,
    this.height = 30,
    this.color,
    required this.child,
    this.elevation = 4.0,
    this.onPressed,
    this.icon,
  })  : type = EcsBlockButtonType.filled,
        super(key: key);

  EcsBlockButton.icon({
    Key? key,
    this.height = 30,
    this.color,
    this.elevation = 4.0,
    this.onPressed,
    required this.icon,
    this.iconSize,
  })  : type = EcsBlockButtonType.icon,
        super(key: key);

  EcsBlockButton.outlined({
    Key? key,
    this.height = 30,
    this.color,
    required this.child,
    this.elevation = 4.0,
    this.onPressed,
    this.icon,
  })  : type = EcsBlockButtonType.outlined,
        super(key: key);

  EcsBlockButton.text({
    Key? key,
    this.height = 30,
    required this.child,
    this.elevation = 4.0,
    this.onPressed,
    this.icon,
  })  : type = EcsBlockButtonType.text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: getButton(),
    );
  }

  Widget getButton() {
    switch (type) {
      case EcsBlockButtonType.filled:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            elevation: elevation,
          ),
          onPressed: onPressed,
          child: child,
        );
      case EcsBlockButtonType.text:
        return TextButton(
          style: TextButton.styleFrom(
            backgroundColor: color,
            elevation: elevation,
          ),
          onPressed: onPressed,
          child: child!,
        );
      case EcsBlockButtonType.outlined:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: color,
            elevation: elevation,
          ),
          onPressed: onPressed,
          child: child,
        );
      case EcsBlockButtonType.icon:
        return IconButton(
          icon: icon!,
          iconSize: iconSize,
          style: IconButton.styleFrom(
            backgroundColor: color,
            elevation: elevation,
          ),
          onPressed: onPressed,
        );
    }
  }
}
