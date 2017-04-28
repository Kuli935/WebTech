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
const gameHeight = 16;
const gameWidth = 10;

/**
 * Definiert die Größe des Feldes für den nächsten Tetris Stein
 */
const nextStoneFieldHeight = 4;
const nextStoneFieldWidth = 4;
