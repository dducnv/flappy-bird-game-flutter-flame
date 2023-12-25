import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/timer.dart';
import 'package:flappy_bird_flutter_flame/core/constants/constans.dart';
import 'package:flappy_bird_flutter_flame/game/managers/enemy_manager.dart';
import 'package:flappy_bird_flutter_flame/game/providers/player_provider.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/enemy.dart';
import 'package:flappy_bird_flutter_flame/game/sprites/player.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/game_over_widget.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/launch_game_widget.dart';
import 'package:flappy_bird_flutter_flame/game/widgets/player_menu.dart';
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
  bool isGameStart = false;
  Timer interval = Timer(pipeInterval, repeat: true);
  late EnemyManager enemyManager;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    priority = 2;
    add(_world);

    add(_ground);

    playerProvider = PlayerProvider();
    interval.onTick = () {
      enemyManager = EnemyManager();
      add(enemyManager);
    };
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameStart) {
      interval.update(dt);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (playerProvider.paused) {
      return;
    }
    player.moveUp();
  }

  void gameOver() {
    playerProvider.paused = true;
    overlays.add(GameOverWidget.keyWidget);
    pauseEngine();
  }

  void startGame() {
    overlays.remove(LaunchGameWidget.keyWidget);
    overlays.add(PlayerMenu.keyWidget);
    playerProvider.paused = false;
    isGameStart = true;
    resumeEngine();
  }

  void gameOverScreen() {
    playerProvider.paused = true;
    overlays.add(GameOverWidget.keyWidget);
    interval.stop();
    pauseEngine();
  }

  void pushToLauchGame() {
    overlays.remove(PlayerMenu.keyWidget);
    overlays.remove(GameOverWidget.keyWidget);
    overlays.add(LaunchGameWidget.keyWidget);
    player.reset();
    isGameStart = false;
    remove(enemyManager);
    resumeEngine();
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
