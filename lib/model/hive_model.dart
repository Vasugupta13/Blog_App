import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:subspace/model/home_list_model.dart';

class BlogAdapter extends TypeAdapter<Blog> {
  @override
  final int typeId = 0;

  @override
  Blog read(BinaryReader reader) {
    return Blog(
      id: reader.read(),
      imageUrl: reader.read(),
      title: reader.read(),
      isFavorite:  RxBool(reader.read()).value,
    );
  }

  @override
  void write(BinaryWriter writer, Blog obj) {
    writer.write(obj.id);
    writer.write(obj.imageUrl);
    writer.write(obj.title);
    writer.write(obj.isFavorite.value);
  }
}