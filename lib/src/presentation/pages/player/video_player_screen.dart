import 'package:flutter/material.dart';
import 'package:myapp/src/data/local/database.dart';
import 'package:myapp/src/data/local/database_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;

  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final YoutubePlayerController _controller;
  late bool _isFavorited;
  late bool _isDownloaded;
  final AppDatabase _db = DatabaseProvider.instance;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    _isFavorited = widget.video.isFavorite;
    _isDownloaded = widget.video.isDownloaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.video.channel,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
                        onPressed: _toggleFavorite,
                      ),
                      IconButton(
                        icon: Icon(_isDownloaded ? Icons.download_done : Icons.download),
                        onPressed: _toggleDownloaded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(widget.video.description),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleFavorite() async {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    await _db.updateVideo(widget.video.copyWith(isFavorite: _isFavorited));
  }

  void _toggleDownloaded() async {
    setState(() {
      _isDownloaded = !_isDownloaded;
    });
    await _db.updateVideo(widget.video.copyWith(isDownloaded: _isDownloaded));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
