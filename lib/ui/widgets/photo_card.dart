import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/res/app_colors.dart';
import 'package:photo_app/res/app_strings.dart';
import 'package:photo_app/res/app_text_styles.dart';

/// Виджет карточки фотографии.
class PhotoCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onCardTap;

  const PhotoCard({
    required this.photo,
    this.onCardTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158,
      width: 158,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(photo.imageUrl),
          fit: BoxFit.fill,
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
                  '${photo.likes} ${AppStrings.likes}',
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
    );
  }
}
