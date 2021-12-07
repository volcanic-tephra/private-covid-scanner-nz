import 'database.dart';

const DEFAULT_DURATION_MINUTES=30;

class Visit {
  static final empty = Visit(code: '', name: '', address: '', startDate: DateTime.now());
  static final table = 'visit';

  int id;
  final DateTime createDate;
  final String code;
  final String name;
  final String address;
  final String? latitude;
  final String? longitude;
  final DateTime startDate;
  final DateTime endDate;

  Visit(
      {int? id,
        required this.code,
      required this.name,
      required this.address,
      this.latitude,
      this.longitude,
      required this.startDate,
      DateTime? endDate,
      DateTime? created}):
        this.id = id ?? 0,
        this.createDate = created ?? DateTime.now(),
        this.endDate = endDate ?? startDate.add(Duration(minutes: DEFAULT_DURATION_MINUTES));

  /// Create a visit instance from database field map
  Visit.fromDb(Map<String, dynamic> db) : 
    this.id = db['id'] as int,
    this.code = db['code'] as String,
    this.name = db['name'] as String,
    this.address = db['address'] as String,
    this.latitude = db['latitude'] as String?,
    this.longitude = db['longitude'] as String?,
    this.createDate = DateTime.fromMillisecondsSinceEpoch(db['create_date'] as int),
    this.startDate = DateTime.fromMillisecondsSinceEpoch(db['start_date'] as int),
    this.endDate = DateTime.fromMillisecondsSinceEpoch(db['end_date'] as int);

  /// Create a new immutable Visit from permitted
  Visit from({DateTime? endDate}) {
      return Visit(
        id: this.id,
        code: this.code,
        name: this.name,
        address: this.address,
        longitude: this.longitude,
        latitude: this.latitude,
        startDate: this.startDate,
        endDate: endDate ?? this.endDate,
        created: this.createDate
      );
  }

  /// Create database field map from instance
  Map<String, Object?> toDb() {
    return {
      'id': this.id == 0 ? null : this.id,
      'code': this.code,
      'name': this.name,
      'address': this.address,
      'latitude': this.latitude,
      'longitude': this.longitude,
      'start_date': this.startDate.millisecondsSinceEpoch,
      'end_date': this.endDate.millisecondsSinceEpoch,
      'create_date': this.createDate.millisecondsSinceEpoch
    };
  }

  /// Create or update a visit row:
  /// - If the id is null, then insert; otherwise
  /// - Update the row
  createOrUpdate() async {
      var database = await DbManager().database;

      if (this.id == 0) {
        this.id = await database.insert(table, this.toDb());
      } else {
        await database.update(table, this.toDb());
      }
  }

  /// Delete the current visit from the database. Dispose of this instance
  /// afterwards.
  delete() async {
    var database = await DbManager().database;

    await database.delete(table, where: 'id=?', whereArgs: [this.id]);
  }

  /// Get a list of visits
  static Future<List<Visit>> list(int start, {int limit : 20}) async {
    var database = await DbManager().database;

    var rows = await database.query(table,
            columns: ['id',
              'code',
              'name',
              'address',
              'latitude',
              'longitude',
              'start_date',
              'end_date',
              'create_date'],
            orderBy: 'start_date desc',
            offset: start,
            limit: limit
          );

    return rows.map( (r) => Visit.fromDb(r)).toList();
  }
}
