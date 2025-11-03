import 'package:myapp/src/data/local/database.dart';

class VideoService {
  Future<List<Video>> fetchLatestVideos() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(10, (index) {
      return Video(
        id: 'video_$index',
        title: 'Video Title $index',
        description: 'This is the description for video $index',
        channel: 'Channel Name',
        thumbnailUrl:
            'https://i.ytimg.com/vi/Y9sayE_b24g/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLB-pY5b_y_y_y_y_z_z_z_z_z_z_z_z_',
        isFavorite: false,
        isDownloaded: false,
      );
    });
  }
}
