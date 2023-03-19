// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecs_helper/components/EcsSpacerSmall.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EcsUrlMenuItem {
  String basePath;
  String title;
  Icon icon;
  VoidCallback? onTap;

  EcsUrlMenuItem({
    required this.basePath,
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class EcsUrlSideMenu extends StatefulWidget {
  List<EcsUrlMenuItem> items;
  Widget? header;
  Widget? footer;
  bool useDivider;

  EcsUrlSideMenu({
    Key? key,
    required this.items,
    this.header,
    this.footer,
    this.useDivider = false,
  }) : super(key: key);

  @override
  _EcsUrlSideMenuState createState() => _EcsUrlSideMenuState();
}

class _EcsUrlSideMenuState extends State<EcsUrlSideMenu> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      child: NavigationListener(builder: (context, child) {
        return SizedBox(
          width: 300,
          child: Container(
            color: colorScheme.surface,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.header != null) widget.header!,
                if (widget.useDivider) const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _getSideItems(),
                    ),
                  ),
                ),
                _getFooter(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _getFooter() {
    if (widget.footer != null) return widget.footer!;

    return Text(
      'Copyright 2022',
      style: Theme.of(context).textTheme.bodyMedium,
      textAlign: TextAlign.center,
    );
  }

  List<Widget> _getSideItems() {
    var items = <Widget>[];
    var path = Modular.to.path;

    for (int i = 0; i < widget.items.length; ++i) {
      var menu = widget.items[i];

      items.add(
        InkWell(
          onTap: menu.onTap,
          child: Stack(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(16),
                color: (_isSelected(menu, path))
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : const Color.fromARGB(0, 255, 255, 255),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        menu.icon,
                        EcsSpacerSmall.horizontal(),
                        Text(
                          menu.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (_isSelected(menu, path))
                SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 4,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Container(
                      color: Theme.of(context).colorScheme.primary,
                      width: 5,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return items;
  }

  bool _isSelected(EcsUrlMenuItem item, String path) {
    return path.startsWith(item.basePath);
  }
}
