import 'dart:async';
import 'package:flutter/material.dart';

class TypingTextWidget extends StatefulWidget {
  final List<String> texts;
  final TextStyle textStyle;
  final Duration speed;
  final Duration pause;
  final String cursor;
  final Color cursorColor;

  const TypingTextWidget({
    Key? key,
    required this.texts,
    required this.textStyle,
    this.speed = const Duration(milliseconds: 80),
    this.pause = const Duration(milliseconds: 1000),
    this.cursor = '|',
    this.cursorColor = Colors.black,
  }) : super(key: key);

  @override
  _TypingTextWidgetState createState() => _TypingTextWidgetState();
}

class _TypingTextWidgetState extends State<TypingTextWidget> {
  int _textIndex = 0;
  String _currentText = "";
  int _charIndex = 0;
  Timer? _typingTimer;
  Timer? _cursorTimer;
  bool _showCursor = true;

  @override
  void initState() {
    super.initState();
    _startTyping();
    _startCursorBlink();
  }

  void _startTyping() {
    _typingTimer = Timer.periodic(widget.speed, (timer) {
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

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _showCursor = !_showCursor;
      });
    });
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _currentText,
            style: widget.textStyle,
          ),
          if (_showCursor)
            TextSpan(
              text: widget.cursor,
              style: widget.textStyle.copyWith(color: widget.cursorColor),
            ),
        ],
      ),
    );
  }
}