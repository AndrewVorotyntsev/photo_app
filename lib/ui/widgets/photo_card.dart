import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/res/app_strings.dart';
import 'package:photo_app/res/app_text_styles.dart';

/// Виджет карточки фотографии.
class PhotoCard extends StatelessWidget {
  final PhotoDto photo;
  final VoidCallback? onCardTap;

  const PhotoCard({
    required this.photo,
    this.onCardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      // Для того, чтобы изображение заняло всю карточку.
      fit: StackFit.expand,
      children: [
        if (photo.blurHash != null) BlurPlaceholder(blurHash: photo.blurHash!),
        Hero(
          tag: photo.imageUrl,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: photo.shadowColor,
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
              image: DecorationImage(
                image: CachedNetworkImageProvider(photo.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Material(
              type: MaterialType.transparency,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: onCardTap,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photo.author,
                        style: AppTextStyles.cardTitleTextStyle,
                      ),
                      Text(
                        '${photo.likes} ${AppStrings.like(photo.likes)}',
                        style: AppTextStyles.cardSubtitleTextStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Виджет с блюр эффектом на основе кэша.
/// Отображается до момента загрузки изображения.
class BlurPlaceholder extends StatelessWidget {
  final String blurHash;

  const BlurPlaceholder({
    required this.blurHash,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
      ),
      child: BlurHash(hash: blurHash),
    );
  }
}
