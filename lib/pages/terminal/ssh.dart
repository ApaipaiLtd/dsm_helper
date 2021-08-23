import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dsm_helper/widgets/neu_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xterm/buffer/buffer.dart';
import 'package:xterm/flutter.dart';
import 'package:xterm/theme/terminal_themes.dart';
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
  @override
  void initState() {
    backend = SSHTerminalBackend("http://${widget.host}:${widget.port}",
        widget.username, widget.password);
    terminal = Terminal(backend: backend, maxLines: 10000);
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
          iconColor: Colors.white,
        ),
        title: Text(
          "终端",
          style: TextStyle(color: Colors.white),
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
              ),
              onKey: (RawKeyEvent event) {
                if (event is RawKeyDownEvent) {
                  RawKeyDownEvent rawKeyDownEvent = event;
                  if (rawKeyDownEvent.data is RawKeyEventDataAndroid) {
                    RawKeyEventDataAndroid rawKeyEventDataAndroid =
                        rawKeyDownEvent.data;
                    if (rawKeyEventDataAndroid.keyCode == 67) {
                      backend.write("\b \b");
                    }
                  }
                }
              },
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  backend.write("\t \t");
                },
                child: Text("Tab"),
              ),
              TextButton(
                onPressed: () {
                  backend.write(Uint8List.fromList([0x1b, 0x5b, 0x44]));
                },
                child: Text("←"),
              ),
              TextButton(
                onPressed: () {
                  backend.write(Uint8List.fromList([0x1b, 0x5b, 0x43]));
                },
                child: Text("→"),
              ),
            ],
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
