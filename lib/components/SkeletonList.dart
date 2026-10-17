import 'package:flutter/material.dart';

class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.productCards = false, this.count = 3});

  final bool productCards;
  final int count;

  Widget _block(BuildContext context, {double? width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (_) => Card(
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.only(bottom: 12),
          child: productCards
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _block(context, height: 210),
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _block(context, width: 180, height: 20),
                          const SizedBox(height: 10),
                          _block(context, height: 14),
                          const SizedBox(height: 7),
                          _block(context, width: 240, height: 14),
                          const SizedBox(height: 14),
                          _block(context, width: 120, height: 34),
                        ],
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      _block(context, width: 84, height: 84),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _block(context, width: 170, height: 18),
                            const SizedBox(height: 9),
                            _block(context, height: 13),
                            const SizedBox(height: 7),
                            _block(context, width: 110, height: 13),
                            const SizedBox(height: 10),
                            _block(context, width: 130, height: 32),
                          ],
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
