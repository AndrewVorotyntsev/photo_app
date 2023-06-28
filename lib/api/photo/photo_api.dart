import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:photo_app/api/api_urls.dart';
import 'package:photo_app/models/photo/photo_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'photo_api.g.dart';

@singleton
@RestApi(baseUrl: ApiUrls.unsplashApiUrl)
abstract class PhotoApi {
  @factoryMethod
  factory PhotoApi(Dio dio) = _PhotoApi;

  @GET('/photos')
  Future<List<PhotoResponseModel>> getPhotos({
    @Query('page') required int page,
    @Query('client_id') required String clientId,
  });
}
