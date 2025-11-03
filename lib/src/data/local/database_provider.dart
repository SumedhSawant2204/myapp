import 'package:myapp/src/data/local/database.dart';

class DatabaseProvider {
  static final AppDatabase _instance = AppDatabase();

  static AppDatabase get instance => _instance;
}
