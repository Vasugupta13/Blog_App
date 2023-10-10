import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:subspace/model/home_list_model.dart';


class HomeListController extends GetxController {
  var isLoading = true.obs;
  RxList<Blog> blogs = <Blog>[].obs;
  RxInt index1 = 0.obs;
  RxBool isVisible = true.obs;
  final String boxName = 'blogBox';
  final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var cachedData = await Hive.openBox<Blog>(boxName);

      if (cachedData.isNotEmpty) {
        blogs.assignAll(cachedData.values.toList());
      }

      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['blogs'];
        blogs.assignAll(data.map((blog) => Blog.fromJson(blog)).toList());

        cachedData.clear();
        cachedData.addAll(blogs);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      isLoading(false);
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoading(false);
    }
  }
  void toggleFavorite(Blog blog) {
    blog.isFavorite.toggle();
    saveToHive();
  }

  void saveToHive() async {
    var cachedData = await Hive.openBox<Blog>(boxName);
    cachedData.clear();
    cachedData.addAll(blogs);
  }
  void changeIndex (int index){
     index1.value = index;
  }
}
