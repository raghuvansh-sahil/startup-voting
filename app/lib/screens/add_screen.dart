import 'package:app/models/ai_response.dart';
import 'package:app/models/startup.dart';
import 'package:app/services/network_handler.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _startupNameController = TextEditingController();
  final TextEditingController _taglineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool isLoading = false;
  AIResponse? aiResponse;

  void _saveData() async {
    setState(() {
      isLoading = true;
    });

    String startupName = _startupNameController.text.trim();
    String tagline = _taglineController.text.trim();
    String description = _descriptionController.text.trim();

    final response = await NetworkHandler.insertStartup(
      Startup(
        id: 0,
        startupName: startupName,
        tagline: tagline,
        description: description,
        voteCount: 0,
        rating: 0,
      ),
    );

    setState(() {
      aiResponse = response;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _startupNameController.dispose();
    _taglineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _startupNameController,
              decoration: InputDecoration(
                labelText: 'Startup Name',
                border: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taglineController,
              decoration: InputDecoration(
                labelText: 'Tagline',
                border: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(borderSide: BorderSide(width: 1.0)),
              ),
              maxLines: null,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: _saveData,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (aiResponse != null) ...[
            const SizedBox(height: 20),
            if (isLoading) ...[
              const Center(child: CircularProgressIndicator()),
            ] else if (aiResponse != null) ...[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Card.outlined(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              aiResponse?.explanation ?? '',
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'LibertinusSans',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
