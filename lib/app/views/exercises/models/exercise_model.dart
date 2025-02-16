final class ExerciseModel {
  final String title;
  final String description;
  final int level;
  final String hint;
  final String expectedOutput;

  // instructions to be executed before the users answer
  final String preInstructions;
  
  // the registers must contain these values for the submission to be valid
  final Map<String, dynamic> registerConditions;

  // program must contain at least one of each instruction in this list
  final List<dynamic> instructionConditions;

  ExerciseModel({
    required this.title,
    required this.description,
    required this.level,
    required this.hint,
    required this.expectedOutput,
    required this.preInstructions,
    required this.registerConditions,
    required this.instructionConditions,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '', 
      level: map['level'] ?? -1, 
      hint: map['hint'] ?? '', 
      expectedOutput: map['expectedOutput'] ?? '',
      preInstructions: map['preInstructions'] ?? '',
      registerConditions: map['registerConditions'] ?? {},
      instructionConditions: map['instructionConditions'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'level': level,
      'hint': hint,
      'expectedOutput': expectedOutput,
      'preInstructions': preInstructions,
      'registerConditions': registerConditions,
      'instructionConditions': instructionConditions,
    };
  }
}