import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YearPickerContent extends StatefulWidget {
  final int initialYear;
  final ValueChanged<int> onDone;

  const YearPickerContent({
    super.key,
    required this.initialYear,
    required this.onDone,
  });

  @override
  State<YearPickerContent> createState() => _YearPickerContentState();
}

class _YearPickerContentState extends State<YearPickerContent> {
  late int tempYear;

  @override
  void initState() {
    super.initState();
    tempYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Select Birth Year",
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
              initialItem: currentYear - tempYear,
            ),
            onSelectedItemChanged: (index) {
              tempYear = currentYear - index;
            },
            children: List.generate(
              100,
              (i) => Center(
                child: Text(
                  (currentYear - i).toString(),
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

        const SizedBox(height: 10),

        TextButton(
          onPressed: () => widget.onDone(tempYear),
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
