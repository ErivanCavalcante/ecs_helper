// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecs_helper/components/EcsSpacerSmall.dart';
import 'package:flutter/material.dart';

class EcsSideMenuValue {
  final int currentPage;
  final List<MenuItem> items;

  EcsSideMenuValue({
    this.currentPage = -1,
    required this.items,
  });

  EcsSideMenuValue copyWith({int? currentPage, List<MenuItem>? items}) {
    return EcsSideMenuValue(
      currentPage: currentPage ?? this.currentPage,
      items: items ?? this.items,
    );
  }
}

class EcsSideMenuController extends ValueNotifier<EcsSideMenuValue> {
  EcsSideMenuController({required List<MenuItem> items})
      : super(EcsSideMenuValue(items: items));

  void changePage(int page) {
    if (value.items.isEmpty || page < 0 || page > value.items.length) return;

    value = value.copyWith(currentPage: page);
    notifyListeners();
  }

  void resetPage() {
    value = value.copyWith(currentPage: -1);
    notifyListeners();
  }
}

class MenuItem {
  String title;
  Icon icon;
  VoidCallback? onTap;

  MenuItem({
    required this.title,
    required this.icon,
    this.onTap,
  });
}

class EcsSideMenu extends StatefulWidget {
  EcsSideMenuController controller;
  Widget? header;
  Widget? footer;

  EcsSideMenu({
    Key? key,
    required this.controller,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  _EcsSideMenuState createState() => _EcsSideMenuState();
}

class _EcsSideMenuState extends State<EcsSideMenu> {
  late VoidCallback _listener;
  var isHover = false;
  var pageHovered = -1;

  _EcsSideMenuState() {
    _listener = () {
      if (mounted) {
        setState(() {});
      }
    };
  }

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(covariant EcsSideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(_listener);
    widget.controller.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      child: Container(
        color: colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.header != null) widget.header!,
            const Divider(),
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

    for (int i = 0; i < widget.controller.value.items.length; ++i) {
      var menu = widget.controller.value.items[i];

      items.add(
        InkWell(
          onHover: (value) {
            setState(() {
              pageHovered = i;
              isHover = value;
            });
          },
          onTap: () {
            if (widget.controller.value.currentPage == i) return;

            widget.controller.changePage(i);

            if (menu.onTap != null) menu.onTap!();
          },
          child: Stack(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(16),
                color: (_isSelected(i))
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : (_isHovered(i))
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
              if (_isSelected(i))
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

  bool _isSelected(int index) {
    return index == widget.controller.value.currentPage;
  }

  bool _isHovered(int index) {
    return index == pageHovered && isHover;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    widget.controller.dispose();
    super.dispose();
  }
}
