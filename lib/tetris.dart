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

