import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_demo/screens/with_otp_screen.dart';
import 'package:login_demo/widgeta/background_image.dart';
import 'package:login_demo/widgeta/square_tile.dart';

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
                  bottom: 60.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.lato(
                        letterSpacing: 1,
                        fontSize: 27,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SquareTile(
                          imagePath: 'assets/icons/image.png',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => WithOtpScreen()),
                          ),
                        ),
                        SizedBox(width: 30),
                        SquareTile(
                          imagePath: 'assets/icons/google.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(indent: 90, color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Or",
                              style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(endIndent: 90, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Skip For Now >',
                        style: GoogleFonts.lato(
                          letterSpacing: 2,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    //SizedBox(height: 8),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       border: Border(
                    //         bottom: BorderSide(color: Colors.white, width: 1),
                    //       ),
                    //     ),
                    //     child: Text(
                    //       'Skip For Now',
                    //       style: GoogleFonts.lato(
                    //         letterSpacing: 1,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
