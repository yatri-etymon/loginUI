import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/background_image.dart';
import 'package:login/widgets/top_curve_clipper.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FractionallySizedBox(
          heightFactor: 0.55,
          widthFactor: 1,
          alignment: Alignment.topCenter,
          child: BackgroundImage(),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: 0.99,
              widthFactor: 1,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  FractionallySizedBox(
                    heightFactor: 0.70,
                    widthFactor: 1,
                    child: ClipPath(
                      clipper: TopCurveClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade100.withValues(alpha: 0.16),
                        ),
                      ),
                    ),
                  ),

                  FractionallySizedBox(
                    heightFactor: 0.60,
                    widthFactor: 1,
                    child: ClipPath(
                      clipper: TopCurveClipper(),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 229, 255, 229),
                        ),
                      ),
                    ),
                  ),

                  FractionallySizedBox(
                    heightFactor: 0.50,
                    widthFactor: 1,
                    child: ClipPath(
                      clipper: TopCurveClipper(),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, -6),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Email/Phone number',
                                  style: GoogleFonts.italiana(
                                    letterSpacing: 2,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 12),

                                Pinput(length: 6),
                                SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0,
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(double.infinity, 52),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                      ),

                                      backgroundColor: Colors.green.shade800,
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {},
                                    child: Text(
                                      'Verify OTP',
                                      style: GoogleFonts.italiana(
                                        letterSpacing: 2,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
