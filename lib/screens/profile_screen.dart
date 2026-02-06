import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_blue/widgets/common/wheel_picker_content.dart';
import 'package:provider/provider.dart';

import 'package:login_blue/app/app_flow_controller.dart';
import 'package:login_blue/theme/app_colors.dart';
import 'package:login_blue/theme/theme_controller.dart';

import 'package:login_blue/widgets/common/glass_card.dart';
import 'package:login_blue/widgets/common/glass_popup.dart';
import 'package:login_blue/widgets/common/name_field.dart';

import 'package:login_blue/widgets/ui/year_picker_content.dart';
import 'package:login_blue/widgets/ui/theme_selector.dart';
import 'package:login_blue/widgets/ui/gradient_background.dart';

import 'package:login_blue/widgets/effects/radial_bloom_painter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final birthYearController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  late AnimationController _bloomController;
  late Animation<double> _bloomAnimation;

  Offset? _bloomCenter;
  Color? selectedThemeColor;
  int selectedThemeIndex = -1;

  int setupStep = 1;
  bool isForward = true;

  String? selectedGender;

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
    heightController.dispose();
    weightController.dispose();
    _bloomController.dispose();
    super.dispose();
  }

  bool get isStep1Valid =>
      nameController.text.trim().isNotEmpty &&
      birthYearController.text.isNotEmpty &&
      selectedThemeIndex >= 0;

  bool get isStep2Valid =>
      selectedGender != null &&
      heightController.text.isNotEmpty &&
      weightController.text.isNotEmpty;

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
                bottom: 40,
              ),
              child: Center(
                child: GlassCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 26,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 520),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (child, animation) {
                        final beginOffset = isForward
                            ? const Offset(1.2, 0)
                            : const Offset(-1.2, 0);

                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: beginOffset,
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: setupStep == 1
                          ? _buildStep1(const ValueKey(1))
                          : _buildStep2(const ValueKey(2)),
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

  Widget _buildStep1(Key key) {
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: [
        _title('Profile Setup (1 / 2)'),
        const SizedBox(height: 18),

        NameField(
          controller: nameController,
          onChanged: (_) => setState(() {}),
          hintText: 'Name',
        ),

        const SizedBox(height: 14),

        _selectorBox(
          birthYearController.text.isEmpty
              ? 'Select Birth Year'
              : birthYearController.text,
          _showYearPicker,
        ),

        const SizedBox(height: 22),

        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Choose your theme',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),

        const SizedBox(height: 12),

        ThemeSelector(
          gradients: gradientEntries.map((e) => e.value).toList(),
          selectedIndex: selectedThemeIndex,
          onSelected: (index, tapPos) {
            final grad = gradientEntries[index].value;
            setState(() {
              selectedThemeIndex = index;
              selectedThemeColor = grad.first;
              _bloomCenter = tapPos;
            });
            _bloomController.forward(from: 0);
            context.read<ThemeController>().setTheme(
              gradientEntries[index].key,
            );
          },
        ),

        const SizedBox(height: 26),

        _primaryButton(
          text: 'Continue →',
          enabled: isStep1Valid,
          onTap: () {
            setState(() {
              isForward = true;
              setupStep = 2;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStep2(Key key) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            _backButton(),
            const Spacer(),
            _title('Profile Setup (2 / 2)'),
            const Spacer(),
          ],
        ),

        const SizedBox(height: 26),

        _label('Gender'),
        const SizedBox(height: 10),
        Row(
          children: [
            _genderChip('Male'),
            const SizedBox(width: 10),
            _genderChip('Female'),
            const SizedBox(width: 10),
            _genderChip('Other'),
          ],
        ),

        const SizedBox(height: 22),

        _label('Height (cm)'),
        const SizedBox(height: 10),
        _selectorBox(
          heightController.text.isEmpty
              ? 'Select height'
              : heightController.text,
          _showHeightPicker,
        ),

        const SizedBox(height: 20),

        _label('Weight (kg)'),
        const SizedBox(height: 10),
        _selectorBox(
          weightController.text.isEmpty
              ? 'Select weight'
              : weightController.text,
          _showWeightPicker,
        ),

        const SizedBox(height: 30),

        _primaryButton(text: 'Done', enabled: isStep2Valid, onTap: () {}),

        const SizedBox(height: 12),

        TextButton(
          onPressed: () {},
          child: Text(
            'Skip for now >',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _showYearPicker() {
    final currentYear = DateTime.now().year;
    int initialYear = birthYearController.text.isNotEmpty
        ? int.parse(birthYearController.text)
        : currentYear - 18;

    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (_) => GlassPopup(
        onClose: () => overlay.remove(),
        child: YearPickerContent(
          initialYear: initialYear,
          onDone: (year) {
            birthYearController.text = year.toString();
            overlay.remove();
            setState(() {});
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlay);
  }

  void _showHeightPicker() {
    final values = List.generate(121, (i) => '${140 + i} cm');
    _showWheelPicker('Select Height', values, heightController);
  }

  void _showWeightPicker() {
    final values = List.generate(111, (i) => '${40 + i} kg');
    _showWheelPicker('Select Weight', values, weightController);
  }

  void _showWheelPicker(
    String title,
    List<String> values,
    TextEditingController controller,
  ) {
    int initialIndex = 0;
    if (controller.text.isNotEmpty) {
      initialIndex = values.indexOf(controller.text);
      if (initialIndex < 0) initialIndex = 0;
    }

    late OverlayEntry overlay;
    overlay = OverlayEntry(
      builder: (_) => GlassPopup(
        onClose: () => overlay.remove(),
        child: WheelPickerContent(
          title: title,
          values: values,
          initialIndex: initialIndex,
          onDone: (val) {
            controller.text = val;
            overlay.remove();
            setState(() {});
          },
        ),
      ),
    );

    Overlay.of(context).insert(overlay);
  }

  Widget _title(String text) => Text(
    text,
    style: GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );

  Widget _label(String text) => Align(
    alignment: Alignment.centerLeft,
    child: Text(text, style: GoogleFonts.poppins(color: Colors.white)),
  );

  Widget _backButton() => GestureDetector(
    onTap: () {
      setState(() {
        isForward = false;
        setupStep = 1;
      });
    },
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withValues(alpha: 0.12),
        border: Border.all(color: Colors.white54),
      ),
      child: const Icon(
        Icons.arrow_back_ios_new,
        color: Colors.white,
        size: 16,
      ),
    ),
  );

  Widget _genderChip(String label) {
    final selected = selectedGender == label;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected
              ? (selectedThemeColor ?? Colors.white).withValues(alpha: 0.90)
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white54),
        ),
        child: Text(label, style: GoogleFonts.poppins(color: Colors.white)),
      ),
    );
  }

  Widget _selectorBox(String text, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(text, style: GoogleFonts.poppins(color: Colors.white)),
    ),
  );

  Widget _primaryButton({
    required String text,
    required bool enabled,
    required VoidCallback onTap,
  }) => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: enabled ? onTap : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedThemeColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    ),
  );
}
