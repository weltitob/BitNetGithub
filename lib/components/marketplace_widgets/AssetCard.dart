import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:like_button/like_button.dart';

class AssetCard extends StatefulWidget {
  final double scale;
  final List<Media>? medias;
  final encodedData;
  final nftName;
  final cryptoText;
  final nftMainName;
  final String? postId;

  final String? rank;
  final bool hasLikeButton;
  final bool hasPrice;
  bool hasLiked;
  bool hasListForSale;
  bool isOwner;
  final Function(bool)? onLikeChanged;
  final Function(int)? onPriceClicked;

  AssetCard({
    Key? key,
    this.medias,
    required this.nftName,
    required this.cryptoText,
    required this.nftMainName,
    this.encodedData,
    this.postId = '',
    this.hasLiked = false,
    this.rank,
    this.hasLikeButton = true,
    this.scale = 1,
    this.hasPrice = false,
    this.hasListForSale = false,
    this.isOwner = false,
    this.onLikeChanged,
    this.onPriceClicked,
  }) : super(key: key);

  @override
  State<AssetCard> createState() => _AssetCardState();
}

class _AssetCardState extends State<AssetCard> {
  final controller = Get.find<HomeController>();
  RxBool isLiked = false.obs;

  @override
  void initState() {
    super.initState();
    isLiked.value = widget.hasLiked;
  }

  @override
  void didUpdateWidget(AssetCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.hasLiked != widget.hasLiked) {
      isLiked.value = widget.hasLiked;
    }
  }

  Widget build(BuildContext context) {
    dynamic firstMediaData =
        widget.medias?.isNotEmpty ?? false ? widget.medias?.first : null;

    return ClipRRect(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w * widget.scale),
        child: GestureDetector(
          onTap: () {
            controller.createClicks(widget.postId!);
            context.push("/asset_screen/${widget.nftName}");
          },
          child: GlassContainer(
            width: 214.w * widget.scale,
            // No fixed height to allow content to determine size
            customShadow:
                Theme.of(context).brightness == Brightness.light ? [] : null,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.elementSpacing * 1.15),
              child: Column(
                mainAxisSize:
                    MainAxisSize.min, // Changed to min to prevent overflow
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top section with name and icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.nftMainName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      GlassContainer(
                          customShadow:
                              Theme.of(context).brightness == Brightness.light
                                  ? []
                                  : null,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              FontAwesomeIcons.bolt,
                              size: 14.w,
                            ),
                          )),
                    ],
                  ),

                  SizedBox(height: AppTheme.elementSpacing.h),

                  // NFT image/content
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    child: Container(
                      height: 170.h *
                          widget.scale, // Increased height for image area
                      width: double.infinity,
                      child:
                          topWidget(firstMediaData?.type ?? '', firstMediaData),
                    ),
                  ),

                  SizedBox(height: AppTheme.elementSpacing.h / 2),

                  // Bottom section with either list button (for owner) or price
                  widget.isOwner
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.hasListForSale
                                ? LongButtonWidget(
                                    buttonType: ButtonType.transparent,
                                    customHeight: 30.h,
                                    customWidth: 140.w * widget.scale,
                                    title: "List",
                                    onTap: () {})
                                : Container(),
                            widget.hasLikeButton
                                ? _buildLikeButton()
                                : Container(),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.hasPrice
                                ? GestureDetector(
                                    onTap: () {
                                      if (widget.onPriceClicked != null && widget.postId != null) {
                                        widget.onPriceClicked!(int.parse(widget.postId!));
                                      }
                                    },
                                    child: GlassContainer(
                                      customShadow:
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? []
                                              : null,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical:
                                                AppTheme.elementSpacing / 4,
                                            horizontal:
                                                AppTheme.elementSpacing / 2),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(widget.cryptoText,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        fontSize: 12.sp)),
                                            Icon(
                                              Icons.currency_bitcoin,
                                              size: 16.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(),
                            widget.hasLikeButton
                                ? _buildLikeButton()
                                : Container(),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLikeButton() {
    return Obx(() => LikeButton(
          size: 30.w,
          isLiked: isLiked.value,
          circleSize: 40.r,
          bubblesSize: 50.r,
          animationDuration: Duration(milliseconds: 600),
          likeBuilder: (bool isLiked) {
            return Icon(
              isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
              color: isLiked
                  ? Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
                      ? AppTheme.colorBitcoin
                      : Theme.of(context).colorScheme.primary
                  : Theme.of(context).brightness == Brightness.light
                      ? AppTheme.black60
                      : AppTheme.white70,
              size: 18.sp,
            );
          },
          onTap: (isLiked) async {
            try {
              // Return the new state immediately for animation
              bool newLikedState = !isLiked;
              
              // Fire and forget - don't wait for backend update to complete the animation
              if (!isLiked) {
                controller.toggleLike(widget.postId!);
              } else {
                controller.deleteLikeByPostId(widget.postId!);
              }
              
              // Call the callback if provided
              if (widget.onLikeChanged != null) {
                widget.onLikeChanged!(newLikedState);
              }
              
              // Update local state
              this.isLiked.value = newLikedState;
              
              return newLikedState;
            } catch (e) {
              print("Error toggling like: $e");
              this.isLiked.value = isLiked; // Revert on error
              return isLiked;
            }
          },
          bubblesColor: BubblesColor(
            dotPrimaryColor: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
                ? AppTheme.colorBitcoin
                : Theme.of(context).colorScheme.primary,
            dotSecondaryColor: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
                ? AppTheme.colorPrimaryGradient
                : Theme.of(context).colorScheme.secondary,
          ),
        ));
  }

  Widget topWidget(String? type, Media? e) {
    if (e != null) {
      if (type == "text" || type == "description") {
        return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextBuilderNetwork(url: e.data));
      }
      if (type == "external_link") {
        return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: const LinkBuilder(url: 'haha'));
      }
      if (type == "asset_image") {
        // Direct asset path handling
        return Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2 / 3),
            child: Image.asset(
              e.data,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print("Error loading asset image: $error");
                return Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.image_not_supported,
                    color: Theme.of(context).colorScheme.error,
                    size: 48,
                  ),
                );
              },
            ),
          ),
        );
      }
      if (type == "image" || type == "camera" || type == "image_data") {
        try {
          return Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: ClipRect(child: ImageBuilder(encodedData: e.data)));
        } catch (error) {
          print("Error in image builder: $error");
          // Fallback for invalid base64 data
          return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.cardPadding * 2 / 3),
              child: Container(
                color: Colors.grey.shade200,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 48,
                  ),
                ),
              ),
            ),
          );
        }
      }
      if (type == "audio") {
        return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: AudioBuilderNetwork(url: e.data));
      } else {
        return Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: const TextBuilderNetwork(url: "No data found"));
      }
    } else {
      return Container();
    }
  }
}