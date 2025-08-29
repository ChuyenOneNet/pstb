
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../utils/colors.dart';
import '../../home/widgets/section_title.dart';
import '../selection_hospital_store.dart';
import 'item_prominent_widget.dart';

class UnitProminentWidget extends StatefulWidget {
  const UnitProminentWidget({Key? key}) : super(key: key);

  @override
  State<UnitProminentWidget> createState() => _UnitProminentWidget1State();
}

class _UnitProminentWidget1State extends State<UnitProminentWidget> {
  final SelectionHospitalStore selectionHospitalStore =
  Modular.get<SelectionHospitalStore>();


  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (context){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                child: SectionTitle(
                  fontWeight: FontWeight.w900,
                  title: 'Cơ sở y tế nổi bật',
                  // color: AppColors.background,
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  reverse: false,
                  viewportFraction: 0.9,
                  enlargeCenterPage: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    selectionHospitalStore.changeNews(index);
                  },
                ),
                items: List.generate(2,
                        (index) {
                      final prominent = selectionHospitalStore.listUnitProminent[index];
                      return Container(
                        width: MediaQuery.of(context).size.width / 0.7,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ItemProminent(
                          item: prominent,
                          store: selectionHospitalStore,
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  selectionHospitalStore.listUnitProminent.length,
                      (index) {
                    if (index == selectionHospitalStore.slideNo){
                      return Container(
                        width: 20.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.accent500,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }else{
                      return Container(
                        width: 5.0,
                        height: 5.0,
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: AppColors.accent100,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          );
        }
    );
  }
}
