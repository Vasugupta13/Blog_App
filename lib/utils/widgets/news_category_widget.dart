import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:subspace/consts/colors.dart';
import 'package:subspace/controllers/home_list_controller.dart';

class NewsCategoryWidget extends StatelessWidget {
   NewsCategoryWidget({super.key});
final HomeListController _homeListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx( ()=>
       ListView(
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            onTap: () {

              _homeListController.index1.value = 0;

            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _homeListController.index1
                          .value == 0
                          ? AppColors.kWhite
                          : Colors.transparent,
                      width: 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0),
                  child: Text(
                    'ALL',
                    style: GoogleFonts.workSans(
                        color: AppColors.kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _homeListController.index1.value = 1;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _homeListController.index1
                          .value == 1
                          ? AppColors.kWhite
                          : Colors.transparent,
                      width: 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0),
                  child: Text(
                    'MERCHANTS',
                    style: GoogleFonts.workSans(
                        color: AppColors.kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _homeListController.index1.value = 2;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _homeListController.index1
                          .value == 2
                          ? AppColors.kWhite
                          : Colors.transparent,
                      width: 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0),
                  child: Text(
                    'BUSINESS',
                    style: GoogleFonts.workSans(
                        color: AppColors.kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _homeListController.index1.value = 3;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _homeListController.index1
                          .value == 3
                          ? AppColors.kWhite
                          : Colors.transparent,
                      width: 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0),
                  child: Text(
                    'TUTORIALS',
                    style: GoogleFonts.workSans(
                        color: AppColors.kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _homeListController.index1.value = 4;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _homeListController.index1
                          .value == 4
                          ? AppColors.kWhite
                          : Colors.transparent,
                      width: 2),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0),
                  child: Text(
                    'LATEST',
                    style: GoogleFonts.workSans(
                        color: AppColors.kWhite,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
