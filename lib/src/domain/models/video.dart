import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String channelTitle;
  final bool isFavorite;
  final bool isDownloaded;

  const Video({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.channelTitle,
    this.isFavorite = false,
    this.isDownloaded = false,
  });

  Video copyWith({
    String? id,
    String? title,
    String? description,
    String? thumbnailUrl,
    String? channelTitle,
    bool? isFavorite,
    bool? isDownloaded,
  }) {
    return Video(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      channelTitle: channelTitle ?? this.channelTitle,
      isFavorite: isFavorite ?? this.isFavorite,
      isDownloaded: isDownloaded ?? this.isDownloaded,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        thumbnailUrl,
        channelTitle,
        isFavorite,
        isDownloaded,
      ];
}
