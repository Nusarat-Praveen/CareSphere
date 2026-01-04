import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../services/gemini_service.dart';

class GeminiChatScreen extends StatefulWidget {
  const GeminiChatScreen({super.key});

  @override
  State<GeminiChatScreen> createState() => _GeminiChatScreenState();
}

class _GeminiChatScreenState extends State<GeminiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    GeminiService.init();
    _messages.add({
      'role': 'assistant',
      'content':
          'Hello! I am Gemini, your health assistant. Ask me about any medicine, syrup, or injection. I can provide info on usage, dosage, and precautions.',
    });
  }

  void _sendMessage([String? quickActionType, String? medicineName]) async {
    String text = _controller.text.trim();
    if (text.isEmpty && quickActionType == null) return;

    String query = text;
    if (quickActionType != null && medicineName != null) {
      query = "Give me information about $medicineName's $quickActionType.";
    }

    setState(() {
      if (quickActionType == null) {
        _messages.add({'role': 'user', 'content': text});
        _controller.clear();
      }
      _isLoading = true;
    });

    String response;
    if (quickActionType != null && medicineName != null) {
      response = await GeminiService.getMedicineInfo(
        medicineName,
        quickActionType,
      );
    } else {
      response = await GeminiService.customQuery(query);
    }

    setState(() {
      _messages.add({'role': 'assistant', 'content': response});
      _isLoading = false;
    });
  }

  Widget _buildQuickAction(String title, String type) {
    return ActionChip(
      label: Text(title),
      onPressed: () {
        _showMedicineInputDialog(type);
      },
      backgroundColor: Colors.deepPurple.shade50,
      labelStyle: const TextStyle(color: Colors.deepPurple),
    );
  }

  void _showMedicineInputDialog(String type) {
    showDialog(
      context: context,
      builder: (context) {
        final diagController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Medicine Name for $type'),
          content: TextField(
            controller: diagController,
            decoration: const InputDecoration(hintText: 'e.g. Paracetamol'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _sendMessage(type, diagController.text);
              },
              child: const Text('Ask'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gemini Assistant'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              setState(() {
                _messages.clear();
                _messages.add({
                  'role': 'assistant',
                  'content':
                      'Hello! I am Gemini, your health assistant. Ask me about any medicine, syrup, or injection. I can provide info on usage, dosage, and precautions.',
                });
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Quick Actions
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickAction('Use', 'use'),
                  const SizedBox(width: 8),
                  _buildQuickAction('Dose', 'dose'),
                  const SizedBox(width: 8),
                  _buildQuickAction('Symptoms', 'symptoms'),
                  const SizedBox(width: 8),
                  _buildQuickAction('Precautions', 'precaution'),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.deepPurple : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isUser
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                        bottomLeft: isUser
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    child: MarkdownBody(
                      data: msg['content']!,
                      styleSheet:
                          MarkdownStyleSheet.fromTheme(
                            Theme.of(context),
                          ).copyWith(
                            p: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                            strong: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            listBullet: TextStyle(
                              color: isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your question...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
