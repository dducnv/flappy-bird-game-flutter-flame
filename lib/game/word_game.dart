import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird_flutter_flame/game/game.dart';
import 'package:flutter/material.dart';

class WorldGame extends ParallaxComponent<FlappyBird>
    with HasGameRef<FlappyBird> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('sprites/background-day.png'),
      ],
    );
  }
}

class GroundGame extends ParallaxComponent<FlappyBird>
    with HasGameRef<FlappyBird> {
  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('sprites/base.png'),
      ],
      repeat: ImageRepeat.repeatX,
      fill: LayerFill.none,
      baseVelocity: Vector2(150, 0),
      velocityMultiplierDelta: Vector2(1.1, 0),
    );
  }
}
