import '../../constants.dart';
import '../parser/token.dart';

final class Assembler {
  final List<Token> tokens;
  final List<int> codes = [];

  int current = 0;
  
  final Map<String, int> labels = {};

  Assembler({
    required this.tokens
  });

  void resolve() {
    while (!isEnd()) {
      final token = tokens[current];

      if (token.type == TokenType.identifier && peek().type == TokenType.colon) {
        labels[token.lexeme] = current;
      }

      advance();
    }
  }

  List<int> assemble() {
    resolve();
    // for (var x in labels.entries) print("${x.key}: ${x.value}");

    current = 0;

    while (!isEnd()) {
      final code = translateToken();
      codes.add(code);

      advance();
    }

    return codes;
  }

  int translateToken() {
    final token = tokens[current];

    return switch (token.type) {
      TokenType.literal => translateLiteral(token),
      TokenType.register => translateRegister(token),
      TokenType.identifier => translateIdentifier(token),
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
      TokenType.inc => 0xc,
      TokenType.dec => 0xd,
      TokenType.jump => 0xe,
      TokenType.out => 0xff,
      _ => error("unknown mnemonic ${mnemonic.lexeme}")
    };
  }

  int translateRegister(Token register) {
    return switch (register.lexeme) {
      "RAX" => RAX_INDEX,
      "RBX" => RBX_INDEX,
      "RCX" => RCX_INDEX,
      "RDX" => RDX_INDEX,
      _ => error("unknown register ${register.lexeme}")
    };
  }

  int translateIdentifier(Token token) {
    final next = peek();
    if (next.type == TokenType.colon) {
      return translateLabelDefinition();
    }

    final token = tokens[current];
    if (labels.containsKey(token.lexeme)) {
      return labels[token.lexeme]!;
    }

    return error("unknown identifier ${token.lexeme}");
  }

  int translateLabelDefinition() {
    advance();

    codes.add(LABEL_OP);
    return NO_OP;
  }

  int translateLiteral(Token literal) {
    final val = int.parse(literal.lexeme);
    return val;
  }

  int translateTwoOpInstruction(int literalCode, int registerCode) {
    advance();
    final next = peek();

    current--;

    return switch (next.type) {
      TokenType.literal  => literalCode,
      TokenType.register => registerCode,
      _ => error("invalid source for add")
    };
  }

  Token peek() {
    if (current + 1 >= tokens.length) {
      return Token(lexeme: "", type: TokenType.bad);
    }

    return tokens[current + 1];
  }

  void advance() {
    current++;
  }

  bool isEnd() {
    return current >= tokens.length;
  }

  int error(String message) {
    print(message);
    return UNKNOWN_OP;
  }
}