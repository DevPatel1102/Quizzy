import 'package:flutter/material.dart';
import '../data/Quiz.dart';
import '../sevices/api_services.dart';
import 'result_screen.dart'; // Import the result screen

class quiz_screen extends StatefulWidget {
  const quiz_screen({super.key});

  @override
  State<quiz_screen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<quiz_screen> {
  ApiService apiService = ApiService();
  Quiz? quizData;
  bool isLoading = true;
  bool isError = false;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedOptionId; // Updated to match the type of option.id
  bool isOptionSelected = false;

  @override
  void initState() {
    super.initState();
    fetchQuiz();
  }

  Future<void> fetchQuiz() async {
    try {
      setState(() {
        isLoading = true;
        isError = false;
      });

      final fetchedQuiz = await apiService.fetchQuizData();
      setState(() {
        quizData = fetchedQuiz;

        // Shuffle questions
        quizData?.questions.shuffle();

        // Shuffle options for each question
        for (var question in quizData!.questions) {
          question.options.shuffle();
        }

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load quiz. Try again!')),
      );
    }
  }

  void handleOptionSelected(int optionId, bool isCorrect) { // Adjusted type to int
    if (isOptionSelected) return;

    setState(() {
      selectedOptionId = optionId;
      isOptionSelected = true;
      if (isCorrect) {
        score += 1;
      }
    });

    // Delay before moving to the next question
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (currentQuestionIndex < (quizData?.questions.length ?? 0) - 1) {
        setState(() {
          currentQuestionIndex += 1;
          selectedOptionId = null;
          isOptionSelected = false;
        });
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => result_screen(
              score: score,
              totalQuestions: quizData?.questions.length ?? 0,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF6A1B9A),
          ),
        )
            : isError
            ? const Center(
          child: Text(
            'Failed to load data. Try again later.',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          ),
        )
            : quizData == null
            ? const Center(
          child: Text(
            'No quiz data available.',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
          ),
        )
            : Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF8E2DE2),
                      Color(0xFF4A00E0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Questions: ${quizData!.questions.length}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Current Question Indicator
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Question ${currentQuestionIndex + 1}/${quizData!.questions.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Current Question Text
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizData!.questions[currentQuestionIndex]
                            .description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Options
                      ...quizData!
                          .questions[currentQuestionIndex]
                          .options
                          .map(
                            (option) {
                          final isCorrect = option.isCorrect;
                          final isSelected = selectedOptionId == option.id;
                          final borderColor = isSelected
                              ? isCorrect
                              ? const Color(0xFF1F9425)
                              : const Color(0xFFE80E00)
                              : (isCorrect && isOptionSelected)
                              ? const Color(0xFF1F9425)
                              : const Color(0xFFE3D0FF);

                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0),
                              child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width -
                                    40,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      handleOptionSelected(
                                          option.id,
                                          option.isCorrect),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Colors.transparent,
                                    shadowColor:
                                    Colors.transparent,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          12),
                                      side: BorderSide(
                                          color: borderColor,
                                          width: 2),
                                    ),
                                    padding: const EdgeInsets
                                        .symmetric(
                                      vertical: 16.0,
                                      horizontal: 24.0,
                                    ),
                                  ),
                                  child: Text(
                                    option.description,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
