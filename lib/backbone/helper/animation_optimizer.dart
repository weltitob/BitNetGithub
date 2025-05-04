import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A class to optimize animations and reduce lag in the BitNet app,
/// especially for web platform.
class AnimationOptimizer {
  static final AnimationOptimizer _instance = AnimationOptimizer._internal();

  factory AnimationOptimizer() => _instance;

  AnimationOptimizer._internal();

  /// Whether animations should be disabled based on device performance
  bool _shouldDisableAnimations = false;

  /// Whether reduced motion is preferred by the user
  bool _prefersReducedMotion = false;

  /// Initialize the animation optimizer
  void initialize(BuildContext context) {
    _checkDevicePerformance();
    _checkAccessibilityPreferences(context);
  }

  /// Check if device performance suggests disabling animations
  void _checkDevicePerformance() {
    if (kIsWeb) {
      // For web, check if the device seems to be low-end
      // by monitoring frame timings
      // Use a timer to measure frame duration instead of firstFrameTimeStamp
      Stopwatch frameTimer = Stopwatch()..start();
      SchedulerBinding.instance.addPostFrameCallback((_) {
        final frameDuration = frameTimer.elapsedMilliseconds;
        frameTimer.stop();

        if (frameDuration > 100) {
          // If first frame took more than 100ms
          _shouldDisableAnimations = true;
        }
      });
    }
  }

  /// Check if user prefers reduced motion
  void _checkAccessibilityPreferences(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    _prefersReducedMotion =
        mediaQuery.disableAnimations || mediaQuery.accessibleNavigation;
  }

  /// Should complex animations be disabled?
  bool get shouldDisableComplexAnimations =>
      _shouldDisableAnimations || _prefersReducedMotion || kIsWeb;

  /// Should all animations be disabled?
  bool get shouldDisableAllAnimations => _prefersReducedMotion;

  /// Get optimized animation duration
  Duration getOptimizedDuration(Duration original) {
    if (shouldDisableAllAnimations) {
      return Duration.zero;
    }

    if (shouldDisableComplexAnimations) {
      // Reduce animation duration on web for better performance
      return Duration(milliseconds: (original.inMilliseconds * 0.6).round());
    }

    return original;
  }

  /// Get optimized curve
  Curve getOptimizedCurve(Curve original) {
    if (shouldDisableComplexAnimations) {
      // Use simpler curves for better performance
      return Curves.linear;
    }

    return original;
  }
}

/// Extension on Animation for performance optimization
extension AnimationPerformanceOptimizer<T> on Animation<T> {
  /// Returns a new animation that's optimized for performance when needed
  Animation<T> optimized() {
    final optimizer = AnimationOptimizer();

    if (optimizer.shouldDisableAllAnimations) {
      // Return a zero-duration animation
      return this;
    }

    if (optimizer.shouldDisableComplexAnimations && this is CurvedAnimation) {
      // Convert to a simpler animation when needed
      final curved = this as CurvedAnimation;
      return CurvedAnimation(
        parent: curved.parent,
        curve: optimizer.getOptimizedCurve(curved.curve),
      ) as Animation<T>;
    }

    return this;
  }
}
