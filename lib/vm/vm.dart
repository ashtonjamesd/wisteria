import 'package:wisteria/constants.dart';

final class VirtualMachine {
  // machine code to be executed
  final List<int> program;

  // memory for the virtual machine
  late final List<int> memory;

  // cpu registers
  late final List<int> registers;

  // program counter
  int pc = 0;

  // instruction register
  int ir = 0;

  // sign flag
  bool sf = false;

  // zero flag
  bool zf = false;

  // parity flag
  bool pf = false;

  // execution flag for the virtual machine
  bool _running = true;

  // instruction set architecture
  late final Map<int, Function> isa;

  int get _rax => registers[RAX_INDEX];
  set _rax(int value) => registers[RAX_INDEX] = value;

  int get _rbx => registers[RBX_INDEX];
  set _rbx(int value) => registers[RBX_INDEX] = value;

  int get _rcx => registers[RCX_INDEX];
  set _rcx(int value) => registers[RCX_INDEX] = value;

  int get _rdx => registers[RDX_INDEX];
  set _rdx(int value) => registers[RDX_INDEX] = value;

  VirtualMachine({required this.program}) {
    isa = {
      HLT_OP: _hlt,
      NO_OP: _nop,
      MOV_LIT_OP: _movLiteral,
      MOV_REG_OP: _movRegister,
      ADD_LIT_OP: _addLiteral,
      ADD_REG_OP: _addRegister,
      SUB_LIT_OP: _subLiteral,
      SUB_REG_OP: _subRegister,
      MUL_LIT_OP: _mulLiteral,
      MUL_REG_OP: _mulRegister,
      DIV_LIT_OP: _divLiteral,
      DIV_REG_OP: _divRegister,
      INC_OP: _inc,
      DEC_OP: _dec,
      JUMP_OP: _jump,
      CMP_LIT_LIT_OP: _cmpLitLit,
      OUT_OP: _out
    };

    memory = List.filled(256, 0);
    registers = List.filled(8, 0);
  }

  Future run() async {
    _load();

    while (_running) {
      _execute();
      await Future.delayed(const Duration(milliseconds: 250));

      pc++;
    }

    _running = false;

    print("program execution finished");
  }

  void _load() {
    for (int i = 0; i < program.length; i++) {
      memory[i] = program[i];
    }
  }

  void _execute() {
    ir = memory[pc++];

    if (!isa.containsKey(ir)) {
      print("unknown opcode: $ir");
      return;
    }

    final instruction = isa[ir]!;
    instruction();
  }

  void _out() {
    print(registers[memory[pc]]);
  }

  void _addLiteral() {
    final destination = memory[pc++];
    final literal = memory[pc];

    registers[destination] += literal;
  }

  void _addRegister() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] += registers[source];
  }

  void _subLiteral() {
    final destination = memory[pc++];
    final literal = memory[pc];

    registers[destination] -= literal;
  }

  void _subRegister() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] -= registers[source];
  }

  void _mulLiteral() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] *= source;
  }

  void _mulRegister() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] *= registers[source];
  }

  /// divides the value of rax by the given argument
  ///   - stores the division result in rax
  ///   - stores the remainder inb rbx
  void _divLiteral() {
    final divisor = memory[pc];

    final divisionResult = (_rax / divisor).floor();
    final remainder = _rax % divisor;

    _rax = divisionResult;
    _rbx = remainder;
  }

  void _divRegister() {
    final register = memory[pc];
    final divisor = registers[register];

    final divisionResult = (_rax / divisor).floor();
    final remainder = _rax % divisor;

    _rax = divisionResult;
    _rbx = remainder;
  }

  void _inc() {
    final register = memory[pc];
    registers[register]++;

  }

  void _dec() {
    final register = memory[pc];
    registers[register]--;
  }

  void _jump() {
    final destination = memory[pc];
    pc = destination;
  }

  void _cmpLitLit() {
    final a = memory[pc++];
    final b = memory[pc++];

    zf = a == b;
  }

  void _movLiteral() {
    final register = memory[pc++];
    final literal = memory[pc];

    registers[register] = literal;
  }

  void _movRegister() {
    final register = memory[pc++];
    final moveFromRegister = memory[pc];

    registers[register] = registers[moveFromRegister];
  }

  void _hlt() {
    _running = false;
  }

  void _nop() {
    // this is used as a location to jump to when a label is found
    pc--;
  }
}