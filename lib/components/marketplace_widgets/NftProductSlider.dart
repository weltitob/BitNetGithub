import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/routetrees/marketplaceroutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class NftProductSlider extends StatefulWidget {
  final List<Media>? medias;
  final encodedData;
  final nftName;
  final cryptoText;
  final nftMainName;

  final String? rank;
  final bool hasLikeButton;
  final bool hasPrice;

  const NftProductSlider(
      {Key? key,
      this.medias,
      required this.nftName,
      required this.cryptoText,
      required this.nftMainName,
      this.encodedData,
      this.rank,
      this.hasLikeButton = false,
      this.hasPrice = false})
      : super(key: key);

  @override
  State<NftProductSlider> createState() => _NftProductSliderState();
}

class _NftProductSliderState extends State<NftProductSlider> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    dynamic firstMediaData = widget.medias?.first;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: GestureDetector(
        onTap: () {
          context.pushNamed(kNftProductScreenRoute,
              pathParameters: {'nft_id': widget.nftName});
        },
        child: GlassContainer(
          width: 214.w,
          height: 50.w,
          // padding: EdgeInsets.all(10.w),
          // margin: widget.columnMargin
          //     ? EdgeInsets.symmetric(horizontal: 8.w)
          //     : EdgeInsets.zero,
          // decoration: BoxDecoration(
          //   color: const Color.fromRGBO(255, 255, 255, 0.1),
          //   borderRadius: BorderRadius.circular(12.r),
          // ),
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
                        width: 150.w,
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
                  // Positioned(
                  //     bottom: 12,
                  //     right: 6,
                  //     child: GlassContainer(
                  //         child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //       child: Text(
                  //         "Rank - " + widget.rank.toString(),
                  //         style: Theme.of(context).textTheme.bodySmall,
                  //       ),
                  //     ))),
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
                          ? GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: RoundedButtonWidget(
                                iconData: Icons.favorite,
                                buttonType: ButtonType.transparent,
                                size: 30.w,
                                onTap: () {},
                              ))
                          : Container(),
                    ],
                  ),
                ),

                // Flexible(
                //   child: Container(
                //     margin: EdgeInsets.only(top: 5.h),
                //     width: 214.w - 10,
                //     child: Text(widget.nftName,
                //         style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topWidget(String? type, Media? e) {
    if (type == "text") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: TextBuilderNetwork(url: e!.data));
    }
    if (type == "description") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: TextBuilderNetwork(url: e!.data));
    }
    if (type == "external_link") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: LinkBuilder(url: 'haha'));
    }
    if (type == "image" || type == "camera") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: ImageBuilder(encodedData: e!.data));
    }
    if (type == "image_data" || type == "camera") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: ClipRect(
              child: Container(
                  height: AppTheme.cardPadding.h * 5,
                  child: ImageBuilder(encodedData: e!.data))));
    }
    if (type == "audio") {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: AudioBuilderNetwork(url: e!.data));
    } else {
      return Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: TextBuilderNetwork(url: "No data found"));
    }
  }
}
