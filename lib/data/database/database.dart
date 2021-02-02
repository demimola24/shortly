import 'package:floor/floor.dart';
import 'dao/dao.dart';
import 'dart:async';
import 'entities/entities.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [OfflineShortenLinkResponse])
abstract class AppDatabase extends FloorDatabase {
  OfflineShortenLinkResponseDao get offlineShortenLinkResponseDao;
}