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
  jle,
  jl,
  jge,
  jg,
  out,
  neg,
  and,
  or,
  xor,
  not,
  store,
  load,
  wait,
  
  register,

  dot,
  colon,
  semicolon,
  
  alloc,
  segment,
  
  literal,
  string,
  identifier,
  whitespace,
  bad
}