import 'token.dart';

final class Lexer {
  String program;
  final List<Token> tokens = [];

  int current = 0;

  Lexer({
    required this.program
  }) {
    program = program.toUpperCase();
  }

  final mnemonics = {
    "NOP":  TokenType.nop,
    "JUMP": TokenType.jump,
    "MOV":  TokenType.mov,
    "ADD":  TokenType.add,
  };

  final registers = [
    "R1", "R2", "R3", "R4",
    "R5", "R6", "R7", "R8"
  ];

  bool isWhiteSpaceChar(String character) {
    return character == " " || character == "\n" || character == "\t" || character == "\r";
  }

  List<Token> tokenize() {
    while (!isEnd()) {
      while (!isEnd() && isWhiteSpaceChar(program[current])) {
        current++;
      }

      final token = parseInstruction();
      tokens.add(token);

      current++;
    }

    for (var token in tokens) {
      print(token.toString());
    }
    
    return tokens;
  }

  Token parseInstruction() {
    return switch (program[current]) {
      var c when isLetter(c) => parseIdentifier(),
      var c when isDigit(c) => parseLiteral(),
      "." => Token(lexeme: ".", type: TokenType.dot),
      _ => Token(lexeme: program[current], type: TokenType.bad)
    };
  }

  Token parseLiteral() {
    int start = current;
    while (!isEnd() && isDigit(program[current])) {
      current++;
    }

    final lexeme = program.substring(start, current);

    return Token(lexeme: lexeme, type: TokenType.literal);
  }

  Token parseIdentifier() {
    int start = current;
    while (!isEnd() && (isLetter(program[current]) || isDigit(program[current]))) {
      current++;
    }

    final lexeme = program.substring(start, current);

    if (mnemonics.containsKey(lexeme)) {
      return Token(lexeme: lexeme, type: mnemonics[lexeme]!);
    }

    if (registers.contains(lexeme)) {
      return Token(lexeme: lexeme, type: TokenType.register);
    }

    return Token(lexeme: lexeme, type: TokenType.identifier);
  }

  bool isLetter(String character) {
    int code = character.toLowerCase().codeUnitAt(0);
    return code >= 97 && code <= 122;
  }

  bool isDigit(String character) {
    return int.tryParse(character) != null;
  }

  bool isEnd() {
    return current >= program.length;
  }
}