import 'dart:math';
import 'package:flutter/material.dart';

class ThemeSelector extends StatefulWidget {
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
  State<ThemeSelector> createState() => _ThemeSelectorState();
}

class _ThemeSelectorState extends State<ThemeSelector>
    with TickerProviderStateMixin {

  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: AnimatedBuilder(
        animation: _floatController,
        builder: (context, _) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.gradients.length,
            itemBuilder: (context, index) {

              final isSelected = index == widget.selectedIndex;

              /// floating offset
              final floatOffset =
                  sin((_floatController.value * 2 * pi) + index) * 6;

              /// scale breathing
              final scale =
                  1 + (sin((_floatController.value * 2 * pi) + index) * 0.05);

              return Transform.translate(
                offset: Offset(0, floatOffset),
                child: Transform.scale(
                  scale: isSelected ? 1.13 : scale,
                  child: GestureDetector(
                    onTapDown: (details) {
                      widget.onSelected(index, details.globalPosition);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      width: isSelected ? 53 : 43,
                      height: isSelected ? 53 : 43,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: widget.gradients[index],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          if (isSelected)
                            BoxShadow(
                              color: widget.gradients[index].first
                                  .withValues(alpha: .7),
                              blurRadius: 13,
                              spreadRadius: 3,
                            )
                          else
                            BoxShadow(
                              color: widget.gradients[index].first
                                  .withValues(alpha: .25),
                              blurRadius: 10,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
