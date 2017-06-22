part of tetris;

class Tetromino extends PowerUpUser {

  List<Map<String, int>> _stones;
  List<Map<String, int>> _preview;
  List<Map<String, int>> _initialPosition;
  TetrisGame _model;
  Symbol _color;
  int _dc;
  int _dr;
  int _state;
  int _numberOfStates;
  List<List<List<int>>> _transitions;

  //TODO: refactor constructor messs to use benefits of builder, move initis
  //to initializer
  Tetromino(TetrisGame model, List<Map<String, int>> stonesConfig,
      List<List<List<int>>> transitions,
      List<Map<String, int>> preview,
      Symbol color)
      :_state = 0,
        _numberOfStates = 4 {
    _model = model;
    _stones = _calculateInitialPosition(stonesConfig);
    _initialPosition = _stones;
    _transitions = transitions;
    _preview = preview;
    _color = color;
  }

  ///
  /// Berechnet für den fallenden Tetromino die mittige start Position.
  /// @param List<Map<String, int>> stonesConfig
  ///
  List<Map<String, int>> _calculateInitialPosition(
      List<Map<String, int>> stonesConfig) {
    List<Map<String, int>> initialPosition = new List();
    stonesConfig.forEach((stone) {
      initialPosition.add(
          {'row': stone['row'], 'col': _model.sizeWidth ~/ 2 + stone['col']});
    });
    return initialPosition;
  }

  ///
  /// Tetromino Steine dem Feld hinzufügen.
  ///
  void addToField() {
    _stones.forEach((stone) {
      _model.field[stone['row']][stone['col']].isActive = true;
      _model.field[stone['row']][stone['col']].color = _color;
    });
  }

  ///
  /// Tetromino Steine vom Feld entfernen
  ///
  void removeFromField() {
    _stones.forEach((stone) {
      _model.field[stone['row']][stone['col']].isActive = false;
      _model.field[stone['row']][stone['col']].color = #empty;
    });
  }

  ///
  /// Setzt den Tetromino auf seine Anfangsposition (idR. am oberen Rand des
  /// Spielfelds) zurueck. Dabei wird der Rotationszustand auf den initialen
  /// Zustand zurueck gesetzt.
  ///
  void resetPosition() {
    _stones = _initialPosition;
    _state = 0;
  }

  ///
  /// Abstrakte Definition fuer die Drehung eines Tetrominos. Die Rotation ist
  /// fuer jeden Tetromino anders.
  ///
  void rotate(int direction) {
    // Die richtige Drehmatrix wird in Abhaengigkeit des Zustandes und der
    // Drehrichtung ausgewält.
    // if there are no transitions the tetromino can not be rotated
    if (_transitions.length == 0) {
      return;
    }
    List<List<int>> transition;
    int nextState = _state;

    if (direction > 0) {
      transition = _transitions.elementAt(_state);
      nextState = (_state + 1) % _numberOfStates;
    } else {
      (_state == 0) ? nextState = _numberOfStates - 1 : nextState--;
      transition = _transitions.elementAt(nextState);
    }
    List<Map<String, int>> move = new List();
    // Position des gedrehten Tetrominoes berechnen
    for (int i = 0; i < _stones.length; i++) {
      if (_stones[i]['row'] + direction * transition[i][0] < 0) return;
      move.add({'row': _stones[i]['row'] + direction * transition[i][0],
        'col': _stones[i]['col'] + direction * transition[i][1]});
    }
    // pruefen, ob Drehung Kollisionen verursacht, falls ja Drehung nicht moeglich
    if (!_collisionWithBorder(move) && !_collisionWithGround(move) &&
        !_collisionWithOtherTetromino(move)) {
      // durch die Drehung wird der Tetromino in den naechsten Zustand ueberfuehrt
      _state = nextState;
      _moveToNewPosition(move);
      _model.updateField();
    }
  }

  ///
  /// Bewegt den Tetromino und prüft auf Kollisionen
  ///
  void move() {
    // Bewegung berechnen
    var move = new List<Map<String, int>>();
    _stones.forEach((stone) {
      move.add({ 'row': stone['row'] + _dr, 'col': stone['col'] + _dc});
    });
    // pruefen, ob Bewegung Kollision verursacht
    // GameOver überprüfen
    (_collisionWithTop(move) && _collisionWithOtherTetromino(move)) ? _model
        .stop() : null;
    if (!_collisionWithBorder(move) && !_collisionWithGround(move) &&
        !_collisionWithOtherTetromino(move)) {
      // keine Kollisionen => Tetomino kann bewegt werden
      _moveToNewPosition(move);
    } else {
      _handleCollision(move);
    }
    _model.updateField();
  }

