import 'package:flutter/material.dart';

class EcsSideMenuController {}

class EcsSideMenu extends StatefulWidget {
  EcsSideMenuController controller;

  EcsSideMenu({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _EcsSideMenuState createState() => _EcsSideMenuState();
}

class _EcsSideMenuState extends State<EcsSideMenu> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(),
    );
  }
}
