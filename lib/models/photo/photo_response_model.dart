import 'package:json_annotation/json_annotation.dart';

part 'photo_response_model.g.dart';

@JsonSerializable()
class PhotoResponseModel {
  final ImageResponseModel? urls;

  final AuthorResponseModel? user;

  final int? likes;

  final String? color;

  final String? blurHash;

  PhotoResponseModel({
    this.urls,
    this.user,
    this.likes,
    this.color,
    this.blurHash,
  });

  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return _$PhotoResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PhotoResponseModelToJson(this);
  }
}

@JsonSerializable()
class ImageResponseModel {
  final String? regular;

  ImageResponseModel({
    this.regular,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) {
    return _$ImageResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ImageResponseModelToJson(this);
  }
}

@JsonSerializable()
class AuthorResponseModel {
  final String? username;

  AuthorResponseModel({
    this.username,
  });

  factory AuthorResponseModel.fromJson(Map<String, dynamic> json) {
    return _$AuthorResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AuthorResponseModelToJson(this);
  }
}
