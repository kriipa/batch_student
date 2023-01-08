import 'package:flutter/material.dart';
import 'package:batch_student_objbox_api/model/course.dart';
import 'package:batch_student_objbox_api/model/student.dart';
import 'package:batch_student_objbox_api/repository/batch_repo.dart';
import 'package:batch_student_objbox_api/repository/course_repository.dart';
import 'package:batch_student_objbox_api/repository/student_repo.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../model/batch.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String route = "registerScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Batch? _dropDownValue;

  List<Course> _lstCourseSelected = [];

  final _gap = const SizedBox(height: 8);

  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: 'Kiran');
  final _lnameController = TextEditingController(text: 'Rana');
  final _usernameController = TextEditingController(text: 'kiran');
  final _passwordController = TextEditingController(text: 'kiran123');
  // // Get the batch object from the list of batches
  // final batch = _lstBatches
  //     .firstWhere((element) => element.batchName == _dropDownValue);

  // student.batch.targetId = batch.batchId;
  // Insert all the course instance in Student Box

  _saveStudent() async {
    Student student = Student(
      'id',
      _fnameController.text,
      _lnameController.text,
      _usernameController.text,
      _passwordController.text,
    );

    //student.batch.targetId = _dropDownValue!.batchId;
    student.batch.target = _dropDownValue;

    // Add course
    // for (Course c in _lstCourseSelected) {
    //   student.course.add(c);
    // }
    // OR
    student.course.addAll(_lstCourseSelected);

    int status = await StudentRepositoryImpl().addStudent(student);
    _showMessage(status);
  }

  // _showStudentCourse() async {
  //   List<Student> lstStudent = await StudentRepositoryImpl().getStudents();
  //   for (Student s in lstStudent) {
  //     debugPrint(s.fname);
  //     for (Course c in s.course) {
  //       debugPrint(c.courseName);
  //     }
  //   }
  // }

  _showMessage(int status) {
    if (status > 0) {
      MotionToast.success(
        description: const Text('Student added successfully'),
      ).show(context);
    } else {
      MotionToast.error(description: const Text('Error in adding student'))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _fnameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _lnameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  FutureBuilder(
                    future: BatchRepositoryImpl().getAllBatch(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          validator: (value) {
                            if (value == null) {
                              return 'Please select batch';
                            }
                            return null;
                          },
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Select Batch',
                          ),
                          items: snapshot.data!
                              .map(
                                (batch) => DropdownMenuItem(
                                  value: batch,
                                  child: Text(batch.batchName!),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            _dropDownValue = value!;
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  _gap,
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select Courses',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _gap,
                  FutureBuilder(
                    future: CourseRepositoryImpl().getAllCourse(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return MultiSelectDialogField(
                          title: const Text('Select course'),
                          items: snapshot.data!
                              .map((course) => MultiSelectItem(
                                    course,
                                    course.courseName,
                                  ))
                              .toList(),
                          listType: MultiSelectListType.CHIP,
                          buttonText: const Text('Select course'),
                          buttonIcon: const Icon(Icons.search),
                          onConfirm: (values) {
                            _lstCourseSelected = values;
                          },
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          validator: ((value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select course';
                            }
                            return null;
                          }),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  _gap,
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: ((value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    }),
                  ),
                  _gap,
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          _saveStudent();
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
