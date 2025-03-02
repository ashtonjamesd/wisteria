import 'package:wisteria/vm/constants.dart';

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
    "OUT":  TokenType.out,
    "ADD":  TokenType.add,
    "SUB":  TokenType.sub,
    "INC":  TokenType.inc,
    "DEC":  TokenType.dec,
    "MUL":  TokenType.mul,
    "DIV":  TokenType.div,
    "HALT": TokenType.halt,
    "CMP":  TokenType.cmp,
    "JNE":  TokenType.jne,
    "JE":   TokenType.je,
    "JLE":  TokenType.jle,
    "JL":   TokenType.jl,
    "JG":   TokenType.jg,
    "JGE":  TokenType.jge,
    "NEG":  TokenType.neg,
    "AND":  TokenType.and,
    "OR":   TokenType.or,
    "XOR":  TokenType.xor,
    "NOT":  TokenType.not,
    "STORE": TokenType.store,
    "LOAD": TokenType.load,
    "WAIT": TokenType.wait,
  };

  final symbolMap = {
    ".": TokenType.dot,
    ":": TokenType.colon,
    ";": TokenType.semicolon,
  };

  final keywords = {
    "ALLOC": TokenType.alloc,
    "SEGMENT": TokenType.segment
  };

  final registers = [
    R1_NAME,
    R2_NAME,
    R3_NAME,
    R4_NAME,
  ];

  List<Token> tokenize() {
    while (!isEnd()) {
      while (!isEnd() && isWhiteSpaceChar(program[current])) {
        // if (program[current] == '\n') {
        //   tokens.add(Token(lexeme: "", type: TokenType.whitespace));
        // }

        advance();
      }

      if (isEnd()) {
        break;
      }

      final token = parseInstruction();
      tokens.add(token);

      advance();
    }
    
    return tokens;
  }

  Token parseInstruction() {
    return switch (program[current]) {
      var c when isLetter(c) => parseIdentifier(),
      var c when isDigit(c) => parseNumeric(),
      "\"" => parseString(),
      _ => parseSymbol()
    };
  }

  Token parseSymbol() {
    final symbol = program[current];
    if (symbolMap.containsKey(symbol)) {
      return Token(lexeme: symbol, type: symbolMap[symbol]!);
    }

    return Token(lexeme: program[current], type: TokenType.bad);
  }

  Token parseString() {
    advance();

    int start = current;
    while (!isEnd() && program[current] != "\"") {
      advance();
    }

    current--;
    final lexeme = program.substring(start, current++);

    return Token(lexeme: lexeme, type: TokenType.string);
  }

  Token parseNumeric() {
    int start = current;
    while (!isEnd() && isDigit(program[current])) {
      advance();
    }

    final lexeme = program.substring(start, current);

    current--;
    return Token(lexeme: lexeme, type: TokenType.literal);
  }

  Token parseIdentifier() {
    int start = current;
    while (!isEnd() && (isLetter(program[current]) || isDigit(program[current]))) {
      advance();
    }

    final lexeme = program.substring(start, current);
    current--;

    if (mnemonics.containsKey(lexeme)) {
      return Token(lexeme: lexeme, type: mnemonics[lexeme]!);
    }

    if (registers.contains(lexeme)) {
      return Token(lexeme: lexeme, type: TokenType.register);
    }

    if (keywords.containsKey(lexeme)) {
      return Token(lexeme: lexeme, type: keywords[lexeme]!);
    }

    return Token(lexeme: lexeme, type: TokenType.identifier);
  }

  bool isWhiteSpaceChar(String character) {
    return character == " " || character == "\n" || 
      character == "\t" || character == "\r";
  }

  bool isLetter(String character) {
    int code = character.toLowerCase().codeUnitAt(0);
    return code >= 97 && code <= 122;
  }

  bool isDigit(String character) {
    return int.tryParse(character) != null;
  }

  void advance() {
    current++;
  }

  bool isEnd() {
    return current >= program.length;
  }
}