import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/src/data/local/database.dart';

class YoutubeService {
  // TODO: Replace with your YouTube Data API key.
  // For instructions on how to get a key, please visit:
  // https://developers.google.com/youtube/v3/getting-started
  static const String _apiKey = 'AIzaSyArUoa4bnDFZyeukl51RG7mhxC9swHu4Bw';
  static const String _baseUrl = 'https://www.googleapis.com/youtube/v3';

  Future<List<Video>> getPopularVideos() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl/videos?part=snippet&chart=mostPopular&maxResults=20&key=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) {
        final snippet = item['snippet'];
        return Video(
          id: item['id'],
          title: snippet['title'],
          description: snippet['description'],
          thumbnailUrl: snippet['thumbnails']['high']['url'],
          channel: snippet['channelTitle'],
          isFavorite: false,
          isDownloaded: false,
        );
      }).toList();
    } else {
      throw Exception('Failed to load videos: ${response.body}');
    }
  }
}
