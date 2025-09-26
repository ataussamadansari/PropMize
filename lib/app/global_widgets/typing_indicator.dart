
import 'package:flutter/material.dart';
import 'dart:async';

class TypingIndicator extends StatefulWidget
{
    final String text;

    const TypingIndicator({super.key, this.text = "PropMize is thinking..."});

    @override
    State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin
{
    int _currentDot = 0;
    Timer? _timer;

    @override
    void initState()
    {
        super.initState();
        _timer = Timer.periodic(const Duration(milliseconds: 400), (timer)
            {
                setState(()
                    {
                        _currentDot = (_currentDot + 1) % 3;
                    }
                );
            }
        );
    }

    @override
    void dispose()
    {
        _timer?.cancel();
        super.dispose();
    }

    Widget _buildDot(int index)
    {
        return AnimatedOpacity(
            opacity: _currentDot == index ? 1.0 : 0.3,
            duration: const Duration(milliseconds: 300),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.blue
                )
            )
        );
    }

    @override
    Widget build(BuildContext context)
    {
        return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                Image.asset('assets/images/logo.png', width: 24, height: 24),
                const SizedBox(width: 8),
                Row(
                    children: List.generate(3, (index) => _buildDot(index))
                ),
                const SizedBox(width: 8),
                Text(widget.text, style: const TextStyle(color: Colors.grey))
            ]
        );
    }
}
