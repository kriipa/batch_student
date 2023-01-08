import 'package:batch_student_objbox_api/model/student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'batch.g.dart';

//flutter pub run build_runner build  --delete-conflicting-outputs
@JsonSerializable()
@Entity()
class Batch {
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name: '_id')
  String? batchId;
  String? batchName;

  @Backlink()
  final student = ToMany<Student>();

  //Constructor
  // Batch(this.batchId, this.batchName, {this.id = 0});
  Batch(this.batchId, this.batchName, {this.id = 0});

  //Convert to JSON
  factory Batch.fromJson(Map<String, dynamic> json) => _$BatchFromJson(json);

  //Convert to Map
  Map<String, dynamic> toJson() => _$BatchToJson(this);
}
