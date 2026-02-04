import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileSetupContent extends StatefulWidget {
  const ProfileSetupContent({super.key});

  @override
  State<ProfileSetupContent> createState() => _ProfileSetupContentState();
}

class _ProfileSetupContentState extends State<ProfileSetupContent> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _currentStep == 0 ? 'Basic Info' : 'Personalize',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${_currentStep + 1} / 2',
              style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // PageView for Steps
        SizedBox(
          height: 180, // Adjust based on your input needs
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentStep = index),
            children: [
              _buildStepOne(),
              _buildStepTwo(),
            ],
          ),
        ),

        // Navigation Button
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_currentStep == 0) {
              _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
            } else {
              // Final Submit Logic
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(_currentStep == 0 ? 'Next' : 'Finish'),
        ),
      ],
    );
  }

  Widget _buildStepOne() {
    return Column(
      children: [
        _buildTextField('Full Name', Icons.person_outline),
        const SizedBox(height: 12),
        _buildTextField('Username', Icons.alternate_email),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      children: [
        _buildTextField('Bio', Icons.edit_note_outlined),
        const SizedBox(height: 12),
        // Placeholder for a "Upload Image" style button
        Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white24),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, color: Colors.white70),
              SizedBox(width: 10),
              Text('Upload Profile Picture', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String hint, IconData icon) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }
}