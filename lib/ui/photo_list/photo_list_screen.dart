import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo.dart';
import 'package:photo_app/res/app_text_styles.dart';
import 'package:photo_app/ui/photo_list/photo_list_wm.dart';
import 'package:photo_app/ui/widgets/photo_card.dart';

/// Экран списка фотографий.
class PhotoListScreen extends ElementaryWidget<IPhotoListWM> {
  const PhotoListScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultAppWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPhotoListWM wm) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _AppSliverPersistentHeaderDelegate(),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 27,
                right: 26,
                bottom: 17,
                top: 10,
              ),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (
                    context,
                    index,
                  ) {
                    return PhotoCard(
                      // TODO(AndrewVorotyntsev): поставлять данные с сервера.
                      photo: Photo(
                        imageUrl:
                            'https://images.unsplash.com/photo-1682687981715-fa2ff72bd87d?crop=entropy&cs=srgb&fm=jpg&ixid=M3wzMzE5MXwxfDF8YWxsfDF8fHx8fHwyfHwxNjg3MzQxODU2fA&ixlib=rb-4.0.3&q=85',
                        author: 'Author',
                        likes: 12,
                      ),
                      onCardTap: () {
                        // TODO(AndrewVorotyntsev): открыть экран деталей фото.
                      },
                    );
                  },
                  childCount: 20,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppSliverPersistentHeaderDelegate
    extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 131;

  @override
  double get minExtent => 88;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      height: maxExtent,
      color: Colors.white.withOpacity(0.75),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.lerp(
                  const EdgeInsets.only(
                    left: 27,
                    bottom: 24,
                  ),
                  const EdgeInsets.only(
                    left: 162,
                    bottom: 14,
                  ),
                  shrinkOffset / maxExtent,
                )!,
                child: Text(
                  'Photos',
                  style: TextStyle.lerp(
                    AppTextStyles.expandedAppbarTextStyle,
                    AppTextStyles.collapsedAppbarTextStyle,
                    shrinkOffset / maxExtent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
