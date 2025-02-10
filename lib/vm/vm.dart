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
      0x02: _movLiteral,
      0x03: _movRegister,
      0x04: _addLiteral,
      0x05: _addRegister,
      0x06: _subLiteral,
      0x07: _subRegister,
      0x08: _mulLiteral,
      0x09: _mulRegister,
      0x0a: _divLiteral,
      0x0b: _divRegister,
      0x0c: _inc,
      0x0d: _dec,
      0x0e: _jump,
      0x14: _label,
      0xff: _out
    };

    memory = List.filled(256, 0);
    registers = List.filled(8, 0);
  }

  Future run() async {
    _load();

    while (_running) {
      _execute();
      await Future.delayed(const Duration(seconds: 1));

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
      print("unknown key: $ir");
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
    pc = destination + 1;
  }

  void _label() {
    pc += 2;
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
  }
}