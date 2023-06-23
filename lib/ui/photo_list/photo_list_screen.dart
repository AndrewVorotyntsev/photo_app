import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/domain/photo_dto.dart';
import 'package:photo_app/res/app_colors.dart';
import 'package:photo_app/res/app_strings.dart';
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
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: EntityStateNotifierBuilder<List<PhotoDto>>(
          listenableEntityState: wm.photoListState,
          errorBuilder: (context, e, list) =>
              _ErrorWidget(onRefresh: wm.refreshScreen),
          builder: (context, list) {
            if (list == null) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 11),
              );
            }
            if (list.isEmpty) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 11),
              );
            }

            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomScrollView(
                  controller: wm.photoScrollController,
                  physics: const BouncingScrollPhysics(),
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
                              photo: list[index],
                              onCardTap: () => wm.onPhotoCardTap(list[index]),
                            );
                          },
                          childCount: list.length,
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                if (wm.photoListState.value?.isLoading ?? false)
                  const Positioned(
                    bottom: 25,
                    child: CupertinoActivityIndicator(radius: 11),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Экран ошибки с возможность рефреша.
class _ErrorWidget extends StatelessWidget {
  final VoidCallback onRefresh;
  const _ErrorWidget({
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              size: 30,
            ),
            iconSize: 30,
            onPressed: onRefresh,
          ),
          const Text(AppStrings.refreshIntent),
        ],
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
      color: AppColors.headerColor,
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
                  AppStrings.photos,
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
