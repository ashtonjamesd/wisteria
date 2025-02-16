final class ExerciseModel {
  final String title;
  final String description;
  final int level;
  final String hint;
  final String expectedOutput;

  ExerciseModel({
    required this.title,
    required this.description,
    required this.level,
    required this.hint,
    required this.expectedOutput,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '', 
      level: map['level'] ?? -1, 
      hint: map['hint'] ?? '', 
      expectedOutput: map['expectedOutput'] ?? '',
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'level': level,
      'hint': hint,
      'expectedOutput': expectedOutput
    };
  }
}