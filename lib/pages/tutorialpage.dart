import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerScreen extends StatefulWidget {
  const YoutubePlayerScreen(
      {super.key, required this.youtubeurl, required this.tittle});
  final String youtubeurl;
  final String tittle;

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  // To control the youtube video functionality
  final _controller = YoutubePlayerController();
  @override
  void initState() {
    super.initState();
    // TO load a video by its unique id
    _controller.loadVideoById(videoId: widget.youtubeurl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text(
          widget.tittle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Expanded(
        child: YoutubePlayer(
          backgroundColor: Colors.grey.shade50,
          controller: _controller, // Controler that we created earlier
          aspectRatio: 0.5, // Aspect ratio you want to take in screen
        ),
      ),
    );
  }
}
