import 'package:floor/floor.dart';
import 'dao/dao.dart';
import 'entities/entities.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [OfflineShortenLinkResponse])
abstract class AppDatabase extends FloorDatabase {
  OfflineShortenLinkResponseDao get offlineShortenLinkResponseDao;
}