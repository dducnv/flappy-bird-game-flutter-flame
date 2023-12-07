import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/widgets.dart';
import 'package:flappy_bird_flutter_flame/core/constants/constans.dart';
import 'package:flappy_bird_flutter_flame/game/game.dart';
import 'package:flappy_bird_flutter_flame/game/managers/audio_manager.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/enemy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Player extends SpriteAnimationComponent
    with
        HasGameRef<FlappyBird>,
        KeyboardHandler,
        CollisionCallbacks,
        GestureHitboxes {
  bool isPlaying = false;
  final imagesLoader = Images();
  double speedY = 0.0;
  double yMax = 0.0;
  bool isHit = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await _loadCharacterPlayer();
    debugMode = true;
    await add(RectangleHitbox.relative(
      Vector2(0.6, 0.8),
      parentSize: size,
      position: Vector2(size.x * 0.4, size.y * 0.2) / 2,
    ));
    size = Vector2(34, 24);

    position = Vector2(100, 300);
    anchor = Anchor.center;
    x = width;
    yMax = y;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position = Vector2(100, 300);

    x = width;
    y = gameSize.y - height - groundHeight;
    yMax = y;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isPlaying) {
      speedY += 600 * dt;

      angle += 0.5 * dt;

      position.add(Vector2(0, speedY * dt));
    }

    if (isHit) {
      speedY += 800 * dt;

      angle += 0.5 * dt;

      position.add(Vector2(0, speedY * dt));
    }

    if (isOnGround()) {
      y = yMax;
      speedY = 0.0;
      angle = 0.7;
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Enemy) {
      if (isPlaying) {
        isHit = true;
        isPlaying = false;
        AudioManager.instance.playSfx('hit.wav');
      }
    }
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        moveUp();
      }
    }
    return true;
  }

  bool isOnGround() {
    return (y >= yMax);
  }

  void moveUp() {
    if (isHit) return;
    AudioManager.instance.playSfx('wing.wav');
    if (!isPlaying) {
      isPlaying = true;
    }
    speedY = -250;
    angle = -0.5;
  }

  Future<void> _loadCharacterPlayer() async {
    final spriteSheet = SpriteSheet(
        image: await imagesLoader.load('sprites/blue-bird.png'),
        srcSize: Vector2(34, 24));

    final idleAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.1,
      to: 3,
    );

    animation = idleAnimation;
  }
}
