import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/services.dart';
import 'package:data_nime/utils/route_observer.dart';

class AnimeTrailerPlayer extends StatefulWidget {
  final String youtubeId;

  const AnimeTrailerPlayer({super.key, required this.youtubeId});

  @override
  State<AnimeTrailerPlayer> createState() => _AnimeTrailerPlayerState();
}

class _AnimeTrailerPlayerState extends State<AnimeTrailerPlayer>
    with RouteAware {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.youtubeId,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _controller.close();
    super.dispose();
  }

  @override
  void didPushNext() {
    _controller.pauseVideo();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      fullscreenOrientations: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      defaultOrientations: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      lockedOrientations: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      builder: (context, player) => player,
    );
  }
}
