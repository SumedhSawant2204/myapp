import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/data/local/database.dart';
import 'package:myapp/src/data/remote/video_service.dart';
import 'package:myapp/src/data/remote/youtube_service.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final AppDatabase appDatabase;
  final YoutubeService youtubeService;
  final VideoService videoService;

  VideoBloc(this.appDatabase, this.youtubeService, this.videoService)
      : super(VideoInitial()) {
    on<LoadVideos>(_onLoadVideos);
    on<ToggleFavorite>(_onToggleFavorite);
    on<SearchVideos>(_onSearchVideos);
  }

  Future<void> _onLoadVideos(LoadVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      final localVideos = await appDatabase.getAllVideos();
      if (localVideos.isEmpty) {
        final remoteVideos = await youtubeService.getPopularVideos();
        final simulatedVideos = await videoService.fetchLatestVideos();

        final videosToSave = [...remoteVideos, ...simulatedVideos].map((video) =>
            Video(
                id: video.id,
                title: video.title,
                description: video.description,
                thumbnailUrl: video.thumbnailUrl,
                channel: video.channel,
                isFavorite: video.isFavorite,
                isDownloaded: video.isDownloaded));

        await Future.forEach(videosToSave, (video) async {
          await appDatabase.insertVideo(video);
        });
      }

      final videos = await appDatabase.getAllVideos();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> _onToggleFavorite(
      ToggleFavorite event, Emitter<VideoState> emit) async {
    try {
      final currentVideos = (state as VideoLoaded).videos;
      final videoToUpdate = currentVideos.firstWhere((v) => v.id == event.videoId);
      final updatedVideo = videoToUpdate.copyWith(isFavorite: event.isFavorite);

      await appDatabase.updateVideo(updatedVideo);

      final updatedVideos = currentVideos
          .map((v) => v.id == event.videoId ? updatedVideo : v)
          .toList();

      emit(VideoLoaded(updatedVideos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }

  Future<void> _onSearchVideos(
      SearchVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      final videos = await appDatabase.searchVideos(event.searchTerm);
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError(e.toString()));
    }
  }
}
