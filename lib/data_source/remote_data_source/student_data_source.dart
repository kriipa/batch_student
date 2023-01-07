import 'package:batch_student_objbox_api/app/constants.dart';
import 'package:batch_student_objbox_api/helper/http_service.dart';
import 'package:batch_student_objbox_api/model/student.dart';
import 'package:dio/dio.dart';

class StudentRemoteDataSource {
  // Future<int> addStudent(Student student) async {

  // }

  // Future<List<Student>> getStudents() {

  // }

  Future<Student?> loginStudent(String username, String password) async {
    try {
      Response response = await HttpServices().getDioInstance().post(
        Constant.studentLoginURL,
        data: {
          'username': username,
          'password': password,
        },
      );
    } catch (e) {
      return Future.value(null);
    }
    return null;
  }
}
