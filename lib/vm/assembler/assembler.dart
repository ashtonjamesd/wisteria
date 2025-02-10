import '../parser/token.dart';

final class Assembler {
  final List<Token> tokens;
  final List<int> codes = [];

  int current = 0;

  Assembler({
    required this.tokens
  });

  List<int> assemble() {
    while (current < tokens.length) {
      final code = translateToken();
      codes.add(code);

      current++;
    }

    return codes;
  }

  int translateToken() {
    final token = tokens[current];

    return switch (token.type) {
      TokenType.literal => translateLiteral(token),
      TokenType.register => translateRegister(token),
      TokenType.whitespace => 0,
      _ => translateMnemonic(token)
    };
  }

  int translateMnemonic(Token mnemonic) {
    return switch (mnemonic.type) {
      TokenType.mov => translateMov(),
      TokenType.add => 0x4,
      TokenType.inc => 0x5,
      TokenType.dec => 0x6,
      TokenType.mul => 0x8,
      TokenType.div => 0x9,
      TokenType.out => 0xff,
      _ => error("unknown register ${mnemonic.lexeme}")
    };
  }

  int translateMov() {
    current++;
    final next = peek();

    current--;
    return switch (next.type) {
      TokenType.register => 0x3,
      TokenType.literal  => 0x2,
      _ => error("invalid source for mov")
    };
  }

  int translateRegister(Token register) {
    return switch (register.lexeme) {
      "RAX" => 0x0,
      "RBX" => 0x1,
      "RCX" => 0x2,
      "RDX" => 0x3,
      _ => error("unknown register ${register.lexeme}")
    };
  }

  int translateLiteral(Token literal) {
    final val = int.parse(literal.lexeme);
    return val;
  }

  Token peek() {
    if (current + 1 >= tokens.length) {
      return Token(lexeme: "", type: TokenType.bad);
    }

    return tokens[current + 1];
  }

  int error(String message) {
    print(message);
    return -1;
  }
}