final class Token {
  final String lexeme;
  final TokenType type;

  Token({
    required this.lexeme,
    required this.type,
  });

  @override
  String toString() {
    return "$lexeme $type";
  }
}

enum TokenType {
  nop,
  jump,
  mov,
  add,
  dot,
  literal,
  identifier,
  register,
  bad
}