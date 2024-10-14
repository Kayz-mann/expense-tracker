import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const AppButton({
    Key? key,
    required this.label,
    this.isLoading = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: kToolbarHeight,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
    );
  }
}
