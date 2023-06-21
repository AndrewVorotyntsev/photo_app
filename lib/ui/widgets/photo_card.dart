import 'package:flutter/material.dart';
import 'package:photo_app/domain/image.dart';
import 'package:photo_app/res/text_styles.dart';

/// Виджет карточки фотографии
class PhotoCard extends StatelessWidget {
  final Photo photo;
  final VoidCallback? onCardTap;

  const PhotoCard({
    super.key,
    required this.photo,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158,
      width: 158,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(
            20,
          ),
        ),
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
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.author,
                  style: cardTitleTextStyle,
                ),
                Text('${photo.likes} likes', style: cardSubtitleTextStyle),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
