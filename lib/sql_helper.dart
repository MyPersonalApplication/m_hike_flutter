import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  Database? _db;

  static const String CREATE_TABLE = "CREATE TABLE IF NOT EXISTS ";
  static const String INTEGER = " INTEGER ";
  static const String TEXT = " TEXT ";
  static const String REAL = " REAL ";
  static const String PRIMARY_KEY = " PRIMARY KEY ";
  static const String AUTO_INCREMENT = " AUTOINCREMENT ";
  static const String NOT_NULL = " NOT NULL ";
  static const String COMMA = ", ";
  static const String OPEN_PARENTHESIS = " ( ";
  static const String CLOSE_PARENTHESIS = " ) ";
  static const String SEMICOLON = ";";
  static const String DROP_TABLE = "DROP TABLE IF EXISTS ";
  static const String SELECT_ALL = "SELECT * FROM ";
  static const String WHERE = " WHERE ";
  static const String AND = " AND ";
  static const String OR = " OR ";
  static const String ORDER_BY = " ORDER BY ";
  static const String ASC = " ASC ";
  static const String DESC = " DESC ";
  static const String LIMIT = " LIMIT ";
  static const String OFFSET = " OFFSET ";
  static const String INSERT_INTO = "INSERT INTO ";
  static const String VALUES = " VALUES ";
  static const String UPDATE = "UPDATE ";
  static const String SET = " SET ";
  static const String DELETE_FROM = "DELETE FROM ";
  static const String LIKE = " LIKE ";
  static const String IN = " IN ";
  static const String NOT_IN = " NOT IN ";
  static const String BETWEEN = " BETWEEN ";
  static const String NOT_BETWEEN = " NOT BETWEEN ";
  static const String IS_NULL = " IS NULL ";
  static const String IS_NOT_NULL = " IS NOT NULL ";
  static const String IS = " IS ";
  static const String IS_NOT = " IS NOT ";
  static const String EXISTS = " EXISTS ";
  static const String NOT_EXISTS = " NOT EXISTS ";
  static const String JOIN = " JOIN ";
  static const String INNER_JOIN = " INNER JOIN ";
  static const String LEFT_JOIN = " LEFT JOIN ";
  static const String RIGHT_JOIN = " RIGHT JOIN ";
  static const String CROSS_JOIN = " CROSS JOIN ";
  static const String ON = " ON ";
  static const String GROUP_BY = " GROUP BY ";
  static const String HAVING = " HAVING ";
  static const String UNION = " UNION ";
  static const String UNION_ALL = " UNION ALL ";
  static const String INTERSECT = " INTERSECT ";

  static const String DATABASE_NAME = "hike.db";
  static const int DATABASE_VERSION = 2;

  static const String TABLE_HIKE = "hike";
  static const String HIKE_ID = "id";
  static const String HIKE_NAME = "name";
  static const String HIKE_LOCATION = "location";
  static const String HIKE_LATITUDE = "latitude";
  static const String HIKE_LONGITUDE = "longitude";
  static const String HIKE_DATE = "date";
  static const String HIKE_PARKING_AVAILABLE = "parking_available";
  static const String HIKE_LENGTH = "length";
  static const String HIKE_DIFFICULTY_LEVEL = "difficulty_level";
  static const String HIKE_DESCRIPTION = "description";

  static const String CREATE_TABLE_HIKE = CREATE_TABLE +
      TABLE_HIKE +
      OPEN_PARENTHESIS +
      HIKE_ID +
      INTEGER +
      PRIMARY_KEY +
      AUTO_INCREMENT +
      COMMA +
      HIKE_NAME +
      TEXT +
      NOT_NULL +
      COMMA +
      HIKE_LOCATION +
      TEXT +
      NOT_NULL +
      COMMA +
      HIKE_LATITUDE +
      REAL +
      NOT_NULL +
      COMMA +
      HIKE_LONGITUDE +
      REAL +
      NOT_NULL +
      COMMA +
      HIKE_DATE +
      TEXT +
      NOT_NULL +
      COMMA +
      HIKE_PARKING_AVAILABLE +
      TEXT +
      NOT_NULL +
      COMMA +
      HIKE_LENGTH +
      REAL +
      NOT_NULL +
      COMMA +
      HIKE_DIFFICULTY_LEVEL +
      TEXT +
      NOT_NULL +
      COMMA +
      HIKE_DESCRIPTION +
      TEXT +
      NOT_NULL +
      CLOSE_PARENTHESIS +
      SEMICOLON;

  static const String DROP_TABLE_HIKE = DROP_TABLE + TABLE_HIKE + SEMICOLON;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initDatabase();
    return _db!;
  }

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, DATABASE_NAME);

    return await openDatabase(
      path,
      version: DATABASE_VERSION,
      onCreate: (db, version) async {
        createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        dropTables(db);
        createTables(db);
      },
    );
  }

  Future<void> createTables(Database db) async {
    await db.execute(CREATE_TABLE_HIKE);
  }

  Future<void> dropTables(Database db) async {
    await db.execute(DROP_TABLE_HIKE);
  }

  Future<int> insertHike(Map<String, dynamic> hike) async {
    final db = await database;
    return await db.insert(TABLE_HIKE, hike);
  }

  Future<List<Map<String, dynamic>>> getHikes() async {
    final db = await database;
    return db.query(TABLE_HIKE, orderBy: HIKE_DATE + DESC);
  }

  Future<Map<String, dynamic>> getHike(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(TABLE_HIKE, where: "$HIKE_ID = ?", whereArgs: [id]);
    return maps.first;
  }

  Future<int> updateHike(Map<String, dynamic> hike) async {
    final db = await database;
    return db.update(TABLE_HIKE, hike,
        where: "$HIKE_ID = ?", whereArgs: [hike[HIKE_ID]]);
  }

  Future<int> deleteHike(int id) async {
    final db = await database;
    return db.delete(TABLE_HIKE, where: "$HIKE_ID = ?", whereArgs: [id]);
  }
}
