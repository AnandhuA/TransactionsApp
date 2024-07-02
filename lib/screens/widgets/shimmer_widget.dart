import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: const EdgeInsets.all(30),
            padding: const EdgeInsets.all(20),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 30,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
