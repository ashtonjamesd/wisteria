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
  sub,
  mul,
  div,
  dot,
  out,
  inc,
  dec,
  colon,
  alloc,
  segment,
  literal,
  string,
  identifier,
  register,
  whitespace,
  bad
}