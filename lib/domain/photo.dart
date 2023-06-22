/// Доменная модель фотографии.
class Photo {
  /// Сссылка на изображение.
  final String imageUrl;

  /// Имя автора.
  final String author;

  /// Количество лайков.
  final int likes;

  Photo({
    required this.imageUrl,
    required this.author,
    required this.likes,
  });
}
