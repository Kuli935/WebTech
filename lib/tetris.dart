library tetris;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'src/controller/TetrisController.dart';
part 'src/controller/SwipeHandler.dart';
part 'src/view/TetrisView.dart';
part 'src/model/Tetromino.dart';
part 'src/model/Cell.dart';
part 'src/model/TetrisGame.dart';

/**
 * Definiert eine Tetris Spielkonstante, das n x m Feld.
 */
const gameHeight = 18; // -2 unsichtbare Reihen
const gameWidth = 10;

/**
 * Definiert die Größe des Feldes für das Nächster-Tetromino-Feld
 */
const extraFieldHeight = 4;
const extraFieldWidth = 4;
