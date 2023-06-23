import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/models/photo/photo_response_model.dart';
import 'package:photo_app/utils/color_util.dart';

Photo? mapPhoto(PhotoResponseModel response) {
  final imageUrl = response.urls?.regular;
  final author = response.user?.username;
  final likes = response.likes;
  final shadow = response.color;
  final blurHash = response.blurHash;

  if (imageUrl != null &&
      author != null &&
      likes != null &&
      shadow != null &&
      blurHash != null) {
    final shadowColor = ColorUtil.fromHex(shadow);

    return Photo(
      imageUrl: imageUrl,
      author: author,
      likes: likes,
      shadowColor: shadowColor,
      blurHash: blurHash,
    );
  } else {
    return null;
  }
}

List<Photo> mapListPhoto(List<PhotoResponseModel> response) {
  final photoList = List<Photo>.empty();

  for (final photoResponse in response) {
    final photo = mapPhoto(photoResponse);
    if (photo != null) {
      photoList.add(photo);
    }
  }

  return photoList;
}
