import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:subspace/consts/colors.dart';
import 'package:subspace/utils/reusable_button.dart';
import 'package:subspace/utils/reusable_text_field.dart';

class NetworkErrorUi extends StatelessWidget {
  final double h;
  final double w;
  final void Function() onPressed;

  const NetworkErrorUi(
      {super.key, required this.h, required this.w, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: h * 0.15,
        ),
        Container(
          height: h * 0.15,
          width: w * 0.4,
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Lottie.asset(
              'assets/animation/noInternet.json',
              height: h * 0.2,
              width: w * 0.3,
            ),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        const ReusableText(
          text: 'No Internet Connection',
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: AppColors.kWhite,
        ),
        SizedBox(
          height: h * 0.02,
        ),
        const ReusableText(
          text:
              'Internet connection is required when you\n run the app first time.',
          fontSize: 16,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          color: AppColors.kWhite,
        ),
        SizedBox(
          height: h * 0.04,
        ),
        SizedBox(
          height: h * 0.05,
          width: w * 0.4,
          child: ReusableButton(
            text: 'Open Internet',
            borderRadius: 11,
            horizontal: 0,
            vertical: 0,
            weight: FontWeight.w500,
            color: AppColors.kWhite,
            textColor: Colors.black,
            onPressed: () {
              AppSettings.openAppSettings(
                  type: AppSettingsType.dataRoaming, asAnotherTask: true,);
            },
            size: 17,
          ),
        ),
        SizedBox(
          height: h * 0.04,
        ),
        Center(
          child: InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: h * 0.04,
              width: w * 0.4,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: AppColors.kWhite,
                  ),
                  ReusableText(
                    text: '  Refresh  ',
                    color: AppColors.kWhite,
                    fontSize: 17,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
