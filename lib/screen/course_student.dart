import 'package:batch_student_objbox_api/repository/student_repo.dart';
import 'package:flutter/material.dart';

class CourseStudentScreen extends StatefulWidget {
  const CourseStudentScreen({super.key});
  static const String route = "courseStudentScreen";

  @override
  State<CourseStudentScreen> createState() => _CourseStudentScreenState();
}

class _CourseStudentScreenState extends State<CourseStudentScreen> {
  String courseId = '';

  @override
  void didChangeDependencies() {
    courseId = ModalRoute.of(context)!.settings.arguments as String;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students in $courseId'),
      ),
      body: FutureBuilder(
        future: StudentRepositoryImpl().getStudentsByCourse(courseId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final lstStudents = snapshot.data!;
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // var a = lstStudents[index].batch.target!.batchName.toString();
                return ListTile(
                  title: Text(lstStudents[index].fname!),
                  subtitle: Text(lstStudents[index].lname!),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            lstStudents.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
