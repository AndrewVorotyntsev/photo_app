import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/image.dart';
import 'package:photo_app/res/text_styles.dart';
import 'package:photo_app/ui/photo_list/photo_list_wm.dart';
import 'package:photo_app/ui/widgets/photo_card.dart';

/// Экран списка фотографий
class PhotoScreen extends ElementaryWidget<IPhotoWidgetModel> {
  const PhotoScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAppWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoWidgetModel wm) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 74,
            ),
            Padding(
              padding: EdgeInsets.only(left: 27),
              child: Text(
                "Photos",
                style: appbarTextStyle,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                ),
                padding:
                    EdgeInsets.only(left: 27, right: 26, bottom: 17, top: 10),
                itemBuilder: (context, index) {
                  return PhotoCard(
                    photo: Photo(
                      imageUrl:
                          'https://images.unsplash.com/photo-1682687981715-fa2ff72bd87d?crop=entropy&cs=srgb&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjg3MzQxODU2fA&ixlib=rb-4.0.3&q=85',
                      author: 'Author',
                      likes: 12,
                    ),
                    onCardTap: () {},
                  );
                },
              ),
            ),
            // Center(
            //   child: PhotoCard(
            //     photo: Photo(
            //       imageUrl:
            //           'https://images.unsplash.com/photo-1682687981715-fa2ff72bd87d?crop=entropy&cs=srgb&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjg3MzQxODU2fA&ixlib=rb-4.0.3&q=85',
            //       author: 'Author',
            //       likes: 12,
            //     ),
            //     onCardTap: () {},
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

/// Навигация к странице [PhotoScreen]
class PhotoScreenRoute extends MaterialPageRoute {
  PhotoScreenRoute()
      : super(
          builder: (context) => const PhotoScreen(),
        );
}
