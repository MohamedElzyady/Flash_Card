import 'package:flash_card/feathers/home/presentation/view_model/flashCard_provider.dart';
import 'package:flash_card/feathers/home/presentation/views/widgets/flashCard_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlashcardStack extends StatefulWidget {
  const FlashcardStack({super.key});

  @override
  State<FlashcardStack> createState() => _FlashcardStackState();
}

class _FlashcardStackState extends State<FlashcardStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Animation<Offset>? _animation;

  Offset _position = Offset.zero;
  bool _isAnimating = false;
  bool _shouldChangeWord = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _controller.addListener(() {
      if (_animation == null || !mounted) return;

      setState(() {
        _position = _animation!.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status != AnimationStatus.completed || !mounted) return;

      final provider = context.read<FlashcardProvider>();

      if (_shouldChangeWord) {
        if (_position.dx < 0 && provider.hasNext) {
          provider.nextWord();
        } else if (_position.dx > 0 && provider.hasPrevious) {
          provider.previousWord();
        }
      }

      setState(() {
        _position = Offset.zero;
        _animation = null;
        _isAnimating = false;
        _shouldChangeWord = false;
      });
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (_isAnimating) return;

    setState(() {
      _position += details.delta;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    if (_isAnimating) return;

    final provider = context.read<FlashcardProvider>();
    final screenWidth = MediaQuery.sizeOf(context).width;

    final canMoveNext = _position.dx < 0 && provider.hasNext;
    final canMovePrevious = _position.dx > 0 && provider.hasPrevious;

    final shouldDismiss =
        _position.dx.abs() > screenWidth * 0.25 &&
        (canMoveNext || canMovePrevious);

    if (shouldDismiss) {
      _shouldChangeWord = true;

      final direction = _position.dx.sign;

      _animateCard(Offset(direction * screenWidth * 1.3, _position.dy * 0.8));
    } else {
      _shouldChangeWord = false;
      _animateCard(Offset.zero);
    }
  }

  void _animateCard(Offset target) {
    _isAnimating = true;

    _animation = Tween<Offset>(
      begin: _position,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(
      builder: (context, provider, child) {
        if (provider.words.isEmpty) {
          return const Center(child: Text('No words available'));
        }
        final currentIndex = provider.currentIndex;
        final currentWord = provider.currentWord;
        final dragProgress = (_position.dx.abs() / 250).clamp(0.0, 1.0);
        final nextWordIndex = _position.dx > 0
            ? currentIndex - 1
            : currentIndex + 1;
        final canShowBackgroundCard =
            nextWordIndex >= 0 && nextWordIndex < provider.words.length;
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (canShowBackgroundCard)
                  Transform.translate(
                    offset: Offset(0, 18 * (1 - dragProgress)),
                    child: Transform.scale(
                      scale: 0.94 + (0.06 * dragProgress),
                      child: FlashcardItem(word: provider.words[nextWordIndex]),
                    ),
                  ),
                GestureDetector(
                  onPanUpdate: _onPanUpdate,
                  onPanEnd: _onPanEnd,
                  child: Transform.translate(
                    offset: _position,
                    child: Transform.rotate(
                      angle: _position.dx / 700,
                      child: Stack(children: [FlashcardItem(word: currentWord)]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
