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

  int get _rax => registers[0];
  set _rax(int value) => registers[0] = value;

  int get _rbx => registers[1];
  set _rbx(int value) => registers[1] = value;

  int get _rcx => registers[2];
  set _rcx(int value) => registers[2] = value;

  int get _rdx => registers[3];
  set _rdx(int value) => registers[3] = value;

  VirtualMachine({required this.program}) {
    isa = {
      0x00: _hlt,
      0x01: _nop,
      0x02: _movLiteral,
      0x03: _movRegister,
      0x04: _add,
      0x05: _sub,
      0x06: _inc,
      0x07: _dec,
      0x08: _mul,
      0x09: _div,

      0xff: _out
    };

    memory = List.filled(256, 0);
    registers = List.filled(8, 0);
  }

  void run() {
    _load();

    while (_running) {
      _execute();

      pc++;
    }

    _running = false;
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

  void _add() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] += registers[source];
  }

  void _sub() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] -= registers[source];
  }

  void _mul() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] *= registers[source];
  }

  void _div() {
    final divisor = memory[pc];

    final divisionResult = (_rax / divisor).floor();
    final remainder = _rax % divisor;

    _rax = divisionResult;
    _rbx = remainder;
  }

  void _inc() {
    final register = memory[pc++];
    registers[register]++;
  }

  void _dec() {
    final register = memory[pc++];
    registers[register]--;
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