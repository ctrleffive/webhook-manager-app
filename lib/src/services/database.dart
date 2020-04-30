import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';

import 'package:webhook_manager/src/models/incoming.dart';
import 'package:webhook_manager/src/models/outgoing.dart';
import 'package:webhook_manager/src/models/notification.dart';

class DBService {
  static const int version = 1;
  static const String dbFileName = 'database.db';

  static final DBService _instance = DBService.internal();
  factory DBService() => _instance;

  DBService.internal();
  final _lock = Lock();

  static Database _db;

  Future<Database> get db async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, dbFileName);

    if (_db == null) {
      await _lock.synchronized(() async {
        // Check again once entering the synchronized block
        if (_db == null) {
          _db = await initDb(dbPath);
        }
      });
    }

    return _db;
  }

  initDb(String path) async {
    final Database db = await openDatabase(
      path,
      version: version,
      onOpen: (Database db) async {
        print('DB Version: ${await db.getVersion()}');
      },
      onCreate: (Database db, int version) async {
        await db.execute(IncomingData.tableSchema);
        await db.execute(OutgoingData.tableSchema);
        await db.execute(NotificationData.tableSchema);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // INFO: Do database alterations here.
      },
    );
    return db;
  }
}