import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pstb/app/models/medical_unit/hospital_unit_model.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_page.dart';
import 'package:pstb/app/modules/bottom_nav/bottom_nav_store.dart';
import 'package:pstb/app/modules/home/home_store.dart';
import 'package:pstb/app/modules/medical_unit/detail_hospital/widget/description_widget.dart';
import 'package:pstb/app/modules/medical_unit/selection_hospital_store.dart';
import 'package:pstb/app/user_app_store.dart';
import 'package:pstb/utils/hex_color.dart';
import 'package:pstb/utils/main.dart';
import 'package:pstb/utils/sessions/session_prefs.dart';
import 'package:pstb/widgets/stateful/custom_dialog.dart';
import 'package:pstb/widgets/stateless/button_back.dart';
import 'package:pstb/widgets/stateless/stateless_widget.dart';
import '../../../app_store.dart';
import 'detail_hospital_store.dart';

class DetailHospitalPage extends StatefulWidget {
  final HospitalModel hospitalModel;

  const DetailHospitalPage({
    Key? key,
    required this.hospitalModel,
  }) : super(key: key);

  @override
  State<DetailHospitalPage> createState() => _DetailHospitalPageState();
}

class _DetailHospitalPageState extends State<DetailHospitalPage> {
  final DetailHospitalStore detailHospitalStore =
      Modular.get<DetailHospitalStore>();
  final SelectionHospitalStore selectionHospitalStore =
      Modular.get<SelectionHospitalStore>();
  final BottomNavStore bottomNavStore = Modular.get<BottomNavStore>();
  final AppStore _appStore = Modular.get<AppStore>();
  final UserAppStore _userAppStore = Modular.get<UserAppStore>();
  final HomeStore homeStore = Modular.get<HomeStore>();
  // Define the controller as non-nullable
  final CarouselSliderController _controllerSlider = CarouselSliderController();

  @override
  void initState() {
    // TODO: implement initState
    getInfoUnit();
    super.initState();
  }

