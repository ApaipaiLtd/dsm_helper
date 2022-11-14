import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:dsm_helper/widgets/terminal_button.dart';
import 'package:dsm_helper/widgets/virtual_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xterm/xterm.dart';

class Ssh extends StatefulWidget {
  final String host;
  final String port;
  final String username;
  final String password;
  Ssh(this.host, this.port, this.username, this.password);
  @override
  _SshState createState() => _SshState();
}

class _SshState extends State<Ssh> {
  final keyboard = VirtualKeyboard(defaultInputHandler);
  Terminal terminal = Terminal();
  String title = "终端";
  @override
  void initState() {
    initTerminal();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initTerminal() async {
    terminal = Terminal(inputHandler: keyboard);
    terminal.write('Connecting...\r\n');

    final client = SSHClient(
      await SSHSocket.connect(widget.host, int.parse(widget.port)),
      username: widget.username,
      onPasswordRequest: () => widget.password,
    );

    terminal.write('Connected\r\n');

    final session = await client.shell(
      pty: SSHPtyConfig(
        width: terminal.viewWidth,
        height: terminal.viewHeight,
      ),
    );

    terminal.buffer.clear();
    terminal.buffer.setCursor(0, 0);

    terminal.onTitleChange = (title) {
      setState(() => this.title = title);
    };

    terminal.onResize = (width, height, pixelWidth, pixelHeight) {
      session.resizeTerminal(width, height, pixelWidth, pixelHeight);
    };

    terminal.onOutput = (data) {
      session.write(utf8.encode(data) as Uint8List);
    };

    session.stdout.cast<List<int>>().transform(Utf8Decoder()).listen(terminal.write);

    session.stderr.cast<List<int>>().transform(Utf8Decoder()).listen(terminal.write);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppBackButton(
          context,
          color: Colors.black,
          iconColor: Colors.white.withOpacity(0.5),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              child: TerminalView(terminal),
              // onKey: (RawKeyEvent event) {
              //   if (event is RawKeyDownEvent) {
              //     RawKeyEventDataAndroid data = event.data as RawKeyEventDataAndroid;
              //     if (!_keyDownBuffer.contains(data.keyCode)) _keyDownBuffer.add(data.keyCode);
              //   } else if (event.runtimeType.toString() == "RawKeyUpEvent") {
              //     List<int> bytes;
              //     if (_keyDownBuffer.length == 1) {
              //       switch (_keyDownBuffer[0]) {
              //         case 19:
              //           bytes = [0x1b, 0x5b, 0x41];
              //           break; // arrow up
              //         case 20:
              //           bytes = [0x1b, 0x5b, 0x42];
              //           break; // arrow down
              //         case 21:
              //           bytes = [0x1b, 0x5b, 0x44];
              //           break; // arrow left
              //         case 22:
              //           bytes = [0x1b, 0x5b, 0x43];
              //           break; // arrow right
              //         case 61:
              //           bytes = [0x9];
              //           break; // tab
              //         case 67:
              //           bytes = [0x8];
              //           break; // backspace
              //       }
              //     } else if (_keyDownBuffer.length == 2) {
              //       switch (_keyDownBuffer[0]) {
              //         case 113: // Ctrl
              //           switch (_keyDownBuffer[1]) {
              //             case 29:
              //               bytes = [0x1];
              //               break; // A (start of heading)
              //             case 30:
              //               bytes = [0x2];
              //               break; // B (start of text)
              //             case 31:
              //               bytes = [0x3];
              //               break; // C (end of text)
              //             case 32:
              //               bytes = [0x4];
              //               break; // D (end of xmit)
              //             case 33:
              //               bytes = [0x5];
              //               break; // E (enquiry)
              //             case 34:
              //               bytes = [0x6];
              //               break; // F (acknowledge)
              //             case 35:
              //               bytes = [0x7];
              //               break; // G (bell)
              //             case 36:
              //               bytes = [0x8];
              //               break; // H (backspace)
              //             case 37:
              //               bytes = [0x9];
              //               break; // I (horizontal tab)
              //             case 38:
              //               bytes = [0x10];
              //               break; // J (line feed)
              //             case 39:
              //               bytes = [0x11];
              //               break; // K (vertical tab)
              //             case 40:
              //               bytes = [0x12];
              //               break; // L (form feed)
              //             case 41:
              //               bytes = [0x13];
              //               break; // M (carriage feed)
              //             case 42:
              //               bytes = [0x14];
              //               break; // N (shift out)
              //             case 43:
              //               bytes = [0x15];
              //               break; // O (shift in)
              //             case 44:
              //               bytes = [0x16];
              //               break; // P (data line escape)
              //             case 45:
              //               bytes = [0x17];
              //               break; // Q (device control 1)
              //             case 46:
              //               bytes = [0x18];
              //               break; // R (device control 2)
              //             case 47:
              //               bytes = [0x19];
              //               break; // S (device control 3)
              //             case 48:
              //               bytes = [0x20];
              //               break; // T (device control 4)
              //             case 49:
              //               bytes = [0x21];
              //               break; // U (neg acknowledge)
              //             case 50:
              //               bytes = [0x22];
              //               break; // V (synchronous idel)
              //             case 51:
              //               bytes = [0x23];
              //               break; // W (end of xmit block)
              //             case 52:
              //               bytes = [0x18];
              //               break; // X (cancel)
              //             case 53:
              //               bytes = [0x19];
              //               break; // Y (end of medium)
              //             case 54:
              //               bytes = [0x1a];
              //               break; // Z (substitute)
              //           }
              //           break;
              //       }
              //     }
              //     // send to serial
              //     _keyDownBuffer.clear();
              //     // terminal.write(Uint8List.fromList(bytes));
              //   }
              // },
            ),
          ),
          // VirtualKeyboardView(keyboard)
          // Container(
          //   color: Colors.black,
          //   padding: EdgeInsets.symmetric(horizontal: 10),
          //   child: SafeArea(
          //     child: DefaultTextStyle(
          //       style: TextStyle(color: Colors.white.withOpacity(0.5)),
          //       child: Column(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Row(
          //             children: [
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(String.fromCharCode(0x1b));
          //                 },
          //                 child: Text("ESC"),
          //               ),
          //               SizedBox(
          //                 width: 40,
          //               ),
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x1b, 0x5b, 0x41]));
          //                 },
          //                 child: Icon(
          //                   Icons.keyboard_arrow_up,
          //                   color: Colors.white.withOpacity(0.5),
          //                 ),
          //               ),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x9]));
          //                 },
          //                 child: Text("TAB"),
          //               ),
          //               // 左
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x1b, 0x5b, 0x44]));
          //                 },
          //                 child: Icon(
          //                   Icons.keyboard_arrow_left,
          //                   color: Colors.white.withOpacity(0.5),
          //                 ),
          //               ),
          //               //下
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x1b, 0x5b, 0x42]));
          //                 },
          //                 child: Icon(
          //                   Icons.keyboard_arrow_down,
          //                   color: Colors.white.withOpacity(0.5),
          //                 ),
          //               ),
          //               // 右
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x1b, 0x5b, 0x43]));
          //                 },
          //                 child: Icon(
          //                   Icons.keyboard_arrow_right,
          //                   color: Colors.white.withOpacity(0.5),
          //                 ),
          //               ),
          //               TerminalButton(
          //                 onPressed: () {
          //                   backend.write(Uint8List.fromList([0x02]));
          //                 },
          //                 child: Icon(
          //                   Icons.keyboard_arrow_down,
          //                   color: Colors.white.withOpacity(0.5),
          //                 ),
          //               ),
          //             ],
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
