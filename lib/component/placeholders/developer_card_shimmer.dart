import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visko_rocky_flutter/theme/app_theme.dart';

class DeveloperCardShimmer extends StatelessWidget {
  const DeveloperCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final glass = Theme.of(context).extension<GlassColors>()!;
    return Container(
      margin: const EdgeInsets.only(left: 6, right: 6),
      width: MediaQuery.of(context).size.width * 0.72,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300.withOpacity(0.3),
        highlightColor: Colors.grey.shade100.withOpacity(0.2),
        child: Container(
          decoration: BoxDecoration(
            color: glass.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
