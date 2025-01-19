import 'package:flutter/material.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = constraints.maxHeight;
              return Stack(
                children: [
                  // Background Image
                  Image.asset(
                    'assets/splash_screen_logo.jpg',
                    height: screenHeight-300,
                    fit: BoxFit.cover,
                  ),
                  // Overlay Container
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 320,
                      width: screenWidth,// Height of the container
                      decoration: const BoxDecoration(
                        color: Color(0xFFA874D2), // Background color
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25), // Curved top-left corner
                          topRight: Radius.circular(25), // Curved top-right corner
                        ),
                      ),
                      child:  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Quizzy",
                            style: TextStyle(
                              fontSize: 45,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.white, // White text color
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Curiosity unlocks the doors of knowledge.\n", // First line
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                                TextSpan(
                                  text: "Embrace questions & Explore possibilities.", // Second line
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white, // White text color
                                  ),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 60), // Spacing between text and button
                          // Get Started Button
                          ElevatedButton(
                            onPressed: () {
                                Navigator.pushReplacementNamed(context, '/homePage');
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, // Needed for gradient
                              shadowColor: Colors.transparent, // Remove default shadow
                              padding: EdgeInsets.zero, // No padding for accurate gradient sizing
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Rounded corners
                              ),
                            ),
                            child: Container(
                              width: 200, // Button width
                              height: 50, // Button height
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF8E2DE2), // Gradient start color
                                    Color(0xFF4A00E0), // Gradient end color
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(30), // Match button shape
                              ),
                              alignment: Alignment.center, // Center the text
                              child: const Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white, // White text color
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
  }
}
