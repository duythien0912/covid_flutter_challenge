import 'package:ezanimation/ezanimation.dart';
import 'package:flutter/material.dart';

class AnimatedEntranceWidget extends StatelessWidget {
  AnimatedEntranceWidget({this.child, this.offsetStart, this.offsetEnd});

  final Widget child;
  final double offsetEnd;
  final double offsetStart;

  @override
  Widget build(BuildContext context) {
    EzAnimation animation;
    if (animation == null) {
      animation = EzAnimation(
        0.0,
        1.0,
        Duration(milliseconds: 300),
        context: context,
        curve: Curves.ease,
      );

      animation.start();
    }
    return AnimatedBuilder(
      animation: animation,
      builder: (_, __) => Opacity(
        opacity: animation.value,
        child: Transform(
          transform: Matrix4.identity()
            ..scale(animation.value)
            ..rotateZ(offsetStart - offsetStart * animation.value)
            ..rotateY(offsetEnd - offsetEnd * animation.value),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }
}
