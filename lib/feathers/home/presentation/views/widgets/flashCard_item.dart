import 'package:flash_card/feathers/home/data/models/word_model.dart';
import 'package:flash_card/feathers/home/data/service/speech_service.dart';
import 'package:flash_card/feathers/home/presentation/view_model/flashCard_provider.dart';
import 'package:flash_card/sheard/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class FlashcardItem extends StatefulWidget {
  final WordModel word;

  const FlashcardItem({super.key, required this.word});

  static final SpeechService _speechService = SpeechService();

  @override
  State<FlashcardItem> createState() => _FlashcardItemState();
}

class _FlashcardItemState extends State<FlashcardItem> {
  bool isVissable = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 251, 233, 254),
            Color.fromARGB(255, 229, 254, 219),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE8EAF0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Positioned(
          //   bottom: -11,
          //   right: 1,
          //   child: Image.asset(
          //     'assets/image/stars2.png',
          //     height: 50,
          //     color: Colors.grey,
          //   ),
          // ),
          Consumer<FlashcardProvider>(
            builder: (context, Provider, child) {
              return Row(
                children: [
                  CustomText(text: '${Provider.currentIndex + 1}'),
                  CustomText(text: '/'),
                  CustomText(text: '${Provider.words.length}'),
                ],
              );
            },
          ),
          Positioned(
            top: -11,
            right: 1,
            child: Image.asset(
              'assets/image/stars2.png',
              height: 50,
              color: Colors.grey,
            ),
          ),
          Positioned(
            bottom: -11,
            left: 5,
            child: Image.asset(
              'assets/image/stars2.png',
              height: 50,
              color: Colors.grey,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () =>
                        FlashcardItem._speechService.speak(widget.word.word),
                    tooltip: 'Listen to pronunciation',
                    icon: const Icon(
                      Icons.volume_up_rounded,
                      color: Color(0xFF2563EB),
                      size: 28,
                    ),
                  ),
                  Flexible(
                    child: CustomText(
                      text: widget.word.word,
                      size: 32,
                      color: Color(0xff2563EB),
                      weight: FontWeight.bold,
                      family: 'Oswald',
                    ),
                  ),
                ],
              ),
              Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isVissable = !isVissable;
                      });
                    },
                    tooltip: isVissable
                        ? 'Hide translation'
                        : 'Show translation',
                    icon: isVissable
                        ? Icon(Icons.visibility, size: 17)
                        : Icon(Icons.visibility_off, size: 17),
                  ),
                  isVissable
                      ? CustomText(
                          text: widget.word.translation,
                          size: 20,
                          color: Color(0xFF1E293B),
                          weight: FontWeight.w500,
                          family: 'Oswald',
                        )
                      : SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 28),
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Gap(24),
              CustomText(
                text: widget.word.example,
                family: 'Oswald',
                size: 16,
                color: Color(0xff6A748B),
                hight: 1.6,
                weight: FontWeight.w400,
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () =>
                    FlashcardItem._speechService.speak(widget.word.example),
                tooltip: 'Listen to pronunciation',
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: Color(0xFF2563EB),
                  size: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
