import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dartssh2/dartssh2.dart';
import 'package:dsm_helper/widgets/neu_back_button.dart';
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
    setState(() {
      title = "${widget.username}@${widget.host}:${widget.port}";
    });
    terminal.write('Connecting to ${widget.username}@${widget.host}:${widget.port}\r\n');

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
      print(title);
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
            child: TerminalView(terminal),
          ),
          VirtualKeyboardView(keyboard, terminal),
        ],
      ),
    );
  }
}
