import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/presentation/blocs/video_bloc.dart';
import 'package:myapp/src/presentation/widgets/video_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
        builder: (context, state) {
          if (state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is VideoLoaded) {
            final favoriteVideos = state.videos.where((v) => v.isFavorite).toList();
            if (favoriteVideos.isEmpty) {
              return const Center(child: Text('No favorite videos yet.'));
            }
            return ListView.builder(
              itemCount: favoriteVideos.length,
              itemBuilder: (context, index) {
                final video = favoriteVideos[index];
                return VideoCard(video: video);
              },
            );
          } else if (state is VideoError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }
}
