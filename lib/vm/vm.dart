final class VirtualMachine {
  // machine code to be executed
  final List<int> program;

  // memory for the virtual machine
  late final List<int> memory;

  // cpu registers
  late final List<int> registers;

  // program counter
  int pc = 0;

  // memory address register
  int mar = 0;

  // memory data register
  int mdr = 0;

  // current instruction register
  int cir = 0;

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
    mar = pc;
    mdr = memory[mar];

    cir = mdr;

    final opcode = cir >> 4;

    final instruction = isa[opcode]!;
    instruction();
  }

  void _hlt() {
    _running = false;
  }

  void _nop() {
    // this is used as a location to jump to when a label is found
  }
}