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
  halt,
  nop,
  mov,
  add,
  sub,
  mul,
  div,
  inc,
  dec,
  jump,
  cmp,
  je,
  jne,
  out,
  
  register,

  dot,
  colon,
  
  alloc,
  segment,
  
  literal,
  string,
  identifier,
  whitespace,
  bad
}