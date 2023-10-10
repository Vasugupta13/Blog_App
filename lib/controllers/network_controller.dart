import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:subspace/consts/colors.dart';

class NetworkController extends GetxController{
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      Get.rawSnackbar(

          messageText: const Text(
              'NO INTERNET CONNECTION ',
              style: TextStyle(
                  color: AppColors.kWhite,
                  fontSize: 14
              )
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: AppColors.kPrimary,
          icon : const Icon(Icons.info_outline_rounded, color: AppColors.kWhite, size: 30,),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.FLOATING
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}