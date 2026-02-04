import 'package:flutter/material.dart';

class ThemeSelector extends StatelessWidget {
  final List<Color> colors;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const ThemeSelector({
    super.key,
    required this.colors,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(colors.length, (index) {
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: isSelected ? 42 : 36,
            height: isSelected ? 42 : 36,
            decoration: BoxDecoration(
              color: colors[index],
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: colors[index].withValues(alpha: 0.6),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
          ),
        );
      }),
    );
  }
}
