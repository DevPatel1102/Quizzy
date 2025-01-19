class Quiz {
  final String title;
  final String topic;
  final int negativeMarks;
  final int correctAnswerMarks;
  final int questionsCount;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.topic,
    required this.negativeMarks,
    required this.correctAnswerMarks,
    required this.questionsCount,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    var questionsList = (json['questions'] as List)
        .map((questionJson) => Question.fromJson(questionJson))
        .toList();

    return Quiz(
      title: json['title'],
      topic: json['topic'],
      negativeMarks: _parseInt(json['negative_marks']),
      correctAnswerMarks: _parseInt(json['correct_answer_marks']),
      questionsCount: _parseInt(json['questions_count']),
      questions: questionsList,
    );
  }

  // Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;  // Default to 0 if parsing fails
    } else if (value is int) {
      return value;
    }
    return 0;  // Fallback in case value is not a String or int
  }
}

class Question {
  final int id;
  final String description;
  final String? detailedSolution;
  final List<Option> options;

  Question({
    required this.id,
    required this.description,
    this.detailedSolution,
    required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    var optionsList = (json['options'] as List)
        .map((optionJson) => Option.fromJson(optionJson))
        .toList();

    return Question(
      id: _parseInt(json['id']),
      description: json['description'],
      detailedSolution: json['detailed_solution'],
      options: optionsList,
    );
  }
  // Helper method to safely parse integers for the Question class
  static int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;  // Default to 0 if parsing fails
    } else if (value is int) {
      return value;
    }
    return 0;  // Fallback if value is not a String or int
  }
}

class Option {
  final int id;
  final String description;
  final int questionId;
  final bool isCorrect;

  Option({
    required this.id,
    required this.description,
    required this.questionId,
    required this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: _parseInt(json['id']),
      description: json['description'],
      questionId: _parseInt(json['question_id']),
      isCorrect: json['is_correct'] ?? false,  // Default to false if missing
    );
  }

  // Helper method to safely parse integers
  static int _parseInt(dynamic value) {
    if (value is String) {
      return int.tryParse(value) ?? 0;  // Default to 0 if parsing fails
    } else if (value is int) {
      return value;
    }
    return 0;  // Fallback if value is not a String or int
  }
}
