import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/appstandards/BitNetShaderMask.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/avatar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeamProfileCard extends StatefulWidget {
  final String avatarUrl;
  final String name;
  final String position;
  final String quote;
  final bool isYou;

  const TeamProfileCard({
    required this.avatarUrl,
    required this.name,
    required this.position,
    required this.quote,
    this.isYou = false,
  });

  @override
  _TeamProfileCardState createState() => _TeamProfileCardState();
}

class _TeamProfileCardState extends State<TeamProfileCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        scale: isHovered ? 1.0 : 0.9, // your widget tree
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Avatar(
                    size: AppTheme.cardPadding * 7,
                    mxContent: Uri.parse(widget.avatarUrl),
                    name: widget.name,
                    profileId:
                        "did:ethr:0x1234567890123456789012345678901234567890",
                    isNft: false,
                  ),
                ],
              ),
              const SizedBox(
                height: AppTheme.cardPadding,
              ),
              Text(
                widget.name,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              Text(
                widget.position,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              widget.isYou
                  ? Container()
                  : Container(
                      width: AppTheme.cardPadding * 9,
                      child: isHovered
                          ? BitNetShaderMask(
                              child: Text(
                                widget.quote,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Text(
                              widget.quote,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                    ),
              widget.isYou
                  ? LongButtonWidget(
                      title: "Contribute now!",
                      buttonType: ButtonType.transparent,
                      customHeight: AppTheme.cardPadding * 1.5,
                      customWidth: AppTheme.cardPadding * 7.5,
                      onTap: () {
                        context.go('/website/submitidea');
                      })
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
