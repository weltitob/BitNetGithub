import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bitnet/backbone/cloudfunctions/taprootassets/mintasset.dart';
import 'package:bitnet/backbone/helper/helpers.dart';
import 'package:bitnet/backbone/helper/image_picker.dart';
import 'package:bitnet/backbone/helper/theme/theme.dart';
import 'package:bitnet/backbone/services/base_controller/logger_service.dart';
import 'package:bitnet/backbone/services/file_picker_service.dart';
import 'package:bitnet/components/appstandards/BitNetAppBar.dart';
import 'package:bitnet/components/appstandards/BitNetScaffold.dart';
import 'package:bitnet/components/buttons/longbutton.dart';
import 'package:bitnet/components/buttons/roundedbutton.dart';
import 'package:bitnet/components/buttons/textfieldbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/add_content_bottom_sheet/add_content.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
import 'package:bitnet/models/postmodels/post_component.dart';
import 'package:bitnet/models/tapd/minassetresponse.dart';
import 'package:bitnet/pages/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mime/mime.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

class CreateAsset extends StatefulWidget {
  const CreateAsset({super.key});

  @override
  State<CreateAsset> createState() => _CreateAssetState();
}

class _CreateAssetState extends State<CreateAsset> {
  final postFiles = <PostFile>[];
  TextEditingController commentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode descriptionFocusNode = FocusNode();
  final FocusNode inputFieldFocusNode = FocusNode();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  bool isLoading = false;
  bool hasDescription = false;
  String postId = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    initRecorder();
    
    // Set up focus change listeners to auto-add description when title gets focus
    titleFocusNode.addListener(() {
      if (!titleFocusNode.hasFocus && nameController.text.isNotEmpty) {
        // When user taps away from title and has entered text, add description
        if (!hasDescription) {
          _addDescriptionField();
        }
      }
    });
    
    // We don't need to add any special handling for the description focus node
    // since we're now using it correctly for the in-post description field
    
