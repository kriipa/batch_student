import 'package:batch_student_objbox_api/app/constants.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/response/login_response.dart';
import 'package:batch_student_objbox_api/helper/http_service.dart';
import 'package:dio/dio.dart';

class StudentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<bool> loginStudent(String username, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.studentLoginURL,
        data: {
          'username': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = loginResponse.token!;
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }
}
