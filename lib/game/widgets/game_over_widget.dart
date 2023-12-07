import 'dart:ui';

import 'package:flappy_bird_flutter_flame/game/flappy_bird.dart';
import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  static const String keyWidget = 'game_over_widget';
  const GameOverWidget({Key? key, required this.gameRef}) : super(key: key);
  final FlappyBird gameRef;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.black.withAlpha(100),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Game Over',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      gameRef.playerProvider.score.toString(),
                      style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Chơi lại'),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
