import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ContainerLogo extends StatelessWidget {
  const ContainerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          MediaRes.images.logo,
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Restaurant Finder",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
