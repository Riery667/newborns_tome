import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverText extends StatefulWidget {
  final String text;

  const HoverText({Key? key, required this.text}) : super(key: key);

  @override
  _HoverTextState createState() => _HoverTextState();
}

class _HoverTextState extends State<HoverText> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    const defaultColor = Colors.black;
    const hoverColor = Colors.grey;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Text(
          widget.text,
          style: GoogleFonts.italiana(
            fontSize: 14,
            color: _isHovered
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
