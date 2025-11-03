import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/data/local/database.dart';
import 'package:myapp/src/presentation/blocs/video_bloc.dart';

class DetailPage extends StatelessWidget {
  final String itemId;

  const DetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (context, state) {
        if (state is VideoLoaded) {
          final video = state.videos.firstWhere((v) => v.id == itemId);
          return Scaffold(
            appBar: AppBar(
              title: Text(video.title),
              actions: [
                IconButton(
                  icon: Icon(
                    video.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: video.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    context
                        .read<VideoBloc>()
                        .add(ToggleFavorite(video.id, !video.isFavorite));
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(video.thumbnailUrl),
                  const SizedBox(height: 16),
                  Text(video.title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(video.channel, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  Text(video.description),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
