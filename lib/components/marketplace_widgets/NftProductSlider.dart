import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
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

class NftProductSlider extends StatefulWidget {
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

  NftProductSlider(
      {Key? key,
      this.medias,
      required this.nftName,
      required this.cryptoText,
      required this.nftMainName,
      this.encodedData,
      this.postId = '',
      this.hasLiked = false,
      this.rank,
      this.hasLikeButton = false,
      this.scale = 1,
      this.hasPrice = false})
      : super(key: key);

  @override
  State<NftProductSlider> createState() => _NftProductSliderState();
}

class _NftProductSliderState extends State<NftProductSlider> {
  final controller = Get.find<HomeController>();
 
 

  Widget build(BuildContext context) {
    dynamic firstMediaData =
        widget.medias?.isNotEmpty ?? false ? widget.medias?.first : null;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w * widget.scale),
      child: GestureDetector(
        onTap: () {
          controller.createClicks(widget.postId!);
          context.go("asset_screen/:${widget.nftName}");
        },
        child: GlassContainer(
          width: 214.w * widget.scale,
          height: 50.w * widget.scale,
          child: Padding(
            padding: EdgeInsets.all(AppTheme.elementSpacing.w * 0.75),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: AppTheme.elementSpacing.h / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120.w * widget.scale,
                        child: Text(
                          widget.nftMainName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      GlassContainer(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          FontAwesomeIcons.bolt,
                          size: 16.w,
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.elementSpacing.h),
                Stack(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.w),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.r),
                        ),
                        child: topWidget(
                            firstMediaData?.type ?? '', firstMediaData)),
                  ),
                ]),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      widget.hasPrice
                          ? GlassContainer(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppTheme.elementSpacing / 4,
                                    horizontal: AppTheme.elementSpacing / 2),
                                child: Row(
                                  children: [
                                    Text(widget.cryptoText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Icon(
                                      Icons.currency_bitcoin,
                                      size: 16.w,
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      widget.hasLikeButton
                          ? RoundedButtonWidget(
                              iconData: Icons.favorite,
                              buttonType: ButtonType.transparent,
                              size: 30.w,
                              iconColor: widget.hasLiked
                                  ? Colors.red
                                  : Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.black70
                                      : AppTheme.white90,
                              onTap: () async {
                                widget.hasLiked = !widget.hasLiked;
                                setState(() {});
                                controller.updateHasLiked(
                                    widget.postId!, widget.hasLiked);
                                controller.postsDataList =
                                    await controller.fetchPosts();
                                widget.hasLiked
                                    ? controller.createLikes(widget.postId!)
                                    : controller
                                        .deleteLikeByPostId(widget.postId!);
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topWidget(String? type, Media? e) {
    if (e != null) {
      if (type == "text" || type == "description") {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: TextBuilderNetwork(url: e.data));
      }
      if (type == "external_link") {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: LinkBuilder(url: 'haha'));
      }
      if (type == "image" || type == "camera" || type == "image_data") {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: ClipRect(
                child: Container(
                    height: AppTheme.cardPadding.h * 5,
                    child: ImageBuilder(encodedData: e.data))));
      }
      if (type == "audio") {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: AudioBuilderNetwork(url: e.data));
      } else {
        return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: TextBuilderNetwork(url: "No data found"));
      }
    } else {
      return Container();
    }
  }
}
