import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_demo/widgeta/background_image.dart';
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
          heightFactor: 0.60,
          widthFactor: 1,
          alignment: Alignment.topCenter,
          child: BackgroundImage(),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.52,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'User Email/Phone number',
                        style: GoogleFonts.lato(
                          letterSpacing: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Pinput(length: 6),
                    SizedBox(height: 25),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.teal.shade700,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Verify OTP',
                        style: GoogleFonts.lato(
                          letterSpacing: 1,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
    );
  }
}
