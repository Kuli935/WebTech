library tetris;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'dart:convert';

part 'src/model.dart';
part 'src/control.dart';
part 'src/view.dart';

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

