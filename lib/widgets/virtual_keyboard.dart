import 'package:flutter/material.dart';
import 'package:xterm/xterm.dart';

import 'terminal_button.dart';

class VirtualKeyboardView extends StatefulWidget {
  const VirtualKeyboardView(this.keyboard, this.terminal, {key}) : super(key: key);

  final VirtualKeyboard keyboard;
  final Terminal terminal;

  @override
  State<VirtualKeyboardView> createState() => _VirtualKeyboardViewState();
}

class _VirtualKeyboardViewState extends State<VirtualKeyboardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: SafeArea(
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.escape);
                    },
                    child: Text("ESC"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.onOutput('/');
                    },
                    child: Text("/"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.arrowUp);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Spacer(),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.home);
                    },
                    child: Text(
                      "INS",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.insert);
                    },
                    child: Text(
                      "HOME",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.pageUp);
                    },
                    child: Text(
                      "PGUP",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.tab);
                    },
                    child: Text("TAB"),
                  ),
                  // 左
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.arrowLeft);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  // //下
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.arrowDown);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  // // 右
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.arrowRight);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  Spacer(),
                  TerminalButton(
                    onPressed: () {
                      setState(() {
                        widget.keyboard.ctrl = !widget.keyboard.ctrl;
                      });
                    },
                    active: widget.keyboard.ctrl,
                    child: Text("Ctrl"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      setState(() {
                        widget.keyboard.alt = !widget.keyboard.alt;
                      });
                    },
                    active: widget.keyboard.alt,
                    child: Text("Alt"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      setState(() {
                        widget.keyboard.shift = !widget.keyboard.shift;
                      });
                    },
                    active: widget.keyboard.shift,
                    child: Text("Shift"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.delete);
                    },
                    child: Text("DEL"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.end);
                    },
                    child: Text("END"),
                  ),
                  TerminalButton(
                    onPressed: () {
                      widget.terminal.keyInput(TerminalKey.pageDown);
                    },
                    child: Text(
                      "PGDN",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VirtualKeyboard extends TerminalInputHandler with ChangeNotifier {
  final TerminalInputHandler _inputHandler;

  VirtualKeyboard(this._inputHandler);

  bool _ctrl = false;

  bool get ctrl => _ctrl;

  set ctrl(bool value) {
    if (_ctrl != value) {
      _ctrl = value;
      notifyListeners();
    }
  }

  bool _shift = false;

  bool get shift => _shift;

  set shift(bool value) {
    if (_shift != value) {
      _shift = value;
      notifyListeners();
    }
  }

  bool _alt = false;

  bool get alt => _alt;

  set alt(bool value) {
    if (_alt != value) {
      _alt = value;
      notifyListeners();
    }
  }

  @override
  String call(TerminalKeyboardEvent event) {
    return _inputHandler.call(event.copyWith(
      ctrl: event.ctrl || _ctrl,
      shift: event.shift || _shift,
      alt: event.alt || _alt,
    ));
  }
}
