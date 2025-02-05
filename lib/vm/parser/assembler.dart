import 'token.dart';

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
        TokenType.mov => 2,
        _ => -1 // unknown mnemonic
      };

      return code;
  }

  int translateRegister(Token register) {
    final code = switch (register.lexeme) {
      "RAX" => 1,
      _ => -1 // unknown register
    };

    return code;
  }

  int translateLiteral(Token literal) {
    final val = int.parse(literal.lexeme);
    return val;
  }
}