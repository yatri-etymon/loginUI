import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/widgets/background_image.dart';
import 'package:login/widgets/my_elevated_button.dart';
import 'package:login/screens/with_otp_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 50.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.italiana(
                        letterSpacing: 2,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),

                    MyElevatedButton(
                      text: 'Log-In with OTP',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => WithOtpScreen()),
                      ),
                      color: Colors.white,
                      textColor: Colors.green.shade900,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(indent: 5, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "Or",
                            style: GoogleFonts.italiana(
                              letterSpacing: 2,
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(endIndent: 5, color: Colors.white),
                        ),
                      ],
                    ),
                    MyElevatedButton(
                      text: 'Log-In with Google',
                      onTap: () {},
                      color: Colors.lightGreen.shade900,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
