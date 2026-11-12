import 'package:flash_card/feathers/home/presentation/views/widgets/add_word_dialog.dart';
import 'package:flutter/material.dart';

class Floatingaction extends StatelessWidget {
  const Floatingaction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AddWordDialog.show(context);
      },
      backgroundColor: const Color(0xFF6C63FF),
      foregroundColor: Colors.white,
      elevation: 5,
      tooltip: 'Add a new word',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: const Icon(Icons.add_rounded, size: 32),
    );
  }
}
