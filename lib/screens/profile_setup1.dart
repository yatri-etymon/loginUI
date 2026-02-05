import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/app/app_flow_controller.dart';
import 'package:login_blue/widgets/effects/radial_bloom_painter.dart';
import 'package:login_blue/widgets/ui/theme_selector.dart';
import 'package:login_blue/widgets/common/birth_year_picker.dart';
import 'package:login_blue/widgets/common/name_field.dart';
import 'package:provider/provider.dart';
import 'package:login_blue/theme/app_colors.dart';
import 'package:login_blue/theme/theme_controller.dart';

import '../widgets/ui/gradient_background.dart';
import '../widgets/ui/glass_card.dart';

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

  //get gradients from app_colors.dart
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

  bool get isFormValid {
    return nameController.text.trim().isNotEmpty &&
        birthYearController.text.isNotEmpty &&
        selectedThemeIndex >= 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<AppFlowController>().goToStart();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const GradientBackground(),

            //radial bloom overlay
            if (selectedThemeColor != null && _bloomCenter != null)
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _bloomAnimation,
                  builder: (_, __) {
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
                top: MediaQuery.of(context).size.height * 0.15,
                bottom: 40,
              ),
              child: Center(
                child: GlassCard(
                  width: width,
                  isExpanded: true,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        /// Header
                        Text(
                          'Profile Setup (1 / 2)',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// Name field
                        NameField(
                          controller: nameController,
                          onChanged: (_) => setState(() {}),
                          hintText: 'Name',
                        ),

                        const SizedBox(height: 14),

                        /// Birth year picker
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
                              color: Colors.grey[50],
                              fontSize: 13,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        ThemeSelector(
                          gradients: gradientEntries.map((e) => e.value).toList(),
                          selectedIndex: selectedThemeIndex,
                          onSelected: (index, tapPosition) {

                            final selectedId = gradientEntries[index].key;
                            final selectedGradient = gradientEntries[index].value;

                            setState(() {
                              selectedThemeIndex = index;
                              selectedThemeColor = selectedGradient.first;
                              _bloomCenter = tapPosition;
                            });

                            _bloomController.forward(from: 0);

                            /// 🔥 APPLY APP THEME
                            context.read<ThemeController>().setTheme(selectedId);
                          },
                        ),

                        const SizedBox(height: 26),

                        /// Continue button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isFormValid ? () {} : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  selectedThemeColor ?? Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: Text(
                              'Continue →',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[50]
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

  /// Birth year picker
  void _showYearPicker(BuildContext context) {
    final currentYear = DateTime.now().year;
    int tempSelectedYear = birthYearController.text.isNotEmpty
        ? int.parse(birthYearController.text)
        : currentYear - 18;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 260,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 48),
                    Text(
                      'Select birth year',
                      style:
                          GoogleFonts.poppins(fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          birthYearController.text =
                              tempSelectedYear.toString();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: CupertinoPicker(
                  itemExtent: 40,
                  scrollController: FixedExtentScrollController(
                    initialItem: currentYear - tempSelectedYear,
                  ),
                  onSelectedItemChanged: (index) {
                    tempSelectedYear = currentYear - index;
                  },
                  children: List.generate(
                    110,
                    (index) => Center(
                      child: Text(
                        (currentYear - index).toString(),
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

