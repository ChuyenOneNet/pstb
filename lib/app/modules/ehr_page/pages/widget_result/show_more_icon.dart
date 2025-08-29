import 'package:flutter/material.dart';
import 'package:pstb/app/modules/ehr_page/ehr_store.dart';

class ShowMoreIcon extends StatelessWidget {
  final IconData iconData;
  final bool checkShowMore;
  final EHRStore store;
  const ShowMoreIcon(
      {Key? key,
      required this.iconData,
      required this.checkShowMore,
      required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          store.showMore = checkShowMore;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
