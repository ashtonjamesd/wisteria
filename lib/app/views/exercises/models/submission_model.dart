final class SubmissionModel {
  final String code;
  final DateTime createdAt;

  SubmissionModel({
    required this.code,
    required this.createdAt,
  });

  factory SubmissionModel.fromMap(Map<String, dynamic> map) {
    return SubmissionModel(
      createdAt: map['createdAt'],
      code: map['code']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': createdAt,
    };
  }
}