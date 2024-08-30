import 'dart:math';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/models/animatedmodels/animatedavatar.dart';
import 'package:bitnet/pages/website/widgets/webavatar.dart';
import 'package:flutter/material.dart';

class RandomAvatarWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool start;

  const RandomAvatarWidget(
      {required this.width, required this.height, this.start = false});

  @override
  _RandomAvatarWidgetState createState() => _RandomAvatarWidgetState();
}

class _RandomAvatarWidgetState extends State<RandomAvatarWidget>
    with TickerProviderStateMixin {
  List<AnimatedAvatar> animatedAvatars = [];
  Random random = Random();

  bool isTooCloseToOthers(Offset newPos, double endRadius) {
    for (var avatar in animatedAvatars) {
      double distance = (newPos - avatar.position).distance;
      if (distance < 2 * endRadius) {
        return true;
      }
    }
    return false;
  }

  bool isInsideRedContainer(Offset pos, double endRadius) {
    double leftBoundary = endRadius + AppTheme.cardPadding * 4;
    double rightBoundary = widget.width - leftBoundary;
    double topBoundary = endRadius * 1;
    double bottomBoundary = widget.height - topBoundary;

    return pos.dx > leftBoundary &&
        pos.dx < rightBoundary &&
        pos.dy > topBoundary &&
        pos.dy < bottomBoundary;
  }

  Offset generateRandomPosition(double endRadius) {
    double xPos, yPos;
    Offset newPos;

    // Define the range within which the avatars can spawn.
    double minX = endRadius / 2;
    double maxX = widget.width - endRadius / 2;
    double minY = endRadius / 2;
    double maxY = widget.height - endRadius / 2;

    do {
      xPos = minX + random.nextDouble() * (maxX - minX);
      yPos = minY + random.nextDouble() * (maxY - minY);
      newPos = Offset(xPos, yPos);
    } while (isInsideRedContainer(newPos, endRadius) ||
        isTooCloseToOthers(newPos, endRadius));

    return newPos;
  }

  @override
  void initState() {
    super.initState();
    int avatarCounter = 0;

    Future.delayed(const Duration(milliseconds: 4000)).then((_) async {
      // Delay by 700 milliseconds initially
      if (!widget.start) {
        await Future.delayed(const Duration(
            milliseconds: 125)); // Additional Delay of 100ms if start is false
      }

      return Future.doWhile(() async {
        await Future.delayed(
            const Duration(milliseconds: 250)); // Delay between each avatar spawn

        if (avatarCounter >= 30) return false;

        double baseSize = 50.0 - (avatarCounter * 2.0);
        double endRadius =
            AppTheme.cardPadding + baseSize + (random.nextDouble() * 20 - 10);

        if (endRadius < AppTheme.cardPadding) {
          endRadius = AppTheme.cardPadding;
        }

        int maxTries = 10;
        int currentTry = 0;
        Offset newPos;
        do {
          newPos = generateRandomPosition(
            endRadius,
          );
          currentTry++;
        } while (
            isTooCloseToOthers(newPos, endRadius) && currentTry < maxTries);

        final avatar = AnimatedAvatar(
          position: newPos,
          vsync: this,
          uri: 'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/man-person-icon.png',
        );

        avatar.size =
            Tween<double>(begin: 0, end: endRadius).animate(avatar.controller);
        avatar.controller.duration = const Duration(milliseconds: 1000);
        avatar.controller.addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            avatar.controller.dispose();
            setState(() {
              animatedAvatars.remove(avatar);
            });
          }
        });

        avatar.controller.forward();

        setState(() {
          animatedAvatars.add(avatar);
        });

        avatarCounter++;

        await Future.delayed(const Duration(milliseconds: 200));

        return true;
      });
    });
  }

  @override
  void dispose() {
    for (var bubble in animatedAvatars) {
      bubble.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AvatarLayout(
      width: widget.width,
      height: widget.height,
      animatedAvatars: animatedAvatars,
    );
  }
}

class AvatarLayout extends StatelessWidget {
  final List<AnimatedAvatar> animatedAvatars;
  final double width;
  final double height;

  const AvatarLayout({
    required this.animatedAvatars,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Assuming a max baseSize of 70.0 and max random offset of 20.0
    double maxEndRadius = AppTheme.cardPadding + 70.0 + 20.0;

    return Stack(
      children: [
        // Positioned container representing the area where avatars can spawn
        // Positioned(
        //   top: maxEndRadius,
        //   bottom: maxEndRadius,
        //   left: maxEndRadius + AppTheme.cardPadding * 2,
        //   right: maxEndRadius + AppTheme.cardPadding * 2,
        //   child: Container(
        //     color: Colors.red.withOpacity(0.5),  // Making it slightly transparent to visualize better
        //   ),
        // ),
        ...animatedAvatars.map((avatar) {
          return AnimatedBuilder(
            animation: avatar.controller,
            builder: (context, child) {
              final avatarWidget = WebAvatar(
                mxContent: avatar.uri,
                size: avatar.size.value,
                profileId: avatar.uri,
              );

              final avatarPosition = avatar.position -
                  Offset(avatarWidget.size / 2, avatarWidget.size / 2);

              return Positioned(
                left: avatarPosition.dx,
                top: avatarPosition.dy,
                child: avatarWidget,
              );
            },
          );
        }).toList(),
      ],
    );
  }
}
