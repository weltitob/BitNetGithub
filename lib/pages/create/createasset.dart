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
import 'package:bitnet/components/buttons/textfieldbutton.dart';
import 'package:bitnet/components/container/imagewithtext.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/add_content_bottom_sheet/add_content.dart';
import 'package:bitnet/components/dialogsandsheets/bottom_sheets/bit_net_bottom_sheet.dart';
import 'package:bitnet/components/dialogsandsheets/notificationoverlays/overlay.dart';
import 'package:bitnet/components/fields/textfield/formtextfield.dart';
import 'package:bitnet/components/loaders/loaders.dart';
import 'package:bitnet/components/post/components/attributesbuilder.dart';
import 'package:bitnet/components/post/components/audiobuilder.dart';
import 'package:bitnet/components/post/components/imagebuilder.dart';
import 'package:bitnet/components/post/components/linkbuilder.dart';
import 'package:bitnet/components/post/components/postfile_model.dart';
import 'package:bitnet/components/post/components/textbuilder.dart';
import 'package:bitnet/components/post/post_header.dart';
import 'package:bitnet/models/postmodels/media_model.dart';
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

//THIS ONE HERE SEEMS TO BE TH EISSUE THIS IMPORT FUCKS EVERYTHING UP
//import 'package:bitnet/models/postmodels/post.dart';

class CreateAsset extends StatefulWidget {
  const CreateAsset({super.key});

  @override
  State<CreateAsset> createState() => _CreateAssetState();
}

class _CreateAssetState extends State<CreateAsset> {
  final postFiles = <PostFile>[];
  TextEditingController commentController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  bool isLoading = false;
  String postId = const Uuid().v4();

