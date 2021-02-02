import 'package:floor/floor.dart';
import 'package:shrtcode/data/database/entities/entities.dart';

@dao
abstract class OfflineShortenLinkResponseDao {

  @insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOfflineOrderRecord(OfflineShortenLinkResponse record);

  @Query('SELECT * FROM OfflineShortenLinkResponse')
  Future<List<OfflineShortenLinkResponse>> getAllOfflineShortenLinkResponses();

  @Query('DELETE FROM OfflineShortenLinkResponse')
  Future<void> deleteAll();

}
