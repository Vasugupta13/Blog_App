import 'dart:ui';
import 'package:share/share.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:subspace/consts/colors.dart';
import 'package:subspace/controllers/home_list_controller.dart';
import 'package:subspace/model/home_list_model.dart';
import 'package:subspace/utils/reusable_text_field.dart';

class BlogDetails extends StatelessWidget {
  final String text;
  final Blog blog;
  final String imageUrl;
  BlogDetails(
      {super.key,
      required this.imageUrl,
      required this.blog,
      required this.text});

  final HomeListController homeListController = Get.find();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Align(
            alignment: const Alignment(1, 0.85),
          child: FloatingActionButton(

            backgroundColor: AppColors.kWhite,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            onPressed: () {
              Share.share('Headline: ${blog.title}');
            },
            child: const Icon(
              Icons.share,
              color: AppColors.kBlack,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: AppColors.kPrimary,
        body: Obx(
          () {
            if (homeListController.isLoading.value) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.4,
                      ),
                      SpinKitDoubleBounce(
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
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: h * 0.26,
                    width: w,
                    child: Stack(
                      children: [
                        Container(
                          height: h * 0.25,
                          width: w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.black26.withOpacity(0.0)
                              ],
                            ),
                            color: AppColors.kBlack,
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: imageUrl,
                              placeholder: (context, url) => Container(
                                alignment: Alignment.center,
                                child: SpinKitDoubleBounce(
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return DecoratedBox(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index.isEven
                                            ? AppColors.kWhite
                                            : AppColors.kWhite.withOpacity(0.3),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Container(
                          height: h * 0.2,
                          width: w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.5),
                                Colors.black.withOpacity(0.1),
                                Colors.black26.withOpacity(0.0)
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: AppColors.kWhite,
                                  ),
                                ),
                                const ReusableText(
                                  text: 'Blog Details',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 5),
                              child: InkWell(
                                onTap: () async {
                                  homeListController.toggleFavorite(blog);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(12)),
                                  clipBehavior: Clip.antiAlias,
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 1, sigmaY: 5),
                                    child: Icon(
                                      blog.isFavorite.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: AppColors.kWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: w,
                        ),
                        child: ReusableText(
                          text: text,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          maxLines: null,
                          color: AppColors.kWhite,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