  @override
  void initState() {
    super.initState();
    initRecorder();
    commentController.addListener(() {
      if (commentController.text.isEmpty || commentController.text.isNotEmpty) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  void addMedia(MediaType mediaType) {
    if (mediaType == MediaType.text) {
      _addTextField();
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
                      height: AppTheme.cardPadding.h * 3,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8.sw,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8.sw,
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
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8.sw,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8.sw,
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
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.widgetName,
                            width: 0.8.sw,
                          ),
                        ),
                        Container(
                          width: AppTheme.cardPadding.w * 6.75,
                          child: FormTextField(
                            controller: nameController,
                            hintText: L10n.of(context)!.value,
                            width: 0.8.sw,
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

  //da stettdessen den von izak mit sleection nehmen
  //imagecopression
  _pickImageFiles(MediaType mediaType) async {
    final logger = Get.find<LoggerService>();
    logger.i("Mediatype: $mediaType");
    final overlayController = Get.find<OverlayController>();
    // dynamic file = await FilePickerService(mediaType).pickFile();
    // if (file == null) return;
    //removed compression only add when the file size is bigger then 1mb
    // file = compressImage(file, postId); //this is jpg now then lol
        final PermissionState ps =
                                  await PhotoManager.requestPermissionExtend();
                              if (!ps.isAuth && !ps.hasAccess) {
                                overlayController.showOverlay(context, 'please give the app photo access to continue.', color: AppTheme.errorColor);
                                return;
                              }
    File? file = await ImagePickerBottomSheet(context, onImageTap: (album, image) async {
      File? file =  await image.file;
      context.pop(file);
    });
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

  void _addTextField() {
    postFiles.add(PostFile(MediaType.text, text: commentController.text));
    commentController.clear();
    setState(() {});
  }

  //for Audio recording and stop
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
            context.pop();
          },
        ),
        body: Container(
            child: isLoading
                ? avatarGlow(context, Icons.upload_rounded)
                : Column(children: [
                    Expanded(
                        child: GlassContainer(
                            child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.elementSpacing,
                          vertical: AppTheme.elementSpacing),
                      child: Column(children: [
                        PostHeader(
                          displayName: '${controller.userData.value.displayName}',
                          username: '${controller.userData.value.username}',
                          ownerId: '${controller.userData.value.did}',
                          postId: '${controller.userData.value.displayName}',
                        ),
                        TextField(
                          controller: nameController,
                          decoration: AppTheme.textfieldDecoration(
                              L10n.of(context)!.nameYourAsset, context),
                        ),
                        Expanded(
                          child: postFiles.isNotEmpty
                              ? ScrollConfiguration(
                                  behavior: MyBehavior(),
                                  child: ReorderableListView(
                                    //later remove expanded to only render the normal posts when something added
                                    shrinkWrap: true,
                                    onReorder: (oldIndex, newIndex) {
                                      setState(() {
                                        final item =
                                            postFiles.removeAt(oldIndex);
                                        postFiles.insert(newIndex, item);
                                      });
                                    },
                                    children:
                                        postFiles.asMap().entries.map((e) {
                                      final index = e.key;
                                      final post = e.value;
                                      return Dismissible(
                                        key: ValueKey(post.file ??
                                            post.text ??
                                            post.type.name),
                                        confirmDismiss: (value) async {
                                          postFiles.removeAt(index);
                                          setState(() {});
                                          return Future.value(true);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: _PostItem(postFile: post),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : Container(),
                        ),
                        LongButtonWidget(
                          customHeight: AppTheme.cardPadding * 2,
                          customWidth: AppTheme.cardPadding * 6,
                          leadingIcon: postFiles.isNotEmpty
                              ? const Icon(Icons.arrow_forward_ios_rounded)
                              : const Icon(Icons.lock_rounded),
                          title: L10n.of(context)!.post,
                          onTap: () {
                            if (postFiles.isNotEmpty) {
                              convertToBase64AndMakePushReady(
                                  context, postFiles, nameController.text);
                            } else {
                              overlayController.showOverlay(
                                context,
                                L10n.of(context)!.postContentError,
                                color: AppTheme.errorColor,
                              );
                            }
                          },
                        )
                      ]),
                    ))),
                    buildTextField(),
                    // SizedBox(height: AppTheme.cardPadding * 4,),
                  ])),
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
          children: [
            Expanded(
              child: GlassContainer(
                child: Container(
                  height: AppTheme.cardPadding * 2,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.elementSpacing,
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: AppTheme.cardPadding / 4),
                      Expanded(
                        child: recorder.isRecording
                            ? StreamBuilder<RecordingDisposition>(
                                stream: recorder.onProgress,
                                builder: (context, snapshot) {
                                  final duration = snapshot.hasData
                                      ? snapshot.data!.duration
                                      : Duration.zero;

                                  String twoDigits(int n) =>
                                      n.toString().padLeft(2, '0');
                                  final twoDigitMinutes = twoDigits(
                                      duration.inMinutes.remainder(60));
                                  final twoDigitSeconds = twoDigits(
                                      duration.inSeconds.remainder(60));

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0, bottom: 15.0),
                                    child: Text(
                                        '$twoDigitMinutes:$twoDigitSeconds',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  );
                                },
                              )
                            : TextField(
                                style: Theme.of(context).textTheme.bodyLarge,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                controller: commentController,
                                decoration: AppTheme.textfieldDecoration(
                                    L10n.of(context)!.typeMessage, context)),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: AppTheme.elementSpacing / 2),
                      ),
                      TextFieldButtonMorph(
                        iconData: Icons.add_rounded,
                        onTap: () {
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
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppTheme.cardPadding / 3),
            buildMicrophoneOrTextPushButton(),
          ],
        ),
      ),
    );
  }

  Widget buildMicrophoneOrTextPushButton() {
    return InkWell(
      borderRadius: AppTheme.cardRadiusCircular,
      onTap: commentController.text.isEmpty
          ? () async {
              if (recorder.isRecording) {
                await stop();
              } else {
                await record();
              }
              setState(() {});
            }
          : () {
              _addTextField();
            },
      child: GlassContainer(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Icon(
              commentController.text.isEmpty
                  ? recorder.isRecording
                      ? Icons.stop_rounded
                      : Icons.mic_rounded
                  : Icons.arrow_upward_rounded,
              color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}

//
class _PostItem extends StatelessWidget {
  final PostFile postFile;
  const _PostItem({
    Key? key,
    required this.postFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (postFile.type == MediaType.image) {
      return ImageBuilderLocal(postFile: postFile);
    }

    if (postFile.type == MediaType.attributes) {
      return AttributesBuilder(attributes: postFile.text!);
    }

    if (postFile.type == MediaType.external_url) {
      return LinkBuilder(url: postFile.text!);
    }

    if (postFile.type == MediaType.text) {
      return TextBuilderLocal(postFile: postFile);
    }

    if (postFile.type == MediaType.description) {
      return TextBuilderLocal(
        postFile: postFile,
      );
    }

    if (postFile.type == MediaType.audio) {
      return AudioBuilderLocal(postfile: postFile);
    }

    if (postFile.type == MediaType.image_data) {
      return ImageBuilderLocal(
        postFile: postFile,
      );
    }
 

    return Container();
  }
}

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
        context,
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
      context,
      e.toString(),
      color: AppTheme.errorColor,
    );
  }
}

void convertToBase64AndMakePushReady(
    BuildContext context, postFiles, String assetName) async {
  final overlayController = Get.find<OverlayController>();
  try {
    //isLoading = true;
    final mediasFormatted = <Media>[];
    await Future.forEach(postFiles, (PostFile file) async {
      if (file.type == MediaType.text) {
        mediasFormatted.add(Media(data: file.text ?? '', type: file.type.name));
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
        mediasFormatted.add(Media(data: file.text ?? '', type: file.type.name));
      } else {
        LoggerService logger = Get.find();
        logger.e("file type thats not supported was added");
        // medias.add(Media(data: file.text ?? '', type: file.type.name));
      }
      triggerAssetMinting(context, mediasFormatted, assetName);
    });
  } catch (e) {
    //isLoading = false;
    overlayController.showOverlay(
      context,
      e.toString(),
      color: AppTheme.errorColor,
    );
    // showErrorDialog(
    //     context: context, title: e.toString(), image: 'images/error.png');
  }
}
