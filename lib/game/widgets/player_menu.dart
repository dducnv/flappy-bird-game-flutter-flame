import 'package:flappy_bird_flutter_flame/game/flappy_bird.dart';
import 'package:flappy_bird_flutter_flame/game/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerMenu extends StatelessWidget {
  const PlayerMenu({Key? key, required this.gameRef}) : super(key: key);
  static const String keyWidget = 'player_menu';
  final FlappyBird gameRef;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: gameRef.playerProvider,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Selector<PlayerProvider, int>(
                      selector: (_, playerData) => playerData.score,
                      builder: (_, scorePlaying, __) {
                        return Row(
                          children: scorePlaying.toString().split('').map((e) {
                            return Image.asset(
                              'assets/images/sprites/$e.png',
                              height: 50,
                            );
                          }).toList(),
                        );
                      }),
                  Selector<PlayerProvider, bool>(
                      selector: (_, playerData) => playerData.paused,
                      builder: (_, paused, __) {
                        return IconButton(
                          onPressed: () {
                            gameRef.pauseGame();
                          },
                          icon: paused
                              ? const Icon(Icons.play_arrow)
                              : const Icon(Icons.pause),
                        );
                      }),
                ],
              ),
            ],
          ),
        ));
  }
}
