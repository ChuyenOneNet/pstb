import 'package:flutter/material.dart';
import 'package:pstb/utils/colors.dart';

import '../../../../../utils/styles.dart';

class ItemNew extends StatelessWidget {
  final String? image, title, categoryName;
  final DateTime? created;
  final int? count;
  final TextStyle? categoryStyle;

  final EdgeInsetsGeometry? marginContainer;
  final Function? onPress;
  final bool isFixImage;
  const ItemNew(
      {Key? key,
      this.image,
      this.title,
      this.categoryName,
      this.created,
      this.count,
      this.categoryStyle,
      this.marginContainer,
      this.onPress,
      this.isFixImage = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onPress != null ? onPress!() : {}},
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                child: isFixImage
                    ? Image.asset(
                        image ?? "",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      )
                    : Image.network(
                        image ?? '',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                        errorBuilder: (_, __, ___) {
                          return const Center(child: Icon(Icons.error));
                        },
                      ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              title ?? "",
              style: Styles.content,
            )
          ],
        ),
      ),
    );
  }
}
