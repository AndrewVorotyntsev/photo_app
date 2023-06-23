import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo.dart';
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
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 43),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Material(
                      type: MaterialType.transparency,
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: wm.onBackTap,
                        child: Text(
                          AppStrings.backLabel,
                          style: AppTextStyles.backButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
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
                '${wm.photo.likes} ${AppStrings.likes}',
                style: AppTextStyles.likesTextStyle,
              ),
            ),
          ],
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
