import 'package:floor/floor.dart';
import 'package:shrtcode/data/database/entities/entities.dart';

@dao
abstract class OfflineShortenLinkResponseDao {

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertOfflineShortenLinkResponse(OfflineShortenLinkResponse record);

  @Query('SELECT * FROM OfflineShortenLinkResponse')
  Future<List<OfflineShortenLinkResponse>> getAllOfflineShortenLinkResponses();

  @Query('DELETE FROM OfflineShortenLinkResponse')
  Future<void> deleteAll();

}
