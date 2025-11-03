import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DataClassName('Video')
class Videos extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get thumbnailUrl => text()();
  TextColumn get channel => text()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  BoolColumn get isDownloaded => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Videos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // Incremented schema version

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from == 1) {
            await m.addColumn(videos, videos.description);
          }
        },
      );

  Future<void> insertVideo(Video video) => into(videos).insert(video);
  Future<void> updateVideo(Video video) => update(videos).replace(video);
  Future<void> deleteVideo(Video video) => delete(videos).delete(video);
  Future<List<Video>> getAllVideos() => select(videos).get();
  Stream<List<Video>> watchAllVideos() => select(videos).watch();
  Future<List<Video>> searchVideos(String searchTerm) {
    return (select(videos)..where((tbl) => tbl.title.like('%$searchTerm%'))).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.v2.sqlite'));
    return NativeDatabase(file);
  });
}
