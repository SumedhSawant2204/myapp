part of 'video_bloc.dart';

@immutable
abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object> get props => [];
}

class LoadVideos extends VideoEvent {}

class ToggleFavorite extends VideoEvent {
  final String videoId;
  final bool isFavorite;

  const ToggleFavorite(this.videoId, this.isFavorite);

  @override
  List<Object> get props => [videoId, isFavorite];
}

class SearchVideos extends VideoEvent {
  final String searchTerm;

  const SearchVideos(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
