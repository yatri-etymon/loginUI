import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  final List<List<Color>> gradients;
  final int selectedIndex;
  final Function(int index, Offset tapPosition) onSelected;

  const ThemeSelector({
    super.key,
    required this.gradients,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: gradients.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTapDown: (details) {
              onSelected(index, details.globalPosition);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: isSelected ? 54 : 44,
              height: isSelected ? 54 : 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                //gradient orb
                gradient: LinearGradient(
                  colors: gradients[index],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                /// glow when selected
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: gradients[index].first.withValues(alpha: 0.65),
                      blurRadius: 22,
                      spreadRadius: 2,
                    )
                  else
                    BoxShadow(
                      color: gradients[index].first.withValues(alpha: 0.25),
                      blurRadius: 10,
                      spreadRadius: 0.5,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
