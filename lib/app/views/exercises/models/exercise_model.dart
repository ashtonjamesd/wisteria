final class ExerciseModel {
  final String id;
  final String title;
  final String description;
  final int level;
  final String hint;
  final List<dynamic> expectedOutputs;

  // instructions to be executed before the users answer
  final String preInstructions;
  
  // the registers must contain these values for the submission to be valid
  final Map<String, dynamic> registerConditions;

  // program must contain at least one of each instruction in this list
  final List<dynamic> instructionConditions;

  // instructions the program prohibits the use of
  final List<dynamic> bannedInstructions;

  ExerciseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.level,
    required this.hint,
    required this.expectedOutputs,
    required this.preInstructions,
    required this.registerConditions,
    required this.instructionConditions,
    required this.bannedInstructions,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map, String? id) {
    return ExerciseModel(
      id: id ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '', 
      level: map['level'] ?? -1, 
      hint: map['hint'] ?? '', 
      expectedOutputs: map['expectedOutputs'] ?? [],
      preInstructions: map['preInstructions'] ?? '',
      registerConditions: map['registerConditions'] ?? {},
      instructionConditions: map['instructionConditions'] ?? [],
      bannedInstructions: map['bannedInstructions'] ?? []
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'level': level,
      'hint': hint,
      'expectedOutput': expectedOutputs,
      'preInstructions': preInstructions,
      'registerConditions': registerConditions,
      'instructionConditions': instructionConditions,
      'bannedInstructions': bannedInstructions
    };
  }
}