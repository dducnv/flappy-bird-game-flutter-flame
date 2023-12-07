import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird_flutter_flame/core/enums/enum.dart';
import 'package:flappy_bird_flutter_flame/game/flappy_bird.dart';
import 'package:flappy_bird_flutter_flame/game/managers/audio_manager.dart';

const double columnH = 320;
const double columnW = 52;

// class Enemy extends SpriteComponent with HasGameRef<FlappyBird> {
//   @override
//   Future<void> onLoad() async {
//     await super.onLoad();
//     add(PipeTop());
//     add(PipeBottom());
//   }
// }

class Enemy extends SpriteComponent
    with HasGameRef<FlappyBird>, CollisionCallbacks {
  Enemy({
    required this.pipePosition,
    required this.height,
  });

  @override
  final double height;
  final PipePosition pipePosition;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final columnTop = await Flame.images.load('sprites/pipe-top.png');
    final columnBottom = await Flame.images.load('sprites/pipe-green.png');
    size = Vector2(columnW, height);
    debugMode = true;
    add(
      RectangleHitbox(
        size: size,
        position: Vector2(0, 0),
      ),
    );
    switch (pipePosition) {
      case PipePosition.top:
        position.y = 0;
        sprite = Sprite(columnTop);
        break;
      case PipePosition.bottom:
        y = gameRef.size.y - height - 112;
        sprite = Sprite(columnBottom);
        break;
    }
  }
}
