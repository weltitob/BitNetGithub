import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// class CustomPageViewScrollPhysics extends ScrollPhysics {
//   const CustomPageViewScrollPhysics({ScrollPhysics? parent})
//       : super(parent: parent);
//
//   @override
//   CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
//   }
//
//   @override
//   SpringDescription get spring => const SpringDescription(
//     mass: 50,
//     stiffness: 100,
//     damping: 0.8,
//   );
// }


class StrongMouseScrollPhysics extends ScrollPhysics {
  final double scrollSensitivity;

  StrongMouseScrollPhysics({ScrollPhysics? parent, this.scrollSensitivity = 2.0})
      : super(parent: parent);

  @override
  StrongMouseScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return StrongMouseScrollPhysics(
        parent: buildParent(ancestor), scrollSensitivity: scrollSensitivity);
  }

  double _appliedScrollSensitivity(double velocity) {
    return velocity * scrollSensitivity;
  }

  @override
  double applyPhysicsToUserOffset(
      ScrollMetrics position, double offset) {
    return super.applyPhysicsToUserOffset(position, _appliedScrollSensitivity(offset));
  }
}

class FastScrollPhysics extends ScrollPhysics {
  const FastScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  FastScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return FastScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if ((velocity.abs() < tolerance.velocity) &&
        (position.pixels - position.minScrollExtent).abs() <
            tolerance.distance) {
      return null;
    }
    if (velocity.abs() < tolerance.velocity ||
        (position.outOfRange && velocity == 0)) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        position.minScrollExtent,
        velocity,
        tolerance: tolerance,
      );
    }

    // Adjusted parameters for a faster scroll effect
    return BouncingScrollSimulation(
      position: position.pixels,
      velocity: velocity * 10.0, // Increase the velocity for faster scrolling
      leadingExtent: position.minScrollExtent,
      trailingExtent: position.maxScrollExtent,
      spring: SpringDescription.withDampingRatio(
        mass: 0.2, // Decreased mass for faster acceleration
        stiffness: 20, // Stiffness of the spring
        ratio: 2.0, // Damping ratio, adjusting for how spring-like the simulation is
      ),
      tolerance: tolerance,
    );
  }
}
