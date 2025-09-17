import 'dart:async';
import 'package:flutter/material.dart';

class TypingTextWidget extends StatefulWidget {
  final List<String> texts;
  final TextStyle textStyle;
  final Duration speed;
  final Duration pause;

  const TypingTextWidget({
    Key? key,
    required this.texts,
    required this.textStyle,
    this.speed = const Duration(milliseconds: 80),
    this.pause = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _TypingTextWidgetState createState() => _TypingTextWidgetState();
}

class _TypingTextWidgetState extends State<TypingTextWidget> {
  int _textIndex = 0;
  String _currentText = "";
  int _charIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.speed, (timer) {
      if (_charIndex < widget.texts[_textIndex].length) {
        setState(() {
          _currentText += widget.texts[_textIndex][_charIndex];
          _charIndex++;
        });
      } else {
        timer.cancel();
        Future.delayed(widget.pause, () {
          setState(() {
            _textIndex = (_textIndex + 1) % widget.texts.length;
            _currentText = "";
            _charIndex = 0;
          });
          _startTyping();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: widget.textStyle,
    );
  }
}