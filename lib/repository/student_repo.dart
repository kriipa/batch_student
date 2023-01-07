import 'package:batch_student_objbox_api/app/network_connectivity.dart';
import 'package:batch_student_objbox_api/data_source/local_data_source/student_data_source.dart';
import 'package:batch_student_objbox_api/model/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  Future<int> addStudent(Student student);
  Future<Student?> loginStudent(String username, String password);
}

class StudentRepositoryImpl extends StudentRepository {
  @override
  Future<int> addStudent(Student student) {
    return StudentDataSource().addStudent(student);
  }

  @override
  Future<List<Student>> getStudents() {
    return StudentDataSource().getStudents();
  }

  @override
  Future<Student?> loginStudent(String username, String password) async {
    bool? status = await NetworkConnectivity.isOnline();
    if (status!) {
      return StudentDataSource().loginStudent(username, password);
    } else {
      return StudentDataSource().loginStudent(username, password);
    }
  }
}
