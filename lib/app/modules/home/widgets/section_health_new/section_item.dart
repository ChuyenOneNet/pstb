import 'package:flutter/material.dart';
import 'package:pstb/utils/main.dart';

class SectionHealthItems extends StatelessWidget {
  const SectionHealthItems(
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

  final String? image, title, categoryName;
  final DateTime? created;
  final int? count;
  final TextStyle? categoryStyle;

  final EdgeInsetsGeometry? marginContainer;
  final Function? onPress;
  final bool isFixImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {onPress != null ? onPress!() : {}},
      child: Stack(
        children: [
          ClipRRect(
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextContent(
                text: title ?? '',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  const TextContent({Key? key, this.style, this.text}) : super(key: key);

  final TextStyle? style;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text ?? '',
            style: style ?? Styles.content.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
