import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  final List<String> texts;
  final Duration typingDuration;
  final Duration pauseDuration;
  final Duration eraseDuration;
  final TextStyle? style;
  final TextAlign textAlign;

  const TypingAnimation({
    super.key,
    required this.texts,
    this.typingDuration = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(milliseconds: 1500),
    this.eraseDuration = const Duration(milliseconds: 50),
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _currentTextIndex = 0;
  int _currentLength = 0;
  bool _isTyping = true;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.typingDuration,
    )..addListener(_updateText);

    _startTyping();
  }

  void _startTyping() {
    // ✅ FIX: Prevent any action if the widget is disposed
    if (!mounted) return;

    final currentText = widget.texts[_currentTextIndex];

    if (_isTyping && _currentLength < currentText.length) {
      // Typing forward
      _controller.duration = widget.typingDuration;
      _controller.forward(from: 0);
    } else if (_isTyping && _currentLength == currentText.length) {
      // Pause after typing complete
      _isTyping = false;
      Future.delayed(widget.pauseDuration, () {
        // ✅ FIX: Check if mounted before calling setState
        if (mounted) {
          setState(() {
            _isDeleting = true;
          });
          _startErasing();
        }
      });
    } else if (_isDeleting && _currentLength > 0) {
      // Deleting text
      _controller.duration = widget.eraseDuration;
      _controller.forward(from: 0);
    } else if (_isDeleting && _currentLength == 0) {
      // Move to next text after deleting complete
      _isDeleting = false;
      Future.delayed(const Duration(milliseconds: 500), () {
        // ✅ FIX: Check if mounted before proceeding
        if (mounted) {
          setState(() {
            _currentTextIndex = (_currentTextIndex + 1) % widget.texts.length;
            _isTyping = true;
          });
          _startTyping();
        }
      });
    }
  }

  void _startErasing() {
    _startTyping();
  }

  void _updateText() {
    if (_controller.status == AnimationStatus.completed) {
      // ✅ FIX: Check if mounted before calling setState
      if (mounted) {
        setState(() {
          if (_isTyping) {
            _currentLength++;
          } else if (_isDeleting) {
            _currentLength--;
          }
        });
        _controller.reset();
        _startTyping();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentText = widget.texts[_currentTextIndex];
    // Ensure substring does not fail if state changes unexpectedly
    final displayLength = _currentLength.clamp(0, currentText.length);
    final displayText = currentText.substring(0, displayLength);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayText,
          style: widget.style,
          textAlign: widget.textAlign,
        ),
        // This is the blinking cursor
        AnimatedOpacity(
          // Logic for cursor visibility
          opacity: _controller.isAnimating ? 1.0 : (_isTyping ? 1.0 : 0.0),
          duration: const Duration(milliseconds: 150),
          child: Text(
            '|',
            style: widget.style,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // The animation controller listener is automatically removed,
    // but stopping the controller is good practice.
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }
}


/*
import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  final List<String> texts;
  final Duration typingDuration;
  final Duration pauseDuration;
  final Duration eraseDuration;
  final TextStyle? style;
  final TextAlign textAlign;

  const TypingAnimation({
    super.key,
    required this.texts,
    this.typingDuration = const Duration(milliseconds: 100),
    this.pauseDuration = const Duration(milliseconds: 1500),
    this.eraseDuration = const Duration(milliseconds: 50),
    this.style,
    this.textAlign = TextAlign.left,
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _currentTextIndex = 0;
  int _currentLength = 0;
  bool _isTyping = true;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.typingDuration,
    )..addListener(_updateText);

    _startTyping();
  }

  void _startTyping() {
    final currentText = widget.texts[_currentTextIndex];

    if (_isTyping && _currentLength < currentText.length) {
      // Typing forward
      _controller.duration = widget.typingDuration;
      _controller.forward(from: 0);
    } else if (_isTyping && _currentLength == currentText.length) {
      // Pause after typing complete
      _isTyping = false;
      Future.delayed(widget.pauseDuration, () {
        setState(() {
          _isDeleting = true;
        });
        _startErasing();
      });
    } else if (_isDeleting && _currentLength > 0) {
      // Deleting text
      _controller.duration = widget.eraseDuration;
      _controller.forward(from: 0);
    } else if (_isDeleting && _currentLength == 0) {
      // Move to next text after deleting complete
      _isDeleting = false;
      setState(() {
        _currentTextIndex = (_currentTextIndex + 1) % widget.texts.length;
        _isTyping = true;
      });
      Future.delayed(const Duration(milliseconds: 500), _startTyping);
    }
  }

  void _startErasing() {
    _startTyping();
  }

  void _updateText() {
    if (_controller.status == AnimationStatus.completed) {
      setState(() {
        if (_isTyping) {
          _currentLength++;
        } else if (_isDeleting) {
          _currentLength--;
        }
      });
      _controller.reset();
      _startTyping();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentText = widget.texts[_currentTextIndex];
    final displayText = currentText.substring(0, _currentLength);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          displayText,
          style: widget.style,
          textAlign: widget.textAlign,
        ),
        AnimatedOpacity(
          opacity: _isTyping || _isDeleting ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: Text(
            '|',
            style: widget.style?.copyWith(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}*/
