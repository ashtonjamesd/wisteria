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
      TokenType.mov => translateTwoOpInstruction(0x2, 0x3),
      TokenType.add => translateTwoOpInstruction(0x4, 0x5),
      TokenType.sub => translateTwoOpInstruction(0x6, 0x7),
      TokenType.mul => translateTwoOpInstruction(0x8, 0x9),
      TokenType.div => translateTwoOpInstruction(0xa, 0xb),
      TokenType.inc => 0x5,
      TokenType.dec => 0x6,
      TokenType.out => 0xff,
      _ => error("unknown register ${mnemonic.lexeme}")
    };
  }

  int translateTwoOpInstruction(int literalCode, int registerCode) {
    current++;
    final next = peek();

    current--;

    return switch (next.type) {
      TokenType.literal  => literalCode,
      TokenType.register => registerCode,
      _ => error("invalid source for add")
    };
  }

  int translateSub() {
    return -1;
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