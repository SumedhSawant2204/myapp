# Project Blueprint

## Overview

This is a Flutter application designed to browse and play popular videos from YouTube. It features a home screen displaying a list of trending videos and a dedicated video player screen. The app uses the `youtube_player_flutter` package for a full-featured playback experience and `drift` for local database capabilities, including storing downloaded and favorited videos.

## Features & Design

- **Home Page:** Displays a vertically scrollable list of the most popular videos on YouTube.
  - Each video is presented in a `Card` with its thumbnail, title, and channel name.
  - Tapping a video card navigates to the player screen.
- **Video Player:** A feature-rich video player screen.
  - Uses the `youtube_player_flutter` package to provide a standard YouTube-like UI with overlay controls.
  - Displays the video's title and description below the player.
  - Includes "Favorite" and "Download" buttons to manage videos locally.
- **Local Storage:** Uses a `drift` database to store video metadata, including whether a video is favorited or downloaded.

## Current Task: Implement Player Screen Features

**Objective:** Add the video title, description, and interactive "Favorite" and "Download" buttons to the player screen.

### Steps:

1.  **Update Data Model (`video.dart`):**
    - Add `description`, `isFavorite`, and `isDownloaded` fields to the `Video` class.
2.  **Update Database (`database.dart`):**
    - Add boolean columns for `is_favorite` and `is_downloaded` to the `Videos` table.
3.  **Run Code Generation:** Execute `dart run build_runner build` to update the generated database and model files.
4.  **Update Navigation (`video_card.dart`):**
    - Modify the navigation logic to pass the full `Video` object to the `VideoPlayerScreen` instead of just the `videoId`.
5.  **Rebuild Player Screen (`video_player_screen.dart`):**
    - The screen will now accept a `Video` object.
    - Add UI elements to display the video `title` and `description`.
    - Add `IconButton` widgets for "Favorite" (a heart icon) and "Download".
    - Implement the `onPressed` logic for the buttons to update the video's status in the `AppDatabase` via the `DatabaseProvider`.
6.  **Final Test:** Run the app to verify the new UI elements are present and functional, and that the state persists correctly.
