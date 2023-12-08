import 'dart:ui';

import 'package:flappy_bird_flutter_flame/game/flappy_bird.dart';
import 'package:flutter/material.dart';

class LaunchGameWidget extends StatelessWidget {
  const LaunchGameWidget({Key? key, required this.gameRef}) : super(key: key);
  static const String keyWidget = 'launch_game_widget';
  final FlappyBird gameRef;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Center(
          child: InkWell(
              onTap: () {
                gameRef.startGame();
              },
              child: Image.asset("assets/images/sprites/message.png")),
        ));
  }
}
