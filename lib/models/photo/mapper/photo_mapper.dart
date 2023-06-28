import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/models/photo/photo_response_model.dart';
import 'package:photo_app/utils/color_util.dart';

PhotoDto? mapPhoto(PhotoResponseModel response) {
  final imageUrl = response.urls?.regular;
  final author = response.user?.username;
  final likes = response.likes;
  final shadow = response.color;
  final blurHash = response.blurHash;

  if (imageUrl != null && author != null && likes != null && shadow != null) {
    final shadowColor = ColorUtil.fromHex(shadow);

    return PhotoDto(
      image: CachedNetworkImageProvider(imageUrl),
      author: author,
      likes: likes,
      shadowColor: shadowColor,
      blurHash: blurHash,
    );
  } else {
    return null;
  }
}

List<PhotoDto> mapListPhoto(List<PhotoResponseModel> response) {
  final photoList = List<PhotoDto>.empty(growable: true);

  for (final photoResponse in response) {
    final photo = mapPhoto(photoResponse);
    if (photo != null) {
      photoList.add(photo);
    }
  }

  return photoList;
}
