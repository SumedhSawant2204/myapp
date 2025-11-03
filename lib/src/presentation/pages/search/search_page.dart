import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/presentation/blocs/video_bloc.dart';
import 'package:myapp/src/presentation/widgets/video_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (searchTerm) {
                context.read<VideoBloc>().add(SearchVideos(searchTerm));
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<VideoBloc>().add(LoadVideos());
            },
            child: const Text('Clear Search'),
          ),
          Expanded(
            child: BlocBuilder<VideoBloc, VideoState>(
              builder: (context, state) {
                if (state is VideoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VideoLoaded) {
                  return ListView.builder(
                    itemCount: state.videos.length,
                    itemBuilder: (context, index) {
                      final video = state.videos[index];
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
          ),
        ],
      ),
    );
  }
}
