import 'package:flash_card/feathers/home/presentation/views/widgets/add_word_dialog.dart';
import 'package:flash_card/feathers/home/presentation/views/widgets/floatingAction.dart';
import 'package:flash_card/feathers/home/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF202A44),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.style_rounded, size: 25),
            SizedBox(width: 10),
            Text(
              'Flash Cards',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
      body: const HomeViewBody(),
      floatingActionButton: const Floatingaction(),
    );
  }
}
