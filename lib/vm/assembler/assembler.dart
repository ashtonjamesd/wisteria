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

    final code = switch (token.type) {
      TokenType.literal => translateLiteral(token),
      TokenType.register => translateRegister(token),
      _ => translateMnemonic(token)
    };

    return code;
  }

  int translateMnemonic(Token mnemonic) {
      final code = switch (mnemonic.type) {
        TokenType.mov => 0x2,
        TokenType.out => 0x3,
        TokenType.add => 0x4,
        _ => error("unknown register ${mnemonic.lexeme}")
      };

      return code;
  }

  int translateRegister(Token register) {
    final code = switch (register.lexeme) {
      "RAX" => 0x1,
      "RBX" => 0x2,
      "RCX" => 0x3,
      "RDX" => 0x4,
      _ => error("unknown register ${register.lexeme}")
    };

    return code;
  }

  int translateLiteral(Token literal) {
    final val = int.parse(literal.lexeme);
    return val;
  }

  int error(String message) {
    print(message);
    return -1;
  }
}