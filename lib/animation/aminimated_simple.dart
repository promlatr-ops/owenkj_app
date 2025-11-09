import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  double _size = 100;
  Color _color = Colors.blue;

  void _changeBox() {
    setState(() {
      _size = _size == 100 ? 200 : 100;
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(seconds: 1), // ระยะเวลาของ Animation
          curve: Curves.easeInOut, // รูปแบบการเคลื่อนไหว
          width: _size, //เปลี่ยนขนาดความกว้าง
          height: _size, //เปลี่ยนขนาดสูง
          color: _color, //เปลี่ยนสี
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _changeBox,
          child: const Text('Animate Box'),
        ),
      ],
    );
  }
}

class FadeWidget extends StatefulWidget {
  const FadeWidget({super.key});

  @override
  _FadeWidgetState createState() => _FadeWidgetState();
}

class _FadeWidgetState extends State<FadeWidget> {
  double _opacity = 1.0;

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.2 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _opacity,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _toggleOpacity,
          child: const Text('Toggle Opacity'),
        ),
      ],
    );
  }
}

class AlignWidget extends StatefulWidget {
  const AlignWidget({super.key});

  @override
  _AlignWidgetState createState() => _AlignWidgetState();
}

class _AlignWidgetState extends State<AlignWidget> {
  bool _isLeft = true;

  void _togglePosition() {
    setState(() {
      _isLeft = !_isLeft;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          duration: const Duration(seconds: 1),
          alignment: _isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(width: 100, height: 100, color: Colors.red),
        ),
        Center(
          child: ElevatedButton(
            onPressed: _togglePosition,
            child: const Text('Move Box'),
          ),
        ),
      ],
    );
  }
}

class PaddingWidget extends StatefulWidget {
  const PaddingWidget({super.key});

  @override
  _PaddingWidgetState createState() => _PaddingWidgetState();
}

class _PaddingWidgetState extends State<PaddingWidget> {
  double _padding = 10;

  void _increasePadding() {
    setState(() {
      _padding = _padding == 10 ? 50 : 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedPadding(
          duration: const Duration(seconds: 1),
          padding: EdgeInsets.all(_padding),
          child: Container(width: 100, height: 100, color: Colors.green),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _increasePadding,
          child: const Text('Change Padding'),
        ),
      ],
    );
  }
}

class PositionedWidget extends StatefulWidget {
  const PositionedWidget({super.key});

  @override
  _PositionedWidgetState createState() => _PositionedWidgetState();
}

class _PositionedWidgetState extends State<PositionedWidget> {
  bool _isLeft = true;

  void _moveBox() {
    setState(() {
      _isLeft = !_isLeft;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(seconds: 1),
          left: _isLeft ? 20 : 200,
          top: 100,
          child: Container(width: 100, height: 100, color: Colors.purple),
        ),
        Center(
          child: ElevatedButton(
            onPressed: _moveBox,
            child: const Text('Move Box'),
          ),
        ),
      ],
    );
  }
}

class SwitcherWidget extends StatefulWidget {
  const SwitcherWidget({super.key});

  @override
  _SwitcherWidgetState createState() => _SwitcherWidgetState();
}

class _SwitcherWidgetState extends State<SwitcherWidget> {
  bool _isFirst = true;

  void _switchWidget() {
    setState(() {
      _isFirst = !_isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: _isFirst
              ? Container(
                  key: const ValueKey(1),
                  width: 100,
                  height: 100,
                  color: Colors.orange)
              : Container(
                  key: const ValueKey(2),
                  width: 100,
                  height: 100,
                  color: Colors.blue),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _switchWidget,
          child: const Text('Switch Widget'),
        ),
      ],
    );
  }
}
