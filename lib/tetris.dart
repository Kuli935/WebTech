library tetris;

import 'dart:html';
import 'dart:async';
import 'dart:math';

part 'src/Tetromino.dart';
part 'src/TetrisController.dart';
part 'src/TetrisView.dart';
part 'src/SwipeHandler.dart';
part 'src/Cell.dart';
part 'src/TetrisGame.dart';

/**
 * Definiert eine Tetris Spielkonstante, das n x m Feld.
 */
const gameHeight = 16;
const gameWidth = 10;

/**
 * Definiert die Größe des Feldes für den nächsten Tetris Stein
 */
const nextStoneFieldHeight = 4;
const nextStoneFieldWidth = 4;
