import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird_flutter_flame/game/game.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/game_over_widget.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/launch_game_widget.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/player_menu.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: GameWidget.controlled(
        gameFactory: () => FlappyBird(),
        loadingBuilder: (conetxt) => const Center(
          child: SizedBox(
            width: 200,
            child: LinearProgressIndicator(),
          ),
        ),
        initialActiveOverlays: const [
          PlayerMenu.keyWidget,
        ],
        overlayBuilderMap: {
          LaunchGameWidget.keyWidget: (_, game) => LaunchGameWidget(
                gameRef: game as FlappyBird,
              ),
          PlayerMenu.keyWidget: (_, game) => PlayerMenu(
                gameRef: game as FlappyBird,
              ),
          GameOverWidget.keyWidget: (_, game) => GameOverWidget(
                gameRef: game as FlappyBird,
              ),
        },
      )),
    );
  }
}
