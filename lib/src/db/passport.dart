import 'package:covid_barcode/src/models/covid_passport_barcode.dart';

import 'database.dart';

class Passport {
  static final empty = Passport(uuid: '', issuedDate: DateTime.now(), expiryDate: DateTime.now(), firstName: '', familyName: '', dob: DateTime.now(), raw: '');
  static final table = 'passport';
  static final columns = ['id',
    'uuid',
    'issued_date',
    'expiry_date',
    'first_name',
    'family_name',
    'dob',
    'raw',
    'create_date'];

  int? id;
  final String uuid;
  final DateTime issuedDate;
  final DateTime expiryDate;
  final String firstName;
  final String familyName;
  final DateTime dob;
  final String raw;
  final DateTime createDate;

  Passport({int? id,
    required this.uuid,
    required this.issuedDate,
    required this.expiryDate,
    required this.firstName,
    required this.familyName,
    required this.dob,
    required this.raw,
    DateTime? created
  }) :
        this.id = id ?? 0,
        this.createDate = created ?? DateTime.now();

  factory Passport.fromBarcode(CovidPassportBarcode barcode) {
    return Passport(
      uuid: barcode.cose.jti,
      issuedDate: barcode.cose.notBefore,
      expiryDate: barcode.cose.expiry,
      dob: barcode.cose.vc.credentialSubject.dob,
      firstName: barcode.cose.vc.credentialSubject.givenName,
      familyName: barcode.cose.vc.credentialSubject.familyName,
      raw: barcode.raw,
    );
  }

  /// Create database field map from instance
  Map<String, Object?> toDb() {
    return {
      'id': this.id == 0 ? null : this.id,
      'uuid': this.uuid,
      'issued_date': this.issuedDate.millisecondsSinceEpoch,
      'expiry_date': this.expiryDate.millisecondsSinceEpoch,
      'first_name': this.firstName,
      'family_name': this.familyName,
      'dob': this.dob.millisecondsSinceEpoch,
      'raw': this.raw,
      'create_date': this.createDate.millisecondsSinceEpoch
    };
  }

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

  Passport.fromDb(Map<String, dynamic> db) :
        this.id = db['id'] as int,
        this.uuid = db['uuid'] as String,
        this.raw = db['raw'] as String,
        this.firstName = db['first_name'] as String,
        this.familyName = db['family_name'] as String,
        this.dob = DateTime.fromMillisecondsSinceEpoch(db['dob'] as int),
        this.createDate = DateTime.fromMillisecondsSinceEpoch(db['create_date'] as int),
        this.issuedDate = DateTime.fromMillisecondsSinceEpoch(db['issued_date'] as int),
        this.expiryDate = DateTime.fromMillisecondsSinceEpoch(db['expiry_date'] as int);

  /// Get a list of visits
  static Future<List<Passport>> list(int start, {int limit : 20}) async {
    var database = await DbManager().database;

    var rows = await database.query(table,
        columns: columns,
        orderBy: 'family_name desc',
        offset: start,
        limit: limit
    );

    return rows.map( (r) => Passport.fromDb(r)).toList();
  }

  static Future<Passport?> findByUuid(String uuid) async {
    var database = await DbManager().database;

    var rows = await database.query(table,
        columns: columns,
        where: 'uuid=?',
        whereArgs: [uuid]
    );

    if (rows.length == 0) {
      return null;
    }

    return Passport.fromDb(rows[0]);
  }
}