  Future<void> getInfoUnit() async {
    await detailHospitalStore.checkLogin();
    await detailHospitalStore.getDetailMedical(widget.hospitalModel.id!);
    await detailHospitalStore.getSlideMedical(widget.hospitalModel.id!);
    await detailHospitalStore.getUserReviewUnit(widget.hospitalModel.id!);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    var model = _appStore.landingUnitModel;
    return Observer(builder: (context) {
      return detailHospitalStore.isLoading
          ? const SizedBox()
          : Scaffold(
              body: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await _determinePosition();
                                print('open map');
                                Position position =
                                    await Geolocator.getCurrentPosition(
                                        desiredAccuracy: LocationAccuracy.high);
                                List<Location> locations = [];
                                try {
                                  // locations = await locationFromAddress("Số 68 Tây Mỗ,Q.Nam Từ Liêm, Hà Nội");
                                  locations = await locationFromAddress(
                                      detailHospitalStore
                                              .detailHospital.address ??
                                          '');
                                } catch (e) {
                                  AppSnackBar.show(
                                      context,
                                      AppSnackBarType.Error,
                                      'Địa chỉ chưa chính xác');
                                }
                                final availableMaps =
                                    await MapLauncher.installedMaps;
                                print(availableMaps);
                                if (await MapLauncher.isMapAvailable(
                                        MapType.google) ==
                                    true) {
                                  MapLauncher.showDirections(
                                      mapType: MapType.google,
                                      destination: Coords(locations[0].latitude,
                                          locations[0].longitude),
                                      // destinationTitle: controller.nameUnit!,
                                      destinationTitle: 'HYH medical plus',
                                      origin: Coords(position.latitude,
                                          position.longitude),
                                      originTitle: 'Vị trí hiện tại');
                                } else if (await MapLauncher.isMapAvailable(
                                        MapType.apple) ==
                                    true) {
                                  MapLauncher.showDirections(
                                      mapType: MapType.apple,
                                      destination: Coords(locations[0].latitude,
                                          locations[0].longitude),
                                      // destinationTitle: controller.nameUnit!,
                                      destinationTitle: 'HYH medical plus',
                                      origin: Coords(position.latitude,
                                          position.longitude),
                                      originTitle: 'Vị trí hiện tại');
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Image.network(
                                      detailHospitalStore
                                              .detailHospital.image ??
                                          '',
                                      errorBuilder: (_, __, ___) {
                                        return Center(
                                          child: Image.asset(
                                              ImageEnum.hospitalDefault),
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          detailHospitalStore
                                                  .detailHospital.name ??
                                              'Bệnh Viện Phụ Sản Thái Bình',
                                          style: Styles.titleItem,
                                        ),
                                        const SizedBox(
                                          height: 4.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.location_on),
                                            Flexible(
                                              child: Text(
                                                detailHospitalStore
                                                        .detailHospital
                                                        .address ??
                                                    "Số 530 đường Lý Bôn, Thai Binh, Vietnam",
                                                style: Styles.content.copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Observer(builder: (context) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    autoPlay: true,
                                    viewportFraction: 1.0,
                                    aspectRatio: 2,
                                    enableInfiniteScroll: true,
                                    onPageChanged: (index, reason) {},
                                  ),
                                  carouselController: _controllerSlider,
                                  items: List.generate(
                                      detailHospitalStore.listSlide.length,
                                      (index) {
                                    return Image.network(
                                      detailHospitalStore
                                              .listSlide[index].path ??
                                          "",
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) {
                                        return const Center(
                                          child: Icon(Icons.error),
                                        );
                                      },
                                    );
                                  }),
                                ),
                              );
                            }),
                            DescriptionWidget(
                                title: 'Giới thiệu',
                                description: detailHospitalStore
                                        .detailHospital.description ??
                                    'Là bệnh viện chuyên khoa hạng I của tỉnh Thái Bình, '
                                        'trực thuộc Sở Y tế Thái Bình, với chức năng chính là chăm sóc sức khỏe bà mẹ và trẻ em.\n'
                                        '\nBệnh viện có nhiều khoa, phòng chức năng đáp ứng các lĩnh vực:\n'
                                        '- Khám, chẩn đoán và điều trị các bệnh lý sản phụ khoa\n'
                                        '- Chăm sóc sức khỏe sinh sản\n'
                                        '- Khoa hiếm muộn và hỗ trợ sinh sản\n'
                                        '- Khoa sơ sinh và nhi khoa\n'
                                        '- Đào tạo, nghiên cứu khoa học và chuyển giao kỹ thuật\n'
                                        '- Chỉ đạo tuyến và hợp tác quốc tế'),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Xếp hạng & Đánh giá',
                                  style: Styles.titleItem,
                                ),
                                InkWell(
                                  onTap: () async {
                                    await detailHospitalStore.getReviewHospital(
                                      detailHospitalStore.detailHospital.id!,
                                    );
                                    Modular.to
                                        .pushNamed(AppRoutes.allReviewHospital);
                                  },
                                  child: Text(
                                    'Xem tất cả',
                                    style: Styles.content
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            (detailHospitalStore.detailHospital.aveRate ==
                                        null ||
                                    detailHospitalStore
                                            .detailHospital.aveRate ==
                                        0)
                                ? Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Bệnh viện chưa có đánh giá nào!',
                                          style: Styles.content,
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '${detailHospitalStore.detailHospital.aveRate}/5',
                                            style: Styles.titleItem
                                                .copyWith(fontSize: 40),
                                          ),
                                          Text(
                                            '${detailHospitalStore.detailHospital.reviewCounter} bài đánh giá',
                                            style: Styles.content,
                                          ),
                                        ],
                                      ),
                                      RatingBarIndicator(
                                        rating: detailHospitalStore
                                                    .detailHospital.aveRate ==
                                                0
                                            ? 5
                                            : double.parse(detailHospitalStore
                                                .detailHospital.aveRate
                                                .toString()),
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 40.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Đánh giá của bạn',
                                  style: Styles.titleItem,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            formRateAndReview(),
                          ],
                        ),
                      ),
                    ),
                    const ButtonBackWidget(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  if (widget.hospitalModel.status) {
                    print("currentIndex = ${bottomNavStore.currentIndex}");
                    bottomNavStore.currentIndex = 4;
                    Modular.to.pop();
                    print("currentIndex = ${bottomNavStore.currentIndex}");
                  } else {
                    await SessionPrefs.saveUnit(widget.hospitalModel);
                    bottomNavStore.currentIndex = 4;
                    int medicalUnitId =
                        await SessionPrefs.getMedicalUnitId() ?? 0;
                    await _appStore.getLandingUnit(medicalUnitId);
                    await _userAppStore.disconnectHIS();
                    homeStore.isStaff = false;
                    await SessionPrefs.isStaff(false);
                    // Modular.to.pop();
                    Modular.to.popAndPushNamed(AppRoutes.landingUnit);
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: HexColor(model.theme!.primaryColor!),
                ),
                backgroundColor: Colors.white,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: FABBottomAppBar(
                onTabSelected: (id) {},
                items: const [],
                notchedShape: const CircularNotchedRectangle(),
                color: AppColors.gray500,
              ),
            );
    });
  }

  Future<void> sendUserReview() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomDialog(
            title: "Đánh giá của bạn",
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đánh giá',
                      style: Styles.titleItem,
                    ),
                    RatingBar.builder(
                      initialRating:
                          double.parse(detailHospitalStore.rate.toString()),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 28,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        if (0 < rating && rating <= 1) {
                          detailHospitalStore.rate = 1;
                        } else if (1 < rating && rating <= 2) {
                          detailHospitalStore.rate = 2;
                        } else if (2 < rating && rating <= 3) {
                          detailHospitalStore.rate = 3;
                        } else if (3 < rating && rating <= 4) {
                          detailHospitalStore.rate = 4;
                        } else if (5 < rating && rating <= 5) {
                          detailHospitalStore.rate = 5;
                        } else {
                          detailHospitalStore.rate = 5;
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Nhận xét',
                      style: Styles.titleItem,
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightSilver),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextFormField(
                    initialValue: detailHospitalStore.review,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Hãy nhập nội dung';
                      }
                      return null;
                    },
                    maxLines: 3,
                    onChanged: (value) {
                      detailHospitalStore.review = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Hãy nhập nội dung',
                      hintStyle:
                          Styles.content.copyWith(color: AppColors.grayLight),
                    ),
                  ),
                ),
              ],
            ),
            titleButton: detailHospitalStore.isUpdate ? 'Cập nhật' : 'Gửi',
            iconRight: detailHospitalStore.isUpdate ? null : IconEnums.send,
            onPressed: detailHospitalStore.isUpdate
                ? () async {
                    await detailHospitalStore.updateReviewUnit(
                        detailHospitalStore.detailHospital.id!,
                        detailHospitalStore.review,
                        detailHospitalStore.rate);
                    Modular.to.pop();
                    await detailHospitalStore.getUserReviewUnit(
                      detailHospitalStore.detailHospital.id!,
                    );
                    await detailHospitalStore
                        .getDetailMedical(widget.hospitalModel.id!);
                    await selectionHospitalStore.getHospitals(true);
                    await selectionHospitalStore.checkUnitChoose();
                  }
                : () async {
                    await detailHospitalStore.sendReviewUnit(
                        detailHospitalStore.detailHospital.id!,
                        detailHospitalStore.review,
                        detailHospitalStore.rate);
                    Modular.to.pop();
                    await detailHospitalStore.getUserReviewUnit(
                      detailHospitalStore.detailHospital.id!,
                    );
                    await detailHospitalStore
                        .getDetailMedical(widget.hospitalModel.id!);
                    await selectionHospitalStore.getHospitals(true);
                    await selectionHospitalStore.checkUnitChoose();
                  });
      },
    );
  }

  Widget formRateAndReview() {
    return Observer(builder: (context) {
      if (!detailHospitalStore.isChecked) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                'Vui lòng đăng nhập để sử dụng tính năng nhận xét.',
                style: Styles.content,
              ),
            ),
          ],
        );
      } else {
        return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightSilver),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Observer(builder: (context) {
              return Column(
                children: [
                  detailHospitalStore.userReviewModel.rate != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                detailHospitalStore.rate =
                                    detailHospitalStore.userReviewModel.rate!;
                                detailHospitalStore.review =
                                    detailHospitalStore.userReviewModel.review!;
                                detailHospitalStore.isUpdate = true;
                                sendUserReview();
                              },
                              child: const Icon(
                                Icons.edit_note,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            InkWell(
                              onTap: () async {
                                detailHospitalStore.rate =
                                    detailHospitalStore.userReviewModel.rate!;
                                detailHospitalStore.review =
                                    detailHospitalStore.userReviewModel.review!;
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return CustomDialog(
                                        title: "Xoá đánh giá của bạn",
                                        content: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  'Đánh giá',
                                                  style: Styles.titleItem,
                                                ),
                                                RatingBarIndicator(
                                                  rating: detailHospitalStore
                                                              .userReviewModel
                                                              .rate ==
                                                          null
                                                      ? 5
                                                      : double.parse(
                                                          detailHospitalStore
                                                              .userReviewModel
                                                              .rate
                                                              .toString()),
                                                  itemBuilder:
                                                      (context, index) =>
                                                          const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  itemCount: 5,
                                                  itemSize: 35.0,
                                                  direction: Axis.horizontal,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 16.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nhận xét',
                                                  style: Styles.titleItem,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              margin: const EdgeInsets.only(
                                                  top: 8.0),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.lightSilver),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: TextFormField(
                                                initialValue:
                                                    detailHospitalStore.review,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Hãy nhập nội dung';
                                                  }
                                                  return null;
                                                },
                                                readOnly: true,
                                                maxLines: 3,
                                                onChanged: (value) {
                                                  detailHospitalStore.review =
                                                      value;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: 'Hãy nhập nội dung',
                                                  hintStyle: Styles.content
                                                      .copyWith(
                                                          color: AppColors
                                                              .grayLight),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        titleButton: 'Xoá',
                                        onPressed: () async {
                                          detailHospitalStore.review = '';
                                          detailHospitalStore.rate = 5;
                                          await detailHospitalStore
                                              .deleteReviewUnit(
                                            detailHospitalStore
                                                .detailHospital.id!,
                                          );
                                          Modular.to.pop();
                                          await detailHospitalStore
                                              .getUserReviewUnit(
                                            detailHospitalStore
                                                .detailHospital.id!,
                                          );
                                          await detailHospitalStore
                                              .getDetailMedical(
                                                  widget.hospitalModel.id!);
                                          await selectionHospitalStore
                                              .getHospitals(true);
                                          await selectionHospitalStore
                                              .checkUnitChoose();
                                        });
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                detailHospitalStore.review = '';
                                detailHospitalStore.rate = 5;
                                detailHospitalStore.isUpdate = false;
                                sendUserReview();
                              },
                              child: const Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: detailHospitalStore.userReviewModel.rate == null
                            ? 5
                            : double.parse(detailHospitalStore
                                .userReviewModel.rate
                                .toString()),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      detailHospitalStore.userReviewModel.reviewedTime == null
                          ? const SizedBox()
                          : Text(
                              DateFormat(DateTimeFormatPattern.dobddMMyyyy)
                                  .format(detailHospitalStore
                                      .userReviewModel.reviewedTime!
                                      .toLocal()),
                              style: Styles.content,
                            )
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Text(
                        detailHospitalStore.userReviewModel.review ??
                            'Hãy gửi đánh giá của bạn cho chúng tôi. ',
                        style: Styles.content,
                      ),
                    ],
                  )
                ],
              );
            }));
      }
    });
  }
}
