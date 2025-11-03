import 'package:flutter/material.dart';
import 'package:myapp/src/data/local/database.dart';

class DownloadsPage extends StatefulWidget {
  const DownloadsPage({super.key});

  @override
  State<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends State<DownloadsPage> {
  final AppDatabase _db = AppDatabase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _clearCache,
            tooltip: 'Clear Cache',
          ),
        ],
      ),
      body: StreamBuilder<List<Video>>(
        stream: _db.select(_db.videos).watch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cached videos.'));
          } else {
            final videos = snapshot.data!;
            return ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  leading: Image.network(video.thumbnailUrl, width: 100, fit: BoxFit.cover),
                  title: Text(video.title),
                  subtitle: Text(video.channel),
                  onTap: () {
                    // Optional: Navigate to player
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _clearCache() {
    _db.delete(_db.videos).go();
  }
}
