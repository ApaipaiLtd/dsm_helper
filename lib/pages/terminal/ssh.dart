import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:dsm_helper/widgets/terminal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/xterm.dart';
import 'package:dartssh/client.dart';

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
  Terminal terminal;
  SSHTerminalBackend backend;
  List<int> _keyDownBuffer = [];
  FocusNode _terminalFocus = FocusNode();
  bool hasFocus = false;
  @override
  void initState() {
    backend = SSHTerminalBackend("http://${widget.host}:${widget.port}", widget.username, widget.password);
    terminal = Terminal(backend: backend, maxLines: 10000);
    _terminalFocus.addListener(() {
      hasFocus = _terminalFocus.hasFocus;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          "终端",
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
        ),
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              child: TerminalView(
                terminal: terminal,
                focusNode: _terminalFocus,
              ),
              onKey: (RawKeyEvent event) {
                if (event is RawKeyDownEvent) {
                  RawKeyEventDataAndroid data = event.data as RawKeyEventDataAndroid;
                  if (!_keyDownBuffer.contains(data.keyCode)) _keyDownBuffer.add(data.keyCode);
                } else if (event.runtimeType.toString() == "RawKeyUpEvent") {
                  List<int> bytes;
                  if (_keyDownBuffer.length == 1) {
                    switch (_keyDownBuffer[0]) {
                      case 19:
                        bytes = [0x1b, 0x5b, 0x41];
                        break; // arrow up
                      case 20:
                        bytes = [0x1b, 0x5b, 0x42];
                        break; // arrow down
                      case 21:
                        bytes = [0x1b, 0x5b, 0x44];
                        break; // arrow left
                      case 22:
                        bytes = [0x1b, 0x5b, 0x43];
                        break; // arrow right
                      case 61:
                        bytes = [0x9];
                        break; // tab
                      case 67:
                        bytes = [0x8];
                        break; // backspace
                    }
                  } else if (_keyDownBuffer.length == 2) {
                    switch (_keyDownBuffer[0]) {
                      case 113: // Ctrl
                        switch (_keyDownBuffer[1]) {
                          case 29:
                            bytes = [0x1];
                            break; // A (start of heading)
                          case 30:
                            bytes = [0x2];
                            break; // B (start of text)
                          case 31:
                            bytes = [0x3];
                            break; // C (end of text)
                          case 32:
                            bytes = [0x4];
                            break; // D (end of xmit)
                          case 33:
                            bytes = [0x5];
                            break; // E (enquiry)
                          case 34:
                            bytes = [0x6];
                            break; // F (acknowledge)
                          case 35:
                            bytes = [0x7];
                            break; // G (bell)
                          case 36:
                            bytes = [0x8];
                            break; // H (backspace)
                          case 37:
                            bytes = [0x9];
                            break; // I (horizontal tab)
                          case 38:
                            bytes = [0x10];
                            break; // J (line feed)
                          case 39:
                            bytes = [0x11];
                            break; // K (vertical tab)
                          case 40:
                            bytes = [0x12];
                            break; // L (form feed)
                          case 41:
                            bytes = [0x13];
                            break; // M (carriage feed)
                          case 42:
                            bytes = [0x14];
                            break; // N (shift out)
                          case 43:
                            bytes = [0x15];
                            break; // O (shift in)
                          case 44:
                            bytes = [0x16];
                            break; // P (data line escape)
                          case 45:
                            bytes = [0x17];
                            break; // Q (device control 1)
                          case 46:
                            bytes = [0x18];
                            break; // R (device control 2)
                          case 47:
                            bytes = [0x19];
                            break; // S (device control 3)
                          case 48:
                            bytes = [0x20];
                            break; // T (device control 4)
                          case 49:
                            bytes = [0x21];
                            break; // U (neg acknowledge)
                          case 50:
                            bytes = [0x22];
                            break; // V (synchronous idel)
                          case 51:
                            bytes = [0x23];
                            break; // W (end of xmit block)
                          case 52:
                            bytes = [0x18];
                            break; // X (cancel)
                          case 53:
                            bytes = [0x19];
                            break; // Y (end of medium)
                          case 54:
                            bytes = [0x1a];
                            break; // Z (substitute)
                        }
                        break;
                    }
                  }
                  // send to serial
                  _keyDownBuffer.clear();
                  backend.write(Uint8List.fromList(bytes));
                }
              },
            ),
          ),
          Container(
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
                            backend.write(String.fromCharCode(0x1b));
                          },
                          child: Text("ESC"),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        TerminalButton(
                          onPressed: () {
                            backend.write(Uint8List.fromList([0x1b, 0x5b, 0x41]));
                          },
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TerminalButton(
                          onPressed: () {
                            backend.write(Uint8List.fromList([0x9]));
                          },
                          child: Text("TAB"),
                        ),
                        TerminalButton(
                          onPressed: () {
                            backend.write(Uint8List.fromList([0x1b, 0x5b, 0x44]));
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        TerminalButton(
                          onPressed: () {
                            backend.write(Uint8List.fromList([0x1b, 0x5b, 0x42]));
                          },
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        TerminalButton(
                          onPressed: () {
                            backend.write(Uint8List.fromList([0x1b, 0x5b, 0x43]));
                          },
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SSHTerminalBackend extends TerminalBackend {
  SSHClient client;

  String _host;
  String _username;
  String _password;

  Completer<int> _exitCodeCompleter;
  StreamController<String> _outStream;

  SSHTerminalBackend(this._host, this._username, this._password);

  void onWrite(String data) {
    _outStream.sink.add(data);
  }

  @override
  Future<int> get exitCode => _exitCodeCompleter.future;

  @override
  void init() {
    _exitCodeCompleter = Completer<int>();
    _outStream = StreamController<String>();

    onWrite('connecting $_host...\r\n');
    client = SSHClient(
      hostport: Uri.parse(_host),
      login: _username,
      print: print,
      termWidth: 80,
      termHeight: 25,
      termvar: 'xterm-256color',
      getPassword: () => utf8.encode(_password),
      response: (transport, data) {
        onWrite(data);
      },
      success: () {
        onWrite('connected.\r\n');
      },
      disconnected: () {
        onWrite('disconnected.');
        _outStream.close();
      },
    );
  }

  @override
  Stream<String> get out => _outStream.stream;

  @override
  void resize(int width, int height, int pixelWidth, int pixelHeight) {
    client.setTerminalWindowSize(width, height);
  }

  @override
  void write(dynamic input) {
    if (input is String) {
      client?.sendChannelData(utf8.encode(input));
    } else {
      client?.sendChannelData(input);
    }
  }

  @override
  void terminate() {
    client?.disconnect('terminate');
  }

  @override
  void ackProcessed() {
    // NOOP
  }
}
