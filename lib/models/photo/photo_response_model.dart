import 'package:json_annotation/json_annotation.dart';

part 'photo_response_model.g.dart';

@JsonSerializable()
class PhotoResponseModel {
  final String? imageUrl;

  final String? author;

  final int? likes;

  final String? shadowColor;

  final String? blurHash;

  PhotoResponseModel({
    this.imageUrl,
    this.author,
    this.likes,
    this.shadowColor,
    this.blurHash,
  });

  factory PhotoResponseModel.fromJson(Map<String, dynamic> json) {
    return _$PhotoResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PhotoResponseModelToJson(this);
  }
}
