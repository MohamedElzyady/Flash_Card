import 'package:flash_card/feathers/home/presentation/views/widgets/flashcard_stack.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Stack(children: [FlashcardStack()])),
        ],
      ),
    );
  }
}