  ///
  /// Handelt die Kollosionen ab.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  void _handleCollision(List<Map<String, int>> move) {
   // Kollisionen mit den Seitenraender des Spielfelds muessen nicht extra
   // behandelt werden, da in diesem Fall eine Bewegung einfach nicht moeglich ist
    if (_collisionWithBorder(move)) {
      return;
    }
    if (_collisionWithGround(move)) {
      // falls der Tetrmino auf den Boden faellt wird er gesetzt
      _stones.forEach((stone) {
        _model.field[stone['row']][stone['col']].isActive = false;
      });
      _model.removeCompletedRows();
      consumeAllPowerUps({'tetrominoMove': move});
    } else if (_collisionWithOtherTetromino(move)) {
      bool movesSideways = (_dc != 0);
      if (movesSideways) {
        // ungueltige seitwaerts Bewegung rueckgaening machen
        move.forEach((piece) {
          piece['col'] -= _dc;
        });
        _moveToNewPosition(move);
        // Damit ist die Kollisionsbehandlung abgeschlossen. Da der aktuelle Stein
        // noch weiter nach untne bewegt werden kann, muss kein neuer
        // Tetromino fallen gelassen werden.
        return;
      } else {
        // Tetromino in der Position fest setzen
        _stones.forEach((stone) {
          _model.field[stone['row']][stone['col']].isActive = false;
        });
        // falls eine oder mehrere Reihen vervollstaendigt sind mussen diese
        // entfernt werden und alle Reihen darueber nachrutschen
        _model.removeCompletedRows();
        consumeAllPowerUps({'tetrominoMove': move});
      }
    }
    _model.dumpNextTetromino();
  }

  ///
  /// Bewegt den Tetromino zur nächsten Position.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  void _moveToNewPosition(List<Map<String, int>> move) {
    removeFromField();
    _stones = move;
    addToField();
  }

  ///
  /// Prüft auf Kollosionen mit dem Rand.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  bool _collisionWithBorder(List<Map<String, int>> move) {
    bool isCollision = false;
    move.forEach((stone) {
      if (stone['col'] < 0 || stone['col'] >= _model._fieldWidth) {
        isCollision = true;
      }
    });
    return isCollision;
  }

  ///
  /// Prüft auf Kollosionen mit dem Grund.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  bool _collisionWithGround(List<Map<String, int>> move) {
    bool isCollision = false;
    move.forEach((stone) {
      (stone['row'] >= _model.sizeHeight) ? isCollision = true : null;
    });
    return isCollision;
  }

  ///
  /// Prüft auf Kollosionen mit den oberen Rand.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  bool _collisionWithTop(List<Map<String, int>> move) {
    bool isCollision = false;
    move.forEach((stone) {
      (stone['row'] < 3) ? isCollision = true : null;
    });
    return isCollision;
  }

  ///
  /// Prüft auf Kollosionen mit Tetrominoes.
  /// @param List<Map<String, int>> move = Position des nächsten Tetrominoes
  ///
  bool _collisionWithOtherTetromino(List<Map<String, int>> move) {
    bool isCollision = false;
    // Alle Zellen des Moves pruefen, ob sie belegt und inaktiv sind. Falls
    // ja liegt eine Kollision mit einem bereits gesetzten Tetromino vor.
    move.forEach((stone) {
      if (stone['col'] >= 0 && stone['col'] < _model.sizeWidth) {
        if (_model.field[stone['row']][stone['col']].color != #empty &&
            !_model.field[stone['row']][stone['col']].isActive) {
          isCollision = true;
        }
      }
    });
    return isCollision;
  }

  ///
  /// Teilt dem Tetromino keine Bewegung mit, somit stoppt der Tetromino.
  ///
  void stop() {
    _dr = 0;
    _dc = 0;
  }

  ///
  /// Teilt dem Tetromino die Bewegung nach unten mit.
  ///
  void down() {
    _dr = 1;
    _dc = 0;
  }

  ///
  /// Teilt dem Tetromino die Bewegung nach links mit.
  ///
  void left() {
    _dr = 0;
    _dc = -1;
  }

  ///
  /// Teilt dem Tetromino die Bewegung nach rechts mit.
  ///
  void right() {
    _dr = 0;
    _dc = 1;
  }

  ///
  /// Gibt die Tetrominoes Steine zurück.
  ///
  get stones => _stones;

  ///
  /// Gibt die Tetrominoes Farbe zurück.
  ///
  get color => _color;

  ///
  /// Gibt die Tetrominoes Vorschau Steine zurück.
  ///
  get preview => _preview;
}