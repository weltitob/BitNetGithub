import 'dart:io';

import 'package:bitnet/backbone/auth/auth.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/post/components/applemusicbuilder.dart';
import 'package:bitnet/components/post/components/attributesbuilder.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/collectionbuilder.dart';
import 'package:bitnet/components/post/components/deezerbuilder.dart';
import 'package:bitnet/components/post/components/descriptionbuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:bitnet/components/post/components/spotifybuilder.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/components/youtubemusicbuilder.dart';
import 'package:bitnet/components/post/likespace.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/pages/secondpages/mempool/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

/// A unified post component that can be used for both editing and viewing posts
class PostComponent extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String postName;
  final String username;
  final String displayname;
  final dynamic rockets;
  final List<dynamic> medias; // Can be either Media or PostFile
  final DateTime timestamp;
  final bool isEditable; // Controls whether the post is in edit or view mode
  final TextEditingController?
      titleController; // For editing post title in edit mode
  final Function(String)? onTitleChanged; // Callback for title changes
  final Function? onPostSubmit; // Callback when post button is pressed

  const PostComponent({
    required this.postId,
    required this.ownerId,
    required this.username,
    required this.rockets,
    required this.medias,
    required this.timestamp,
    required this.postName,
    required this.displayname,
    this.isEditable = false, // Default to view mode
    this.titleController,
    this.onTitleChanged,
    this.onPostSubmit,
  });

  /// Factory constructor to create from a document
  factory PostComponent.fromDocument(DocumentSnapshot doc) {
    return PostComponent(
      postName: doc["postName"],
      postId: doc["postId"],
      ownerId: doc['ownerId'],
      username: doc['username'],
      displayname: doc['displayname'],
      rockets: doc['rockets'],
      medias: List<Media>.from(doc['medias']?.map((x) => Media.fromMap(x))),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (doc['timestamp'] as Timestamp).millisecondsSinceEpoch,
      ),
    );
  }

  /// Convert PostFiles to Media objects for storage
  static List<Media> convertPostFilesToMedia(List<PostFile> postFiles) {
    return postFiles.map((pf) {
      return Media(
        type: pf.type.name,
        data: pf.text ?? '', // The file will be handled separately
      );
    }).toList();
  }

  Map<String, dynamic> toMap() {
    // Ensure medias are Media objects
    List<Map<String, dynamic>> mediaData;
    if (medias.isNotEmpty && medias.first is Media) {
      mediaData = (medias as List<Media>).map((x) => x.toMap()).toList();
    } else {
      // Convert PostFile objects to Media objects
      mediaData =
          PostComponent.convertPostFilesToMedia(medias as List<PostFile>)
              .map((x) => x.toMap())
              .toList();
    }

    return {
      'postName': postName,
      'displayname': displayname,
      'postId': postId,
      'ownerId': ownerId,
      'username': username,
      'rockets': rockets,
      'medias': mediaData,
      'timestamp': timestamp,
    };
  }

  //ist noch komplett verbuggt lol
  int getRocketCount() {
    //if no rockets, return 0
    if (rockets == null) {
      return 0;
    }
    int count = 0;
    //if key is set to true add like
    rockets.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostComponentState createState() => _PostComponentState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        rockets: this.rockets,
        displayname: this.displayname,
        rocketcount: getRocketCount(),
        medias: this.medias,
        timestamp: this.timestamp,
        postName: this.postName,
        isEditable: this.isEditable,
        titleController: this.titleController,
        onTitleChanged: this.onTitleChanged,
        onPostSubmit: this.onPostSubmit,
      );
}

