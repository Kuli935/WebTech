import 'package:tetris/tetris.dart';

/**
 * Hauptklasse um das Tetris Spiel zu starten.
 * Es wird ein neuer TetrisController erzeugt
 * aus dem Ordner controller die TetrisController.dart Datei.
 */
//main () => new TetrisController();

dynamic main() async {
  JsonReader reader = new JsonReader('game-config.json');
  await reader.loadGameConfiguration();
  new TetrisController(reader);
}