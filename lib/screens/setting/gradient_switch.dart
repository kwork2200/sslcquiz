import 'package:flutter/material.dart';

class GradientSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Duration duration;

  const GradientSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  _GradientSwitchState createState() => _GradientSwitchState();
}

class _GradientSwitchState extends State<GradientSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: widget.duration,
        width: 50,
        height: 25,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: widget.value
              ? LinearGradient(colors: [Color(0xFF583FC7),Color(0xFFB86FD3)])
              : LinearGradient(
            colors: [Colors.grey.shade400, Colors.grey.shade300],
          ),
        ),
        child: AnimatedAlign(
          duration: widget.duration,
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
