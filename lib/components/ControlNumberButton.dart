import 'package:flutter/material.dart';

class ControlNumberButton extends StatelessWidget {
  final String number;
  final void Function()? onTap;

  const ControlNumberButton({
    super.key,
    required this.number,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 2,
          )
        ),
        child: Text(
          number,
          style: const TextStyle(
            fontSize: 18
          ),
          )
      ),
    );
  }
}