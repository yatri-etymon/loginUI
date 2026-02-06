import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WheelPickerContent extends StatefulWidget {
  final String title;
  final List<String> values;
  final int initialIndex;
  final Function(String) onDone;

  const WheelPickerContent({
    super.key,
    required this.title,
    required this.values,
    required this.initialIndex,
    required this.onDone,
  });

  @override
  State<WheelPickerContent> createState() => _WheelPickerContentState();
}

class _WheelPickerContentState extends State<WheelPickerContent> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 170,
          child: CupertinoPicker(
            itemExtent: 42,
            scrollController:
                FixedExtentScrollController(initialItem: widget.initialIndex),
            onSelectedItemChanged: (index) {
              selectedIndex = index;
            },
            children: widget.values.map((val) {
              return Center(
                child: Text(
                  val,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 10),

        TextButton(
          onPressed: () => widget.onDone(widget.values[selectedIndex]),
          child: Text(
            "Done",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
