import 'package:flash_card/feathers/home/data/models/word_model.dart';
import 'package:flash_card/feathers/home/presentation/view_model/flashCard_provider.dart';
import 'package:flash_card/feathers/home/presentation/views/widgets/custom_text_field.dart';
import 'package:flash_card/sheard/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const AddWordDialog(),
    );
  }

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  late final TextEditingController _wordController;
  late final TextEditingController _translationController;
  late final TextEditingController _exampleController;

  static const Color primaryColor = Color(0xFF6366F1);
  static const Color textColor = Color(0xFF1E293B);
  static const Color subtitleColor = Color(0xFF64748B);

  @override
  void initState() {
    super.initState();
    _wordController = TextEditingController();
    _translationController = TextEditingController();
    _exampleController = TextEditingController();
  }

  @override
  void dispose() {
    _wordController.dispose();
    _translationController.dispose();
    _exampleController.dispose();
    super.dispose();
  }

  void _saveWord() {
    final word = _wordController.text.trim();
    final translation = _translationController.text.trim();
    final example = _exampleController.text.trim();

    if (word.isEmpty || translation.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please enter the word and its translation'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final newWord = WordModel(
      word: word,
      translation: translation,
      example: example,
    );

    context.read<FlashcardProvider>().addWord(newWord);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      content: SizedBox(
        width: 420,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 22),
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.library_add_rounded,
                        color: primaryColor,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add New Word',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Build your vocabulary, one word at a time.',
                            style: TextStyle(
                              fontSize: 12,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close',
                      icon: const Icon(
                        Icons.close_rounded,
                        color: subtitleColor,
                      ),
                    ),
                  ],
                ),
              ),

              // Form
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionLabel(
                      'ENGLISH WORD / PHRASE',
                      Icons.language_rounded,
                    ),
                    const SizedBox(height: 10),
                    CustomInputField(
                      controller: _wordController,
                      label: 'English Word / Phrase',
                      hint: 'e.g., Accomplish',
                      icon: Icons.translate_rounded,
                      textDirection: TextDirection.ltr,
                    ),

                    const SizedBox(height: 22),

                    _buildSectionLabel(
                      'ARABIC TRANSLATION',
                      Icons.g_translate_rounded,
                    ),
                    const SizedBox(height: 10),
                    CustomInputField(
                      controller: _translationController,
                      label: 'Arabic Translation',
                      hint: 'مثال: ينجز / يحقق',
                      icon: Icons.translate_rounded,
                      textDirection: TextDirection.rtl,
                    ),

                    const SizedBox(height: 22),

                    _buildSectionLabel(
                      'EXAMPLE SENTENCE',
                      Icons.menu_book_rounded,
                    ),
                    const SizedBox(height: 10),
                    CustomInputField(
                      controller: _exampleController,
                      label: 'Example Sentence (Optional)',
                      hint: 'She worked hard to accomplish her goals.',
                      icon: Icons.notes_rounded,
                      textDirection: TextDirection.ltr,
                      maxLines: 3,
                    ),

                    const SizedBox(height: 28),

                    // Actions
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: subtitleColor,
                              side: const BorderSide(color: Color(0xFFE2E8F0)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: _saveWord,
                            icon: const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 20,
                            ),
                            label: const Text('Save Word'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 16, color: primaryColor),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.7,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }
}
