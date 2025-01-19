import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class result_screen extends StatefulWidget {
  final int score;
  final int totalQuestions;

  const result_screen({
    super.key,
    required this.score,
    required this.totalQuestions,
  });

  @override
  State<result_screen> createState() => _result_screenState();
}

class _result_screenState extends State<result_screen> {

  @override
  void initState() {
    super.initState();
    _saveScore(widget.score);  // Save score when screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFCAACFF), Color(0xFF962CFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              Icon(
                Icons.celebration,
                size: 80,
                color: Colors.white.withOpacity(0.8),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Quiz Completed!',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your final score is:',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${widget.score} / ${widget.totalQuestions}',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4A3CC8),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                  shadowColor: const Color(0x664A3CC8),
                ),
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to save the score to SharedPreferences
  Future<void> _saveScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('previous_score', score);
  }
}
