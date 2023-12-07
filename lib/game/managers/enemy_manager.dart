import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappy_bird_flutter_flame/core/enums/enum.dart';
import 'package:flappy_bird_flutter_flame/game/flappy_bird.dart';
import 'package:flappy_bird_flutter_flame/game/managers/audio_manager.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/enemy.dart';

class EnemyManager extends PositionComponent with HasGameRef<FlappyBird> {
  static final Random _rng = Random();

  double groundHeight = 100;
  double columnH = 320;
  double columnW = 52;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position.x = gameRef.size.x;

    const spacing = 250;
    double centerY =
        _rng.nextDouble() * (gameRef.size.y - groundHeight - spacing) +
            spacing / 2;
    final heightMinusGround = gameRef.size.y - groundHeight;
    if (centerY < 100) {
      centerY = 100;
    }

// Đảm bảo chiều cao cột thừa cho spacing 100
    const minHeight = spacing / 2 + 100;
    final height = max(centerY - spacing / 2, minHeight);
    addAll([
      Enemy(
        height: height,
        pipePosition: PipePosition.top,
      ),
      Enemy(
        height: heightMinusGround - height - spacing / 2,
        pipePosition: PipePosition.bottom,
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 150 * dt;
    if (x < -columnW) {
      if (gameRef.player.isPlaying) {
        gameRef.playerProvider.score++;
        AudioManager.instance.playSfx('point.wav');
      }
      removeFromParent();
    }
  }
}
