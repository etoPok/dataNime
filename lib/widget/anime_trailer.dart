import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class AnimeTrailerPlayer extends StatefulWidget {
  final String youtubeId;

  const AnimeTrailerPlayer({super.key, required this.youtubeId});

  @override
  State<AnimeTrailerPlayer> createState() => _AnimeTrailerPlayerState();
}

class _AnimeTrailerPlayerState extends State<AnimeTrailerPlayer> {
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
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      aspectRatio: 16 / 9,
      builder: (context, player) {
        return player;
      },
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
