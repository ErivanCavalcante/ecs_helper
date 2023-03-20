// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecs_helper/components/EcsSpacerMedium.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EcsUrlSideMenuValue {
  final double width;
  final bool isColapsed;

  EcsUrlSideMenuValue({
    required this.width,
    required this.isColapsed,
  });

  EcsUrlSideMenuValue copyWith({
    double? width,
    bool? isColapsed,
  }) {
    return EcsUrlSideMenuValue(
      width: width ?? this.width,
      isColapsed: isColapsed ?? this.isColapsed,
    );
  }
}

class EcsUrlSideMenuController extends ValueNotifier<EcsUrlSideMenuValue> {
  EcsUrlSideMenuController()
      : super(EcsUrlSideMenuValue(width: 256, isColapsed: false));

  void colapse() {
    final isColapsed = !value.isColapsed;

    final width = isColapsed ? 76.0 : 256.0;

    value = value.copyWith(width: width, isColapsed: isColapsed);
    notifyListeners();
  }
}

class EcsUrlMenuItem {
  String basePath;
  String title;
  IconData icon;
  VoidCallback? onTap;

  EcsUrlMenuItem({
    required this.basePath,
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class EcsUrlSideMenu extends StatefulWidget {
  Widget logo;
  Map<String, List<EcsUrlMenuItem>> items;
  Widget? footer;
  EcsUrlSideMenuController controller;

  EcsUrlSideMenu({
    Key? key,
    required this.logo,
    required this.items,
    this.footer,
    required this.controller,
  }) : super(key: key);

  @override
  _EcsUrlSideMenuState createState() => _EcsUrlSideMenuState();
}

class _EcsUrlSideMenuState extends State<EcsUrlSideMenu> {
  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(covariant EcsUrlSideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(_listener);
    widget.controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      elevation: 0,
      child: NavigationListener(builder: (context, child) {
        return AnimatedContainer(
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.2),
            border: const Border(
              right: BorderSide(),
            ),
          ),
          width: widget.controller.value.width,
          duration: const Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 68,
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(),
                    bottom: BorderSide(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: widget.logo,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _getSideItems(),
                    ),
                  ),
                ),
              ),
              if (widget.footer != null) widget.footer!,
            ],
          ),
        );
      }),
    );
  }

  List<Widget> _getSideItems() {
    final theme = Theme.of(context);

    var items = <Widget>[];
    var path = Modular.to.path;

    for (var key in widget.items.keys) {
      // Adiciona o title dos itens
      items.add(Text(
        key,
        style: theme.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ));

      for (var menu in widget.items[key]!) {
        items.add(
          InkWell(
            onTap: menu.onTap,
            child: (_isSelected(menu, path))
                ? Container(
                    color: Colors.white,
                    height: 50,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          menu.icon,
                          color: theme.colorScheme.primary,
                          size: 16,
                        ),
                        EcsSpacerMedium.horizontal(),
                        Text(
                          menu.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  )
                : Container(
                    height: 50,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Icon(
                          menu.icon,
                          size: 16,
                        ),
                        EcsSpacerMedium.horizontal(),
                        Text(
                          menu.title,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      }

      // Separador entre os menus
      items.add(EcsSpacerMedium.vertical());
      items.add(const Divider());
      items.add(EcsSpacerMedium.vertical());
    }

    return items;
  }

  bool _isSelected(EcsUrlMenuItem item, String path) {
    return path.startsWith(item.basePath);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    widget.controller.dispose();
    super.dispose();
  }
}
