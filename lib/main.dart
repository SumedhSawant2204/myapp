import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/src/app.dart';
import 'package:myapp/src/data/local/database.dart';
import 'package:myapp/src/data/local/database_provider.dart';
import 'package:myapp/src/data/remote/video_service.dart';
import 'package:myapp/src/data/remote/youtube_service.dart';
import 'package:myapp/src/presentation/blocs/video_bloc.dart';
import 'package:myapp/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  final AppDatabase database = DatabaseProvider.instance;
  final YoutubeService youtubeService = YoutubeService();
  final VideoService videoService = VideoService();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              VideoBloc(database, youtubeService, videoService)
                ..add(LoadVideos()),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    ),
  );
}
