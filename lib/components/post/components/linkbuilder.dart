import 'package:bitnet/backbone/services/short_videos_service.dart';
import 'package:bitnet/components/post/components/child_linkbuilder.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//USED FOR POSTS IN FEED ETC. PDF IS FETCHED FROM DATABASE
class LinkBuilder extends StatelessWidget {
  final String url;
  const LinkBuilder({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const YouTubeVideo();
    //return YouTubeVideo();
    // return Container(
    //   padding: EdgeInsets.symmetric(
    //     horizontal: kDefaultPadding * 0.75,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Colors.grey[900],
    //     borderRadius: BorderRadius.circular(40),
    //   ),
    //   child: Row(
    //     children: [
    //       SizedBox(width: kDefaultPadding / 4),
    //       Icon(
    //           Icons.link_rounded,
    //           color: Colors.grey,
    //       ),
    //       Expanded(
    //          child: TextField(
    //           minLines: 1,
    //           maxLines: 5,
    //           keyboardType: TextInputType.multiline,
    //           controller: commentController,
    //           decoration: InputDecoration(
    //               hintText: "Type message",
    //               border: InputBorder.none,
    //               hintStyle: TextStyle(
    //                   color: Colors.white.withOpacity(0.4),
    //                   fontWeight: FontWeight.w500)),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class YouTubeShort extends StatefulWidget {
  const YouTubeShort({Key? key}) : super(key: key);

  @override
  State<YouTubeShort> createState() => _YouTubeShortState();
}

class _YouTubeShortState extends State<YouTubeShort> {
  late YoutubePlayerController controller;

  @override
  void initState(){
    super.initState();
    const url = 'https://www.youtube.com/shorts/Zb27E2MJ7QQ?&ab_channel=Keanu';

    controller = YoutubePlayerController(
        initialVideoId: ShortsPlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          //for better quality forcehd but internetproblems could cause long loading
          forceHD: true,
          mute: false,
          loop: true,
          autoPlay: true,
          hideControls: false,
        )
    )..addListener(() {
      if (mounted) {
        setState(() {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: ShortsPlayerBuilder(
        player: ShortsPlayer(
          actionsPadding: const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
          topActions: [
            Expanded(
              child: Text(
                controller.metadata.title,
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
          bottomActions: [
            const PlaybackSpeedButtonCustom(fontSize: 16),
            const SizedBox(width: 20,),
            CurrentPosition(),
            ProgressBar(isExpanded: true,
              colors: const ProgressBarColors(
                  playedColor: Colors.orange,
                  handleColor: Colors.orange,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.grey
              ),),
            RemainingDuration(),
          ],
          controller: controller,
          liveUIColor: Colors.orange,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.orange,
          progressColors: const ProgressBarColors(
              playedColor: Colors.orange,
              handleColor: Colors.orange,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.grey
          ),),
        builder: (context, player) => player,
      ),
    );
  }
}

class YouTubeVideo extends StatefulWidget {
  const YouTubeVideo({Key? key}) : super(key: key);

  @override
  State<YouTubeVideo> createState() => _YouTubeVideoState();
}

class _YouTubeVideoState extends State<YouTubeVideo> {
  late YoutubePlayerController controller;

  @override
  void initState(){
    super.initState();
    const url = 'https://www.youtube.com/watch?v=5-sfG8BV8wU&ab_channel=Envane';

    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
          mute: false,
          loop: true,
          autoPlay: true,
          hideControls: false,
        )
    )..addListener(() {
      if (mounted) {
        setState(() {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: YoutubePlayerBuilder(
          player: YoutubePlayer(
            topActions: [
              Expanded(
                child: Text(
                  controller.metadata.title,
                  style: Theme.of(context).textTheme.titleSmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
            bottomActions: [
            const PlaybackSpeedButtonCustom(),
            const SizedBox(width: 10,),
            CurrentPosition(),
            ProgressBar(isExpanded: true,
              colors: const ProgressBarColors(
                  playedColor: Colors.orange,
                  handleColor: Colors.orange,
                  bufferedColor: Colors.grey,
                  backgroundColor: Colors.grey
              ),),
            RemainingDuration(),
            ],
            controller: controller,
            liveUIColor: Colors.orange,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.orange,
            progressColors: const ProgressBarColors(
              playedColor: Colors.orange,
              handleColor: Colors.orange,
              bufferedColor: Colors.grey,
              backgroundColor: Colors.grey
          ),),
          builder: (context, player) => player,
      ),
    );
  }
}
