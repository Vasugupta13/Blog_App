import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:subspace/consts/colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      size: 80,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index.isEven
                ? AppColors.kWhite
                : AppColors.kWhite.withOpacity(0.3),

          ),
        );
      },
    );
  }
}
