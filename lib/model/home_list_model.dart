import 'package:get/get.dart';

class Blog {
  final String id;
  final String imageUrl;
  final String title;
   RxBool isFavorite;

  Blog( {required this.id, required this.imageUrl, required this.title, bool isFavorite = false,}) : isFavorite = isFavorite.obs;

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] ?? "00000000000000",
      imageUrl: json['image_url'] ?? 'https://cdn.subspace.money/whatsub_blogs/q.png',
      title: json['title'] ?? 'THIS IS A TITLE FOR NULLSAFETY',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'isFavorite': isFavorite.value,
    };
  }
}