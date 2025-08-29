import 'package:flutter/material.dart';
import 'package:pstb/app/modules/ehr_page/pages/widget_result/ehr_solution.dart';
import 'package:pstb/utils/colors.dart';
import 'package:pstb/utils/date_time_custom_utils.dart';
import 'package:pstb/utils/styles.dart';

class ExpansionListWidget extends StatefulWidget {
  const ExpansionListWidget({
    Key? key,
    required this.ehrSolution,
  }) : super(key: key);

  final EhrSolution ehrSolution;

  @override
  State<ExpansionListWidget> createState() => _ExpansionListWidgetState();
}

class _ExpansionListWidgetState extends State<ExpansionListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  void _runExpandCheck() {
    if (!isExpanded) {
      expandController.reverse();
    } else {
      expandController.forward();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
            _runExpandCheck();
          },
          child: Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(color: AppColors.primary),
                child: const Icon(
                  Icons.add,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  DateTimeCustomUtils.parseStringEhr(
                      dateTime: widget.ehrSolution.examination.time),
                  style: Styles.bodyBold,
                ),
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: animation,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return Text(index.toString());
            },
            itemCount: 12,
          ),
        )
      ],
    );
  }
}
