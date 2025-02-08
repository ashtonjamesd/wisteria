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

  VirtualMachine({required this.program}) {
    isa = {
      0x00: _hlt,
      0x01: _nop,
      0x02: _movLiteral,
      0x03: _movRegister,
      0x04: _add,
      0x05: _inc,
      0x06: _dec,
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
    print(registers[memory[pc++]]);
  }

  void _add() {
    final destination = memory[pc++];
    final source = memory[pc];

    registers[destination] += registers[source];
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