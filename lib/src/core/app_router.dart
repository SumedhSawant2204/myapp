import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/src/data/local/database.dart';
import 'package:myapp/src/presentation/pages/home/home_page.dart';
import 'package:myapp/src/presentation/pages/downloads/downloads_page.dart';
import 'package:myapp/src/presentation/pages/settings/settings_page.dart';
import 'package:myapp/src/presentation/pages/main_page.dart';
import 'package:myapp/src/presentation/pages/detail/detail_page.dart';
import 'package:myapp/src/presentation/pages/favorites/favorites_page.dart';
import 'package:myapp/src/presentation/pages/search/search_page.dart';
import 'package:myapp/src/presentation/pages/player/video_player_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainPage(child: child);
        },
        routes: <GoRoute>[
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
            routes: <GoRoute>[
              GoRoute(
                path: 'item/:id',
                builder: (BuildContext context, GoRouterState state) {
                  final String id = state.pathParameters['id']!;
                  return DetailPage(itemId: id);
                },
              ),
              GoRoute(
                path: 'player',
                builder: (BuildContext context, GoRouterState state) {
                  final Video video = state.extra! as Video;
                  return VideoPlayerScreen(video: video);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/downloads',
            builder: (BuildContext context, GoRouterState state) {
              return const DownloadsPage();
            },
          ),
          GoRoute(
            path: '/favorites',
            builder: (BuildContext context, GoRouterState state) {
              return const FavoritesPage();
            },
          ),
          GoRoute(
            path: '/settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsPage();
            },
          ),
        ],
      ),
      GoRoute(
        path: '/search',
        builder: (BuildContext context, GoRouterState state) {
          return const SearchPage();
        },
      ),
    ],
  );
}
