import 'package:ecs_helper/components/EcsSpacer.dart';
import 'package:flutter/material.dart';

class EcsLoadingBarrier extends StatelessWidget {
  final String description;

  const EcsLoadingBarrier({Key? key, this.description = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ModalBarrier(
          dismissible: false,
          color: Color.fromARGB(100, 255, 255, 255),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const EcsSpacer.vertical(
                size: SpacerSize.sm,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.black54,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
