import 'package:batch_student_objbox_api/data_source/local_data_source/load_from_json.dart';

abstract class LoadFromJsonRepository {
  Future<bool> loadFromJson();
}

class LoadFromJsonRepositoryImpl extends LoadFromJsonRepository {
  @override
  Future<bool> loadFromJson() {
    return LoadFromJsonDataSource().loadFromJsonAndInsert();
  }
}
