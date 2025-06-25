import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final String svgPath;
  final String label;
  final VoidCallback onTap;

  const CustomCard({
    super.key,
    required this.svgPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        height: 250,
        margin: const EdgeInsets.only(left: 24),
        child: Card(
          margin: const EdgeInsets.all(0),
          color: Colors.deepPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12), // Match Card radius
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16), // Space before SVG
                SvgPicture.asset(svgPath, height: 150),

                const Spacer(flex: 1),
                Container(
                  width: double.infinity,
                  color: Colors.deepPurpleAccent,
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