class _PostComponentState extends State<PostComponent>
    with AutomaticKeepAliveClientMixin {
  final String postId;
  final String ownerId;
  final String username;
  final String displayname;
  final DateTime timestamp;
  final String postName;
  final bool isEditable;
  int rocketcount;
  Map rockets;
  final List<dynamic> medias;
  final TextEditingController? titleController;
  final Function(String)? onTitleChanged;
  final Function? onPostSubmit;

  bool showheart = false;
  late bool isLiked;

  _PostComponentState({
    required this.displayname,
    required this.postId,
    required this.postName,
    required this.ownerId,
    required this.username,
    required this.timestamp,
    required this.medias,
    required this.rockets,
    required this.rocketcount,
    required this.isEditable,
    this.titleController,
    this.onTitleChanged,
    this.onPostSubmit,
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String? currentUserId = Auth().currentUser?.uid;
    final bool useBitcoinGradient = Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin;

    isLiked = currentUserId != null ? (rockets[currentUserId] == true) : false;

    return Padding(
      padding: EdgeInsets.only(
          bottom: AppTheme.elementSpacing,
          right: AppTheme.elementSpacing.w * 0.75,
          left: AppTheme.elementSpacing.w * 0.75),
      child: GestureDetector(
        onTap: isEditable
            ? null
            : () {
                final homeController = Get.find<HomeController>();
                homeController.createClicks(postId);
              },
        child: GlassContainer(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppTheme.elementSpacing * 1.25,
              right: AppTheme.elementSpacing * 1.25,
              top: AppTheme.elementSpacing * 0.5,
              bottom: AppTheme.elementSpacing * 0.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                PostHeader(
                  username: username,
                  displayName: displayname,
                  ownerId: ownerId,
                  postId: postId,
                ),
                isEditable && titleController != null
                    ? TextField(
                        controller: titleController,
                        style: Theme.of(context).textTheme.titleSmall,
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          border: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                        onChanged: (value) {
                          if (onTitleChanged != null) {
                            onTitleChanged!(value);
                          }
                        },
                      )
                    : Text(
                        postName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                const SizedBox(height: AppTheme.elementSpacing * 1),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildMediaWidgets(),
                ),
                // Bottom row with like space and buttons in view mode, or submit button in edit mode
                !isEditable
                    ? Column(
                        children: [
                          // Like space in a single row
                          Container(
                            height: AppTheme.cardPadding * 1.5,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,


                              children: [
                                // List button with icon and text
                                LongButtonWidget(
                                  title: "List",
                                  buttonType: ButtonType.transparent,
                                  customHeight: AppTheme.cardPadding * 1.25.h,
                                  customWidth: AppTheme.cardPadding * 3.5.w,

                                  onTap: () {
                                    final homeController = Get.find<HomeController>();
                                    homeController.createClicks(postId);
                                  },
                                ),
                                Spacer(),

                                
                                // Like space with full control of width
                                buildLikeSpace(
                                  type: likeSpaceType.Post,
                                  targetId: postId,
                                  postName: postName,
                                  username: username,
                                  ownerId: ownerId,
                                  rockets: rockets),
                              ],
                            ),
                          )
                        ],
                      )
                    : onPostSubmit != null
                        ? Center(
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: AppTheme.elementSpacing),
                              child: GestureDetector(
                                onTap: () => onPostSubmit!(),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: AppTheme.cardPadding * 1.75,
                                  decoration: BoxDecoration(
                                    gradient: useBitcoinGradient
                                      ? LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppTheme.colorBitcoin,
                                            AppTheme.colorPrimaryGradient,
                                          ],
                                        )
                                      : LinearGradient(
                                          colors: [
                                            Theme.of(context).colorScheme.primary,
                                            Theme.of(context).colorScheme.secondary,
                                          ],
                                        ),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'POST',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        )
                        : Container(),
                const SizedBox(height: AppTheme.elementSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Builds the appropriate widget based on the media type and edit/view mode
  List<Widget> _buildMediaWidgets() {
    if (medias.isEmpty) return [];

    return medias.map((media) {
      if (isEditable) {
        // In edit mode, handle PostFile objects
        if (media is PostFile) {
          return _buildEditableMedia(media);
        }
      } else {
        // In view mode, handle Media objects
        if (media is Media) {
          return _buildViewableMedia(media);
        }
      }

      // Fallback if we somehow get the wrong type
      return Container(margin: const EdgeInsets.only(bottom: 10.0));
    }).toList();
  }

  // Builds editable media widgets for creating/editing posts
  Widget _buildEditableMedia(PostFile postFile) {
    Widget mediaWidget;

    switch (postFile.type) {
      case MediaType.image:
      case MediaType.image_data:
        mediaWidget = ImageBuilderLocal(postFile: postFile);
        break;
      case MediaType.text:
      case MediaType.description:
        mediaWidget = TextBuilderLocal(postFile: postFile);
        break;
      case MediaType.audio:
        mediaWidget = AudioBuilderLocal(postfile: postFile);
        break;
      case MediaType.attributes:
        mediaWidget = AttributesBuilder(attributes: postFile.text ?? '');
        break;
      case MediaType.external_url:
        mediaWidget = LinkBuilder(url: postFile.text ?? '');
        break;
      default:
        mediaWidget = Container();
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10.0), child: mediaWidget);
  }

  // Builds non-editable media widgets for viewing posts
  Widget _buildViewableMedia(Media media) {
    final type = media.type;
    Widget mediaWidget;

    if (type == "text") {
      mediaWidget = TextBuilderNetwork(url: media.data);
    } else if (type == "collection") {
      mediaWidget = CollectionBuilder(data: media.data);
    } else if (type == "description") {
      mediaWidget = DescriptionBuilder(description: media.data);
    } else if (type == "attributes") {
      mediaWidget = AttributesBuilder(attributes: media.data);
    } else if (type == "spotify_url") {
      mediaWidget = SpotifyBuilder(spotifyUrl: media.data);
    } else if (type == "youtubemusic_url") {
      mediaWidget = YoutubeMusicBuilder(youtubeUrl: media.data);
    } else if (type == "deezer_url") {
      mediaWidget = DeezerBuilder(deezerUrl: media.data);
    } else if (type == "applemusic_url") {
      mediaWidget = AppleMusicBuilder(applemusicUrl: media.data);
    } else if (type == "external_link") {
      mediaWidget = LinkBuilder(url: media.data);
    } else if (type == "image" || type == "camera" || type == "image_data") {
      mediaWidget = ImageBuilder(
          radius: AppTheme.cardRadiusMid,
          encodedData: media.data);
    } else if (type == "audio") {
      mediaWidget = AudioBuilderNetwork(url: media.data);
    } else {
      mediaWidget = TextBuilderNetwork(url: media.data); // Default fallback
    }

    return Container(
        margin: const EdgeInsets.only(bottom: 10.0), child: mediaWidget);
  }

  @override
  bool get wantKeepAlive => true;
}