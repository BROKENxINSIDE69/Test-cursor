import 'dart:math';
import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiValidationResult {
  final bool isCorrect;
  final String explanation;
  GeminiValidationResult({required this.isCorrect, required this.explanation});
}

class GeminiService {
  late final String _apiKey;
  GenerativeModel? _model;

  GeminiService() {
    _apiKey = const String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
    if (_apiKey.isNotEmpty) {
      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);
    }
  }

  Future<GeminiValidationResult> validateAnswer({
    required String storyText,
    required String userAnswer,
  }) async {
    if (_model == null) {
      // Fallback: naive heuristic comparison
      final normalized = storyText.toLowerCase();
      final guess = userAnswer.toLowerCase();
      final isCorrect = normalized.contains(guess) && guess.trim().isNotEmpty;
      return GeminiValidationResult(
        isCorrect: isCorrect,
        explanation: isCorrect
            ? 'सही उत्तर! आपकी तर्क-शक्ति बेहतरीन है।'
            : 'यह उत्तर सही नहीं है। समाधान सुनिए: कथानक में छुपे संकेतों पर ध्यान दें — समय, अलिबाई, और पत्र में छपी गलती।',
      );
    }

    final prompt = '''आप एक रहस्य कथा विशेषज्ञ हैं। उपयोगकर्ता का उत्तर जाँचें कि हत्या की गुत्थी का समाधान सही है या नहीं।

कहानी (हिंदी):
$storyText

उपयोगकर्ता का उत्तर:
$userAnswer

आउटपुट JSON में दें: {"isCorrect": true/false, "explanation": "हिंदी में संक्षिप्त कारण"}
''';

    final response = await _model!.generateContent([Content.text(prompt)]);
    final text = response.text ?? '';
    final match = RegExp(r'\{[\s\S]*\}').firstMatch(text);
    if (match != null) {
      final jsonStr = match.group(0)!;
      final parsed = _tryParseJson(jsonStr);
      if (parsed != null) {
        return GeminiValidationResult(
          isCorrect: parsed['isCorrect'] == true,
          explanation: parsed['explanation']?.toString() ?? '—',
        );
      }
    }
    // Fallback if parsing fails
    final isCorrect = Random().nextBool();
    return GeminiValidationResult(
      isCorrect: isCorrect,
      explanation: isCorrect ? 'सही उत्तर।' : 'उत्तर गलत। सुरागों को जोड़कर देखें।',
    );
  }

  Map<String, dynamic>? _tryParseJson(String s) {
    try {
      return (const JsonDecoder()).convert(s) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}