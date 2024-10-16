import '../../domain/entities/teaser.dart';
import '../models/moviedb/teaser_response.dart';

class TeaserMapper {

  static Teaser teaserToEntity(Result result) => Teaser(
    iso6391: result.iso6391,
    iso31661: result.iso31661,
    name: result.name,
    key: result.key,
    site: result.site,
    size: result.size, 
    type: result.type,
    official: result.official,
    publishedAt: result.publishedAt,
    id: result.id
  );

}