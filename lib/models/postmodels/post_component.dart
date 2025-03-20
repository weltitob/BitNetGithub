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
import 'package:bitnet/components/post/components/description_editor.dart';
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
  final TextEditingController? descriptionController; // For editing description in edit mode
  final FocusNode? titleFocusNode; // Focus node for the title field
  final FocusNode? descriptionFocusNode; // Focus node for the description field
  final int? debugLockTime; // Original lockTime value for debugging purposes

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
    this.descriptionController,
    this.onTitleChanged,
    this.onPostSubmit,
    this.titleFocusNode,
    this.descriptionFocusNode,
    this.debugLockTime,
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
        descriptionController: this.descriptionController,
        onTitleChanged: this.onTitleChanged,
        onPostSubmit: this.onPostSubmit,
        titleFocusNode: this.titleFocusNode,
        descriptionFocusNode: this.descriptionFocusNode,
        debugLockTime: this.debugLockTime,
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
  final TextEditingController? descriptionController;
  final Function(String)? onTitleChanged;
  final Function? onPostSubmit;
  final FocusNode? titleFocusNode;
  final FocusNode? descriptionFocusNode;
  final int? debugLockTime; // Store original lockTime value for debugging

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
    this.descriptionController,
    this.onTitleChanged,
    this.onPostSubmit,
    this.titleFocusNode,
    this.descriptionFocusNode,
    this.debugLockTime,
  });

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final String? currentUserId = Auth().currentUser?.uid;
    final bool useBitcoinGradient = Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin;

    isLiked = currentUserId != null ? (rockets[currentUserId] == true) : false;

    return RepaintBoundary(
      child: Padding(
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
                  // Debug mode: show lockTime value for troubleshooting
                  timeAgo: debugLockTime != null 
                      ? "${displayTimeAgoFromInt(timestamp.millisecondsSinceEpoch, language: 'en')} [$debugLockTime]"
                      : displayTimeAgoFromInt(timestamp.millisecondsSinceEpoch, language: 'en'),
                ),
                isEditable && titleController != null
                    ? TextField(
                        controller: titleController,
                        focusNode: titleFocusNode,
                        style: Theme.of(context).textTheme.titleSmall,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Enter title",
                          border: InputBorder.none,
                          hintStyle:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                        onSubmitted: (_) {
                          // When the user presses next, notify the parent to add a description field
                          if (onTitleChanged != null) {
                            // We use the onTitleChanged callback to notify the parent
                            // The special '__add_description__' string is a signal to add the description field
                            onTitleChanged!('__add_description__');
                          }
                        },
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
                RepaintBoundary(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildMediaWidgets(),
                  ),
                ),
                // Bottom row with like space and buttons in view mode (edit mode has no bottom buttons)
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
                    : Container(), // No button in edit mode - we moved it to the app bar
                const SizedBox(height: AppTheme.elementSpacing),
              ],
            ),
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
        // If this is the first text item, it's our description - use the description focus node
        if (medias.indexOf(postFile) == 0) {
          mediaWidget = TextBuilderLocal(
            postFile: postFile, 
            isDescription: true,
            focusNode: descriptionFocusNode,
            controller: descriptionController,
          );
        } else {
          mediaWidget = TextBuilderLocal(postFile: postFile);
        }
        break;
      case MediaType.description:
        mediaWidget = DescriptionEditorLocal(
          postFile: postFile,
          focusNode: descriptionFocusNode,
          controller: descriptionController,
        );
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
          radius: AppTheme.cardRadiusSmall.r,
          encodedData: media.data,
          caption: postName, // Pass the post name as the caption
      );
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