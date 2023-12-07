import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flappy_bird_flutter_flame/core/constants/constans.dart';
import 'package:flappy_bird_flutter_flame/game/managers/enemy_manager.dart';
import 'package:flappy_bird_flutter_flame/game/providers/player_provider.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/enemy.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/player.dart';
import 'package:flappy_bird_flutter_flame/game/word_game.dart';

class FlappyBird extends FlameGame
    with TapDetector, HasCollisionDetection, HasKeyboardHandlerComponents {
  FlappyBird({
    super.children,
    super.camera,
  });
  late PlayerProvider playerProvider;
  final WorldGame _world = WorldGame();
  final GroundGame _ground = GroundGame();
  final Player player = Player();
  Timer interval = Timer(pipeInterval, repeat: true);
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(_world);

    add(_ground);

    playerProvider = PlayerProvider();
    interval.onTick = () {
      add(EnemyManager());
    };
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (playerProvider.paused) {
      return;
    }
    player.moveUp();
  }

  void pauseGame() {
    if (playerProvider.paused) {
      resumeEngine();
      playerProvider.paused = false;
    } else {
      pauseEngine();
      playerProvider.paused = true;
    }
  }
}