    commentController.addListener(() {
      if (commentController.text.isEmpty || commentController.text.isNotEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    inputFieldFocusNode.dispose();
    super.dispose();
  }

  void addMedia(MediaType mediaType) {
    if (mediaType == MediaType.text) {
      _addTextField();
    } else if (mediaType == MediaType.description) {
      // Handle description from add content sheet - add and focus on it
      _addDescriptionField();
      
      // Close the bottom sheet first
      Navigator.of(context).pop();
    } else if (mediaType == MediaType.image_data ||
        mediaType == MediaType.image) {
      _pickImageFiles(mediaType);
    } else if (mediaType == MediaType.external_url) {
      _pickLink();
    } else if (mediaType == MediaType.youtube_url) {
      _pickLink();
    } else if (mediaType == MediaType.attributes) {
      _addAttributes();
    } else if (mediaType == MediaType.spotify_url) {
      _pickLink();
    } else {
      _pickFile(mediaType);
    }
  }

  _addAttributes() {
    return BitNetBottomSheet(
        context: context,
        child: bitnetScaffold(
            extendBodyBehindAppBar: true,
            appBar: bitnetAppBar(
              context: context,
              text: L10n.of(context)!.addAttributes,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing),
                child: Column(
                  children: [
                    SizedBox(
                      height: AppTheme.cardPadding * 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppTheme.elementSpacing,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            context: context));
  }

  _pickImageFiles(MediaType mediaType) async {
    final logger = Get.find<LoggerService>();
    logger.i("Mediatype: $mediaType");
    final overlayController = Get.find<OverlayController>();
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (!ps.isAuth && !ps.hasAccess) {
      overlayController.showOverlay('please give the app photo access to continue.', color: AppTheme.errorColor);
      return;
    }
    File? file = await ImagePickerCombinedBottomSheet(context, 
      includeNFTs: false,
      onImageTap: (album, image, pair) async {
        if (image != null) {
          File? file = await image.file;
          context.pop(file);
        }
      }
    );
    if(file == null)
      return;
    postFiles.add(PostFile(mediaType, file: file));
    if (mounted) {
      setState(() {
        // Update your state here
      });
    }
  }

  void _pickLink() {
    postFiles.add(PostFile(MediaType.external_url, text: ""));
    setState(() {});
  }

  _pickFile(MediaType mediaType) async {
    final file = await FilePickerService(mediaType).pickFile();
    if (file == null) return;
    postFiles.add(PostFile(mediaType, file: file));
    if (mounted) {
      setState(() {
        // Update your state here
      });
    }
  }

  // This method now adds an empty text field that the user can edit directly in the post
  void _addTextField() {
    postFiles.add(PostFile(MediaType.text, text: ""));
    setState(() {});
  }
  
  void _addDescriptionField() {
    // If we already have a description, just focus on it
    if (hasDescription) {
      // Find the existing description (first text entry)
      int descriptionIndex = -1;
      for (int i = 0; i < postFiles.length; i++) {
        if (postFiles[i].type == MediaType.text) {
          descriptionIndex = i;
          break;
        }
      }
      
      // If found, focus on it
      if (descriptionIndex >= 0) {
        Future.delayed(Duration(milliseconds: 300), () {
          FocusScope.of(context).requestFocus(descriptionFocusNode);
        });
        return;
      }
    }
    
    // Otherwise, create a new empty description text entry
    PostFile descriptionFile = PostFile(MediaType.text, text: "");
    
    // Add it at the beginning of the list for proper ordering
    if (postFiles.isEmpty) {
      postFiles.add(descriptionFile);
    } else {
      // Insert after the first item (title)
      postFiles.insert(0, descriptionFile);
    }
    
    hasDescription = true;
    setState(() {});
    
    // Focus on the description field within the post after it's added
    // Using a longer delay to ensure the widget is fully built
    Future.delayed(Duration(milliseconds: 300), () {
      FocusScope.of(context).requestFocus(descriptionFocusNode);
    });
  }

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    final audioFile = File(path!);
    print('Recorded audio: $audioFile');
    postFiles.add(PostFile(MediaType.audio, file: audioFile));
    setState(() {}); // Update UI to show the added audio
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 10),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final overlayController = Get.find<OverlayController>();
    return PopScope(
      canPop: true,
      onPopInvoked: (bool) {
        context.pop();
      },
      child: bitnetScaffold(
        appBar: bitnetAppBar(
          text: L10n.of(context)!.createPost,
          context: context,
          hasBackButton: true,
          onTap: () {
            // Navigate back using Go Router
            context.pop();
          },
          // No actions in the app bar now
          actions: [],
        ),
        body: Container(
          child: isLoading
              ? avatarGlow(context, Icons.upload_rounded)
              : Column(
                  children: [
                    Expanded(
                      child: PostComponent(
                        postId: postId,
                        ownerId: controller.userData.value.did ?? '',
                        username: controller.userData.value.username ?? '',
                        displayname: controller.userData.value.displayName ?? '',
                        postName: nameController.text,
                        titleController: nameController,
                        titleFocusNode: titleFocusNode,
                        descriptionFocusNode: descriptionFocusNode,
                        descriptionController: descriptionController,
                        onTitleChanged: (value) {
                          if (value == '__add_description__') {
                            // Special signal to add description field
                            _addDescriptionField();
                          }
                          setState(() {});
                        },
                        rockets: {},
                        medias: postFiles,
                        timestamp: DateTime.now(),
                        isEditable: true,
                        onPostSubmit: () {
                          if (postFiles.isNotEmpty) {
                            convertToBase64AndMakePushReady(
                                context, postFiles, nameController.text);
                          } else {
                            overlayController.showOverlay(
                              L10n.of(context)!.postContentError,
                              color: AppTheme.errorColor,
                            );
                          }
                        },
                      ),
                    ),
                    buildTextField(),
                  ],
                ),
        ),
        context: context,
      ),
    );
  }

  Widget buildTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.cardPadding / 2,
        vertical: AppTheme.cardPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          AppTheme.boxShadowProfile,
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Add Content Button
            buildMicrophoneButton(),
            buildAddContentButton(),
            
            // Microphone Button

            
            // Post Button
            buildPostButton(),
          ],
        ),
      ),
    );
  }
  
  Widget buildAddContentButton() {
    return Container(
      height: AppTheme.cardPadding * 2.h,
      child: LongButtonWidget(
        buttonType: ButtonType.transparent, // Already transparent
        title: "Add Content",
        leadingIcon: Icon(
          Icons.add_rounded,
          color: Theme.of(context).brightness == Brightness.light 
              ? AppTheme.black70 
              : AppTheme.white90,
        ),
        customHeight: AppTheme.cardPadding * 2.2,
        customWidth: AppTheme.cardPadding * 6.w,
        onTap: () {
          // Show bottom sheet with content options
          BitNetBottomSheet(
            height: MediaQuery.of(context).size.height * 0.6,
            context: context,
            child: bitnetScaffold(
              context: context,
              extendBodyBehindAppBar: true,
              appBar: bitnetAppBar(
                hasBackButton: false,
                text: L10n.of(context)!.addContent,
                context: context,
              ),
              body: AddContentWidget(
                controller: this,
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget buildMicrophoneButton() {
    return RoundedButtonWidget(
      size: AppTheme.cardPadding * 2.2,
      iconData: recorder.isRecording ? Icons.stop_rounded : Icons.mic_rounded,
      iconColor: recorder.isRecording ? Colors.white : null,
      buttonType: recorder.isRecording ? ButtonType.solid : ButtonType.transparent,
      // Use custom red colors when recording
      customPrimaryColor: recorder.isRecording ? Colors.red : null,
      customSecondaryColor: recorder.isRecording ? Colors.redAccent : null,
      onTap: () async {
        if (recorder.isRecording) {
          await stop();
        } else {
          await record();
        }
        setState(() {});
      },
    );
  }
  
  Widget buildPostButton() {
    final bool isValid = postFiles.isNotEmpty && nameController.text.isNotEmpty;
    
    return Container(
      height: AppTheme.cardPadding * 2.2,
      child: LongButtonWidget(
        title: "Post",
        leadingIcon: Icon(
          Icons.send_rounded,
          color: Colors.white,
        ),
        buttonType: ButtonType.solid,
        state: isValid ? ButtonState.idle : ButtonState.disabled,
        customHeight: AppTheme.cardPadding * 2.h,
        customWidth: AppTheme.cardPadding * 6.w,
        buttonGradient: Theme.of(context).colorScheme.primary == AppTheme.colorBitcoin
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
        onTap: () {
          if (isValid) {
            convertToBase64AndMakePushReady(
              context, postFiles, nameController.text);
          }
        },
      ),
    );
  }

  // buildMicrophoneOrTextPushButton method removed as we've integrated its functionality
  // into the new buildAddContentButton method
}

// Removed _PostItem class - replaced with _buildMediaComponent method
Map<String, dynamic> convertToAssetJsonMap(List<Media> medias) {
  final Map<String, dynamic> jsonMap = {};
  for (var media in medias) {
    jsonMap[media.type] = media.data;
  }
  return jsonMap;
}

void triggerAssetMinting(
    BuildContext context, List<Media> mediasFormatted, String assetName) async {
  final overlayController = Get.find<OverlayController>();
  try {
    // Convert mediasFormatted to JSON
    final jsonMap = convertToAssetJsonMap(mediasFormatted);
    print("THE JSON MAP IS: $jsonMap");
    final jsonString = jsonEncode(jsonMap);
    print("DER JSON STRING IST: $jsonString");
    String assetDataBase64 = base64.encode(utf8.encode(jsonString));
    print(assetDataBase64);
    // Get the batch key for the next screen
    print("THE ASSETNAME WILL BE: $assetName");
    MintAssetResponse? mintAssetResponse =
        await mintAsset(assetName, assetDataBase64, false);
    if (mintAssetResponse == null) {
      overlayController.showOverlay(
        L10n.of(context)!.assetMintError,
        color: AppTheme.errorColor,
      );
      return;
    }
    String batchKey = mintAssetResponse.pendingBatch!.batchKey.toString();
    // Encode the batch key without slashes to not break paths
    print("Batch key plain: $batchKey");
    var batchKeyBytes = utf8.encode(batchKey);
    String base64BatchKey = base64Url.encode(batchKeyBytes);
    print('Navigating to /create/finalize/$base64BatchKey');
    // Use the batch key for the finalize screen
    context.go('/create/finalize/$base64BatchKey');
  } catch (e) {
    overlayController.showOverlay(
      e.toString(),
      color: AppTheme.errorColor,
    );
  }
}

void convertToBase64AndMakePushReady(
    BuildContext context, postFiles, String assetName) async {
  final overlayController = Get.find<OverlayController>();
  try {
    final mediasFormatted = <Media>[];
    
    // First check if we have a MediaType.text that should be treated as a description
    bool firstTextIsDescription = false;
    // Find the first text item
    for (int i = 0; i < postFiles.length; i++) {
      if (postFiles[i].type == MediaType.text) {
        // The first text is always our description
        firstTextIsDescription = true;
        break;
      }
    }
    
    await Future.forEach(postFiles, (PostFile file) async {
      if (file.type == MediaType.text) {
        // Skip empty text entries
        if (file.text != null && file.text!.trim().isNotEmpty) {
          // Check if this is the first text entry and should be treated as description
          if (postFiles.indexOf(file) == 0 && firstTextIsDescription) {
            // Save as description type to render properly in view mode
            mediasFormatted.add(Media(data: file.text ?? '', type: "description"));
          } else {
            mediasFormatted.add(Media(data: file.text ?? '', type: file.type.name));
          }
        }
      } else if (file.type == MediaType.external_url) {
        //later change url to link url
        mediasFormatted.add(Media(data: file.text ?? '', type: file.type.name));
      } else if (file.type == MediaType.audio) {
        //covert audio to base64
        final audioData = await file.file!.readAsBytes();
        final audioBase64 = base64Encode(audioData);
        final mimeType = lookupMimeType(file.file!.path);
        if (mimeType == "audio/mpeg") {
          mediasFormatted.add(Media(
              data: "data:audio/mpeg;base64,$audioBase64",
              type: file.type.name));
        } else if (mimeType == "audio/wav") {
          mediasFormatted.add(Media(
              data: "data:audio/wav;base64,$audioBase64",
              type: file.type.name));
        } else if (mimeType == "audio/mp3") {
          mediasFormatted.add(Media(
              data: "data:audio/mp3;base64,$audioBase64",
              type: file.type.name));
        }
      } else if (file.type == MediaType.image_data) {
        //covert image to base64
        //if jpg format let it be
        // Detect the MIME type
        final mimeType = lookupMimeType(file.file!.path);
        final imageData = await file.file!.readAsBytes();
        final imageBase64 = base64Encode(imageData);
        if (mimeType == "image/jpeg") {
          mediasFormatted.add(Media(
              data: "data:image/jpeg;base64,$imageBase64",
              type: file.type.name));
        } else if (mimeType == "image/png") {
          mediasFormatted.add(Media(
              data: "data:image/png;base64,$imageBase64",
              type: file.type.name));
        } else if (mimeType == "image/jpg") {
          mediasFormatted.add(Media(
              data: "data:image/jpg;base64,$imageBase64",
              type: file.type.name));
        }
      } else if (file.type == MediaType.description) {
        // For backward compatibility - existing posts may use this type directly
        mediasFormatted.add(Media(data: file.text ?? '', type: file.type.name));
      } else {
        LoggerService logger = Get.find();
        logger.e("file type thats not supported was added");
        // medias.add(Media(data: file.text ?? '', type: file.type.name));
      }
    });
    
    // Now mint the asset after processing all files
    triggerAssetMinting(context, mediasFormatted, assetName);
  } catch (e) {
    //isLoading = false;
    overlayController.showOverlay(
      e.toString(),
      color: AppTheme.errorColor,
    );
    // showErrorDialog(
    //     context: context, title: e.toString(), image: 'images/error.png');
  }
}