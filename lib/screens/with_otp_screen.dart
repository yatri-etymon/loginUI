import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_demo/widgeta/background_image.dart';
import 'package:login_demo/widgeta/my_textfield.dart';

class WithOtpScreen extends StatefulWidget {
  const WithOtpScreen({super.key});

  @override
  State<WithOtpScreen> createState() => _WithOtpScreenState();
}

class _WithOtpScreenState extends State<WithOtpScreen> {
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
              height: MediaQuery.of(context).size.height * 0.52, // 👈 60%
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Text(
                        'Email/Phone number :',
                        style: GoogleFonts.lato(
                          letterSpacing: 2,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.teal.shade900,
                        ),
                      ),
                    ),
                    MyTextfield(
                      controller: controller,
                      hintText: '',
                      obscureText: false,
                    ),
                    SizedBox(height: 25),
                    //ElevatedButton(onPressed: () {}, child: Text('Send OTP')),
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
