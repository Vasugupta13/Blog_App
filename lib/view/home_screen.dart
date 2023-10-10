import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:subspace/consts/colors.dart';
import 'package:subspace/controllers/home_list_controller.dart';
import 'package:subspace/model/home_list_model.dart';
import 'package:subspace/utils/reusable_text_field.dart';
import 'package:subspace/utils/widgets/loading_indicator.dart';
import 'package:subspace/utils/widgets/network_error_widget.dart';
import 'package:subspace/utils/widgets/news_category_widget.dart';
import 'package:subspace/view/blog_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =GlobalKey<ScaffoldMessengerState>();
  final HomeListController _homeListController = Get.put(HomeListController());
  final ScrollController _scrollController = ScrollController();
  int index = 0;
  bool connect = false;

  @override
  void initState() {
    super.initState();
    //SCROLL POSITION
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _homeListController.isVisible.value = false;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _homeListController.isVisible.value = true;
      }
      if (_scrollController.position.pixels == 0) {
        _homeListController.isVisible.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      //Floating Button for scrolling up.
      floatingActionButton: Obx(
        () => Visibility(
          visible: _homeListController.isVisible.value,
          child: Align(
           alignment: const Alignment(1, 0.85),
            child: FloatingActionButton(
              backgroundColor: AppColors.kWhite,
              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: const Icon(
                Icons.arrow_upward,
                color: AppColors.kBlack,
              ),
            ),
          ),
        ),
      ),

      key: _scaffoldKey,
      backgroundColor: AppColors.kBlack,
      body: SafeArea(
        child: RefreshIndicator(
          //Refresh by scrolling from top
          color: AppColors.kWhite,
          backgroundColor: AppColors.kPrimary,
          onRefresh: () async {
            _homeListController.fetchData();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              //App Bar
              SliverAppBar(
                surfaceTintColor: AppColors.kPrimary,
                snap: true,
                expandedHeight: h * 0.07,
                pinned: true,
                floating: true,
                backgroundColor: AppColors.kPrimary,
                title: Image.asset(
                  'assets/logo.png',
                  height: h * 0.07,
                  width: w * 0.4,
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.kBlack,
                      backgroundColor: AppColors.kWhite,
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.menu,
                        size: 25,
                        color: AppColors.kBlack,
                      ),
                    ),
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      height: h * 0.06,
                      width: w,
                      decoration: const BoxDecoration(
                          color: AppColors.kPrimary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        )
                      ),

                      child: Obx(() {
                        if (_homeListController.isLoading.value) {
                          return const Text('');
                        } else {
                          return NewsCategoryWidget(); // Category List
                        }
                      }),
                    ),
                  ],
                ),
              ),
              Obx(
                () {
                  if (_homeListController.isLoading.value) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: h * 0.4,
                            ),
                            const CustomLoading()
                          ],
                        ),
                      ),
                    );
                  }
                  if (_homeListController.blogs.isEmpty) {
                    return SliverToBoxAdapter(
                      // Error Screen
                        child: NetworkErrorUi(
                            h: h,
                            w: w,
                            onPressed: () {
                              _homeListController.blogs.isEmpty;
                            },
                        ),
                    );
                  } else {
                    // Main List
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          Blog blog = _homeListController.blogs[index];
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => BlogDetails(
                                      imageUrl: blog.imageUrl,
                                      blog: blog,
                                      text: blog.title,
                                    ));
                              },
                              child: Container(
                                height: h * 0.31,
                                decoration: BoxDecoration(
                                  color: AppColors.kBlack,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: h * 0.25,
                                          width: w * 0.95,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: AppColors.kBlack,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(8),
                                                    topLeft:
                                                        Radius.circular(8)),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: blog.imageUrl,
                                              placeholder: (context, url) =>Container(
                                                alignment: Alignment.center,
                                                child: const CustomLoading(),
                                              ),
                                              errorWidget: (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => IconButton(
                                            onPressed: () async {
                                              _homeListController.toggleFavorite(blog);
                                            },
                                            icon: Icon(
                                              blog.isFavorite.value == true? Icons.favorite: Icons.favorite_border,
                                              color: AppColors.kWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: h * 0.06,
                                      width: w * 0.95,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: AppColors.kPrimary,
                                      ),
                                      child: Center(
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                                child: ReusableText(
                                                  text: blog.title,
                                                  textAlign: TextAlign.left,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow:TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.kWhite,
                                                  fontSize: 20,
                                                ),
                                              ),
                                          ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: _homeListController.blogs.length,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
