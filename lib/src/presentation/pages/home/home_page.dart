import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/presentation/blocs/video_bloc.dart';
import 'package:myapp/src/presentation/widgets/video_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video App'),
      ),
      body: BlocBuilder<VideoBloc, VideoState>(
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
    );
  }
}
