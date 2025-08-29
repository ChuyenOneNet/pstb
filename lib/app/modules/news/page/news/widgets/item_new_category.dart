import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/colors.dart';
import '../../../../../../utils/images.dart';
import '../../../../../../utils/styles.dart';
import '../../../../../models/news_paging_model.dart';

class ItemNewCategory extends StatelessWidget {
  const ItemNewCategory({Key? key, required this.newItem}) : super(key: key);

  final NewsPagingItem newItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightSilver),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: newItem.image ?? '',
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Center(child: CircularProgressIndicator())),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Image.asset(ImageEnum.hospitalDefault),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newItem.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.titleItem,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    newItem.shortDescription ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Styles.content,
                  ),
                  const SizedBox(width: 4),
                  Text(
                      'Lượt xem: '
                          '${newItem.count}',
                      style: Styles.content),
                  const SizedBox(width: 4),
                ],
              ),
            ),
            // const Icon(Icons.keyboard_arrow_right,size: 28, color: AppColors.lightSilver,)
          ],
        ),
      ),
    );
  }
}
