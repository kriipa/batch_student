import 'package:batch_student_objbox_api/model/student.dart';

import '../../helper/objectbox.dart';
import '../../state/objectbox_state.dart';

class StudentDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
  //OR
  ObjectBoxInstance objectBoxInstance2 = ObjectBoxState.objectBoxInstance!;

  Future<int> addStudent(Student student) async {
    try {
      return objectBoxInstance.addStudent(student);
    } catch (e) {
      return Future.value(0);
    }
  }

  Future<List<Student>> getStudents() {
    try {
      return Future.value(objectBoxInstance.getAllStudent());
    } catch (e) {
      throw Exception('Error in getting all student');
    }
  }

  Future<Student?> loginStudent(String username, String password) {
    try {
      return Future.value(objectBoxInstance.loginStudent(username, password));
    } catch (e) {
      return Future.value(null);
    }
  }
}
