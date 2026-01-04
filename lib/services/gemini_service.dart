import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  // IMPORTANT: Replace with your actual Gemini API Key
  static const String _apiKey = 'AIzaSyDOgC3W84NuDLHLz-QF5cQJXy5a5oFmvGo';

  static GenerativeModel? _model;

  static void init() {
    if (_apiKey != 'YOUR_GEMINI_API_KEY_HERE') {
      _model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: _apiKey,
        generationConfig: GenerationConfig(
          temperature: 0.7,
          topK: 40,
          topP: 0.95,
          maxOutputTokens: 1024,
        ),
      );
    }
  }

  static const String _systemInstruction =
      "You are a helpful healthcare assistant for the CareSphere app. "
      "Provide accurate, concise information about medicines, syrups, and injections. "
      "Always include a disclaimer that users should consult a qualified doctor or pharmacist before taking any medication.";

  static Future<String> getMedicineInfo(
    String medicineName,
    String type,
  ) async {
    if (_model == null) {
      return "Gemini API key is not configured. Please add your API key in lib/services/gemini_service.dart";
    }

    String prompt = "";
    switch (type) {
      case 'use':
        prompt =
            "What is the primary use of $medicineName? (Check if it is a tablet, syrup, or injection). Provide a concise medical explanation.";
        break;
      case 'dose':
        prompt =
            "What is the standard dosage for $medicineName (syrup, tablet, or injection) for adults and children?";
        break;
      case 'symptoms':
        prompt = "What symptoms does $medicineName treat? List them clearly.";
        break;
      case 'precaution':
        prompt =
            "What are the common precautions and side effects of $medicineName?";
        break;
      default:
        prompt =
            "Provide a summary of $medicineName (tablet, syrup, or injection) including its use, typical dose, symptoms it treats, and key precautions.";
    }

    try {
      final content = [Content.text("$_systemInstruction\n\n$prompt")];
      final response = await _model!.generateContent(content);
      return response.text ??
          "I couldn't find information about that medicine.";
    } catch (e) {
      return "Error fetching information: $e";
    }
  }

  static Future<String> customQuery(String query) async {
    if (_model == null) {
      return "Gemini API key is not configured. Please add your API key in lib/services/gemini_service.dart";
    }

    try {
      final content = [Content.text("$_systemInstruction\n\n$query")];
      final response = await _model!.generateContent(content);
      return response.text ?? "No response from Gemini.";
    } catch (e) {
      return "Error fetching information: $e";
    }
  }
}
