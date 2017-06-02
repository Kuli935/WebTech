library tetris;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'src/controller/TetrisController.dart';
part 'src/view/TetrisView.dart';
part 'src/model/Tetromino.dart';
//part 'package:tetris/src/model/tetrominoes/OTetromino.dart';
//part 'package:tetris/src/model/tetrominoes/ITetromino.dart';
//part 'package:tetris/src/model/tetrominoes/TTetromino.dart';
//part 'package:tetris/src/model/tetrominoes/LTetromino.dart';
//part 'package:tetris/src/model/tetrominoes/JTetromino.dart';
//part 'package:tetris/src/model/tetrominoes/STetromino.dart';
//part 'package:tetris/src/model/tetrominoes/ZTetromino.dart';
part 'package:tetris/src/model/powerUps/PowerUp.dart';
part 'package:tetris/src/model/powerUps/tetrominoPowerUps/RemoveAllRowsOfTetromino.dart';
part 'package:tetris/src/model/powerUps/PowerUpUser.dart';
part 'package:tetris/src/model/Level.dart';
part 'package:tetris/src/util/readers/JsonReader.dart';
part 'package:tetris/src/util/builders/TetrisGameBuilder.dart';
part 'package:tetris/src/util/readers/Reader.dart';
part 'package:tetris/src/util/builders/Builder.dart';
part 'package:tetris/src/util/builders/TetrominoBuilder.dart';
part 'package:tetris/src/util/builders/LevelBuilder.dart';
part 'package:tetris/src/util/builders/PowerUpBuilder.dart';
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
