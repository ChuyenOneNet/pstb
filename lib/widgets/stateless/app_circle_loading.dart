import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pstb/utils/main.dart';

class AppCircleLoading extends StatelessWidget {
  const AppCircleLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      /// vòng tròng có 2 tam giác
      // child:   SpinKitHourGlass(color: AppColors.primary, duration: Duration(seconds: 1), size: 40.0,),
      /// đồng hồ cát
      // child: SpinKitPouringHourGlassRefined(color: AppColors.primary, size: 50.0, strokeWidth: 2.0,),
      /// âm nhạc
      // child: SpinKitWave(color: AppColors.primary, type: SpinKitWaveType.start, size: 40.0,),
      /// tròn mặc định
      child: SpinKitCircle(
        color: AppColors.primary,
      ),
    );
  }
}
