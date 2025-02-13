import 'package:flutter/material.dart';
import 'package:wisteria/app/constants.dart';

class StackCodeEditor extends StatefulWidget {
  const StackCodeEditor({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<StackCodeEditor> createState() => _StackCodeEditorState();
}

class _StackCodeEditorState extends State<StackCodeEditor> {
  late ScrollController _scrollController;
  late TextEditingController _lineNumberController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _lineNumberController = TextEditingController();

    _updateLineNumbers();

    widget.controller.addListener(_updateLineNumbers);
  }

  void _updateLineNumbers() {
    final lines = widget.controller.text.split('\n').length;
    
    _lineNumberController.text = List.generate(lines, (index) => (index + 1).toString())
        .join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          height: screen.height * 0.7,
          width: screen.width * 0.8,
          decoration: BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.circular(boxBorderRadius),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          width: 60,
                          padding: const EdgeInsets.all(8.0),
                          color: primaryWhite,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: TextField(
                              textAlign: TextAlign.right,
                              controller: _lineNumberController,
                              readOnly: true,
                              maxLines: null,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: TextField(
                              controller: widget.controller,
                              maxLines: null,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(8.0),
                                isDense: true,
                                hintText: 'write code here..',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: primaryGrey
                                )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(
                  "assembly editor",
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}