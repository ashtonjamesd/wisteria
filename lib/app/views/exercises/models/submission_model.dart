import 'package:cloud_firestore/cloud_firestore.dart';

final class SubmissionModel {
  final String exerciseId;
  final String code;
  final DateTime createdAt;

  SubmissionModel({
    required this.exerciseId,
    required this.code,
    required this.createdAt,
  });

  factory SubmissionModel.fromMap(Map<String, dynamic> map) {
    return SubmissionModel(
      exerciseId: map['exerciseId'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      code: map['code']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'exerciseId': exerciseId,
      'createdAt': createdAt,
      'code': code,
    };
  }
}