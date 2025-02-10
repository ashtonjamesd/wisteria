import '../constants.dart';
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
      TokenType.halt => HLT_OP,
      TokenType.nop => NO_OP,
      TokenType.mov => translateTwoOpInstruction(MOV_LIT_OP, MOV_REG_OP),
      TokenType.add => translateTwoOpInstruction(ADD_LIT_OP, ADD_REG_OP),
      TokenType.sub => translateTwoOpInstruction(SUB_LIT_OP, SUB_REG_OP),
      TokenType.mul => translateTwoOpInstruction(MUL_LIT_OP, MUL_REG_OP),
      TokenType.div => translateTwoOpInstruction(DIV_LIT_OP, DIV_REG_OP),
      TokenType.inc => INC_OP,
      TokenType.dec => DEC_OP,
      TokenType.jump => JUMP_OP,
      // temporarily
      TokenType.cmp => translateTwoOpInstruction(CMP_LIT_LIT_OP, CMP_LIT_LIT_OP),
      TokenType.jne => JNE_OP,
      TokenType.je => JE_OP,
      TokenType.neg => NEG_OP,
      TokenType.and => AND_OP,
      TokenType.or => OR_OP,
      TokenType.xor => XOR_OP,
      TokenType.not => NOT_OP,
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