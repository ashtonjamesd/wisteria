import 'package:wisteria/components/launcher/models/game_project_type.dart';

final class GameProject {
  final String name;
  final GameProjectType type;

  final int createdByUserId;
  final DateTime createdAt;

  GameProject({
    required this.name,
    required this.type,
    required this.createdByUserId,
    required this.createdAt,
  });
}