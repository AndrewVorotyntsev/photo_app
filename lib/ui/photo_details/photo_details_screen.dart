import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/res/app_strings.dart';
import 'package:photo_app/res/app_text_styles.dart';
import 'package:photo_app/ui/photo_details/photo_details_wm.dart';

/// Экран деталей фото.
class PhotoDetailsScreen extends ElementaryWidget<IPhotoDetailsWidgetModel> {
  PhotoDetailsScreen(
    PhotoDto photo, {
    Key? key,
  }) : super(
          (context) => defaultAppWidgetModelFactory(
            context,
            photo,
          ),
          key: key,
        );

  @override
  Widget build(IPhotoDetailsWidgetModel wm) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 371,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(wm.photo.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                ),
                _BackButton(
                  onBackTap: wm.onBackTap,
                ),
              ],
            ),
            const SizedBox(
              height: 21,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Text(
                wm.photo.author,
                style: AppTextStyles.authorNameTextStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26),
              child: Text(
                '${wm.likes} ${AppStrings.like(wm.likes)}',
                style: AppTextStyles.likesTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Кнопка 'Назад'.
class _BackButton extends StatelessWidget {
  final VoidCallback onBackTap;

  const _BackButton({
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 43),
      child: ClipRect(
        child: Material(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          type: MaterialType.transparency,
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: onBackTap,
            child: Text(
              AppStrings.backLabel,
              style: AppTextStyles.backButtonTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}

/// Навигация к странице [PhotoDetailsScreen].
class PhotoDetailsScreenRoute extends MaterialPageRoute<PhotoDto> {
  PhotoDetailsScreenRoute({required PhotoDto photo})
      : super(
          builder: (context) => PhotoDetailsScreen(photo),
        );
}
