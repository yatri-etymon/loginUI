import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeightPickerPopup extends StatefulWidget {
  final int initialHeight;
  final ValueChanged<int> onDone;
  final VoidCallback onClose;

  const HeightPickerPopup({
    super.key,
    required this.initialHeight,
    required this.onDone,
    required this.onClose,
  });

  @override
  State<HeightPickerPopup> createState() => _HeightPickerPopupState();
}

class _HeightPickerPopupState extends State<HeightPickerPopup>
    with SingleTickerProviderStateMixin {
  late int tempHeight;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    tempHeight = widget.initialHeight;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: widget.onClose,
        child: Container(
          color: Colors.black.withValues(alpha: 0.35),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Center(
              child: ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.only(top: 18, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select Height (cm)',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),

                          SizedBox(
                            height: 160,
                            child: CupertinoPicker(
                              itemExtent: 40,
                              scrollController: FixedExtentScrollController(
                                initialItem: tempHeight - 100,
                              ),
                              onSelectedItemChanged: (index) {
                                tempHeight = 100 + index;
                              },
                              children: List.generate(
                                121,
                                (i) => Center(
                                  child: Text(
                                    '${100 + i}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          TextButton(
                            onPressed: () {
                              widget.onDone(tempHeight);
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Done',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
