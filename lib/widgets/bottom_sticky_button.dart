import 'package:flutter/material.dart';

class BottomStickyButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String label;
  const BottomStickyButton({Key? key, required this.onPressed, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
        ),
        onPressed: onPressed,
        child:  Text(label),
      ),
    );
  }
}
