import 'dart:io';

import 'package:batch_student_objbox_api/app/constants.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/response/login_response.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/response/student_response.dart';
import 'package:batch_student_objbox_api/helper/http_service.dart';
import 'package:batch_student_objbox_api/model/student.dart';
import 'package:dio/dio.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class StudentRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<Student>?> getStudentsByCourse(String courseId) async {
    try {
      Response response = await _httpServices.get(
        Constant.searchStudentByCourseURL,
        queryParameters: {
          'courseId': courseId,
        },
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      List<Student> lstStudents = [];
      if (response.statusCode == 201) {
        StudentResponse stdResponse = StudentResponse.fromJson(response.data);
        lstStudents = stdResponse.data!;
        return lstStudents;
        // // Store response data to a variable
        // var responseData = response.data['data'];

        // for (var item in responseData) {
        //   var stdId = item['_id'];
        //   var fname = item['fname'];
        //   var lname = item['lname'];

        //   // Create a student object
        //   Student student = Student(
        //     stdId: stdId,
        //     fname: fname,
        //     lname: lname,
        //   );

        //   // Create a Batch
        //   var batchId = item['batch']['_id'];
        //   var batchName = item['batch']['batchName'];

        //   Batch batch = Batch(
        //     batchId,
        //     batchName,
        //   );

        //   // Assign batch to student
        //   student.batch.target = batch;

        //   for (var course in item['course']) {
        //     Course courseObj = Course(course['courseId'], course['courseName']);
        //     student.course.add(courseObj);
        //   }

        //   lstStudents.add(student);
        // }
        // return lstStudents;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<Student>?> getStudentsByBatch(String batchId) async {
    try {
      Response response = await _httpServices.get(
        Constant.searchStudentByBatchURL,
        queryParameters: {
          'batchId': batchId,
        },
      );
      if (response.statusCode == 201) {
        StudentResponse stdResponse = StudentResponse.fromJson(response.data);
        return stdResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<int> addStudent(File? file, Student student) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }

      FormData formData = FormData.fromMap({
        'fname': student.fname,
        'lname': student.lname,
        'username': student.username,
        'password': student.password,
        'batch': student.batch.target!.batchId,
        'course': student.course.map((course) => course.courseId).toList(),
        'image': image,
      });

      Response response = await _httpServices.post(
        Constant.studentURL,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

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
        Constant.token = "Bearer ${loginResponse.token!}";
        return Future.value(true);
      } else {
        return Future.value(false);
      }
    } catch (e) {
      return Future.value(false);
    }
  }
}
