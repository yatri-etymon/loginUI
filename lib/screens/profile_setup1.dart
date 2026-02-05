import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/app/app_flow_controller.dart';
import 'package:login_blue/widgets/common/year_picker_popup.dart';
import 'package:login_blue/widgets/effects/radial_bloom_painter.dart';
import 'package:login_blue/widgets/ui/theme_selector.dart';
import 'package:login_blue/widgets/common/birth_year_picker.dart';
import 'package:login_blue/widgets/common/name_field.dart';
import 'package:provider/provider.dart';
import 'package:login_blue/theme/app_colors.dart';
import 'package:login_blue/theme/theme_controller.dart';

import '../widgets/ui/gradient_background.dart';
import '../widgets/common/glass_card.dart';

class ProfileSetup1 extends StatefulWidget {
  const ProfileSetup1({super.key});

  @override
  State<ProfileSetup1> createState() => _ProfileSetup1State();
}

class _ProfileSetup1State extends State<ProfileSetup1>
    with SingleTickerProviderStateMixin {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthYearController = TextEditingController();

  late AnimationController _bloomController;
  late Animation<double> _bloomAnimation;

  Offset? _bloomCenter;
  Color? selectedThemeColor;
  int selectedThemeIndex = -1;

  final gradientEntries = AppColors.gradients.entries.toList();

  @override
  void initState() {
    super.initState();
    _bloomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _bloomAnimation = CurvedAnimation(
      parent: _bloomController,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    birthYearController.dispose();
    _bloomController.dispose();
    super.dispose();
  }

  bool get isFormValid =>
      nameController.text.trim().isNotEmpty &&
      birthYearController.text.isNotEmpty &&
      selectedThemeIndex >= 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, _) {
        context.read<AppFlowController>().goToStart();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            const GradientBackground(),

            /// radial bloom
            if (selectedThemeColor != null && _bloomCenter != null)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _bloomAnimation,
                  builder: (_, _) {
                    return CustomPaint(
                      painter: RadialBloomPainter(
                        center: _bloomCenter!,
                        color: selectedThemeColor!,
                        progress: _bloomAnimation.value,
                      ),
                    );
                  },
                ),
              ),

            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.18,
                bottom: 35,
              ),
              child: Center(
                child: GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 25,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Profile Setup (1 / 2)',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 18),

                        NameField(
                          controller: nameController,
                          onChanged: (_) => setState(() {}),
                          hintText: 'Name',
                        ),

                        const SizedBox(height: 14),

                        BirthYearPicker(
                          controller: birthYearController,
                          onTap: () => _showYearPicker(context),
                          hintTeaxt: 'Birth Year',
                        ),

                        const SizedBox(height: 22),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose your theme',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        ThemeSelector(
                          gradients: gradientEntries
                              .map((e) => e.value)
                              .toList(),
                          selectedIndex: selectedThemeIndex,
                          onSelected: (index, tapPos) {
                            final selectedId = gradientEntries[index].key;
                            final selectedGradient =
                                gradientEntries[index].value;

                            setState(() {
                              selectedThemeIndex = index;
                              selectedThemeColor = selectedGradient.first;
                              _bloomCenter = tapPos;
                            });

                            _bloomController.forward(from: 0);
                            context.read<ThemeController>().setTheme(
                              selectedId,
                            );
                          },
                        ),

                        const SizedBox(height: 26),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isFormValid ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedThemeColor ?? Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'Continue →',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showYearPicker(BuildContext context) {
    final currentYear = DateTime.now().year;

    int initialYear = birthYearController.text.isNotEmpty
        ? int.parse(birthYearController.text)
        : currentYear - 18;

    late OverlayEntry overlay;

    overlay = OverlayEntry(
      builder: (context) {
        return YearPickerPopup(
          initialYear: initialYear,
          onDone: (year) {
            birthYearController.text = year.toString();
            overlay.remove();
            setState(() {});
          },
          onClose: () {
            overlay.remove();
          },
        );
      },
    );

    Overlay.of(context).insert(overlay);
  }
}
