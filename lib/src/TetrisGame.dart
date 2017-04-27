part of tetris;

/**
 * Definiert ein Tetris Spiel. Eine Tetris Spielkonstante ist das n x m Feld.
 */
class TetrisGame {
  // Tetris Stein
  Tetromino _tetris;

  // Die Feldgröße des Spiels (n x m Feld)
  final int _sizeHeight;
  final int _sizeWidth;

  // Die Feldgröße für nächsten Tetris Stein (n x m Feld)
  final int _nextStoneFieldHeight;
  final int _nextStoneFieldWidth;

  // interne Representation des Spielfelds
  List<List<Cell>> _field;

  // Spielzustand #running or #stopped.
  Symbol _gamestate;

  /**
   * Gibt an, ob das Spiel gestoppt wird
   */
  bool get stopped => _gamestate == #stopped;

  /**
   * Gibt an, ob das Spiel läuft
   */
  bool get running => _gamestate == #running;

  /**
   * Startet des Spiel
   */
  void start() {
    _gamestate = #running;
  }

  /**
   * Stopt das Spiel
   */
  void stop() {
    _gamestate = #stopped;
  }

  /**
   * Konstruktor um ein neues Tetris Spiel zu erzeugen
   */
  TetrisGame(this._sizeHeight, this._sizeWidth, this._nextStoneFieldHeight,
      this._nextStoneFieldWidth) {
    start();
    this._field = new Iterable.generate(sizeHeight, (row) {
      return new Iterable.generate(
          sizeWidth, (col) => new Cell(row, col, #empty)).toList();
    }).toList();
    _tetris = new Tetromino.on(this);
    stop();
  }

  /**
   * Returns eine Representation des Spielfeld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get field {
    List<List<Symbol>> fieldRepresentation = new List();
    for (int row = 0; row < this._field.length; row++) {
      List<Symbol> newRow = new List();
      for (int col = 0; col < this._field[row].length; col++) {
        newRow.add(this._field[row][col].color);
      }
      fieldRepresentation.add(newRow);
    }
    return fieldRepresentation;
  }

  /**
   * Interne Repraesentation des Spielfelds aktualisieren.
   * Muss nach jeder Aenderung am Zustand des Spielfeldes (z.B. Bewegen eines
   * Tetrominoes) aufgerufen werden.
   */
  void updateField() {
    //den aktuellen Tetromino von der alten Position entfernen
    this._field.forEach((row) {
      row.forEach((cell) {
        if (cell.isActive) {
          cell.color = #empty;
        }
      });
    });
    //den aktuellen Tetromino an der neuen Position zeichnen
    this._tetris._stone.forEach((piece) {
      this._field[piece['row']][piece['col']].color = this._tetris._stoneColor;
    });
  }

  /**
   * Returns Nächster-Tetris-Stein-Feld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get nextStoneField {
    var _nextStoneField = new Iterable.generate(nextStoneFieldHeight, (row) {
      return new Iterable.generate(nextStoneFieldWidth, (col) => #empty)
          .toList();
    }).toList();
    // Tetris Stein setzen
    _tetris.nextstone.forEach((s) {
      final r = s['row'];
      final c = s['col'];
      if (r < 0 || r >= nextStoneFieldHeight) return;
      if (c < 0 || c >= nextStoneFieldWidth) return;
      _nextStoneField[r][c] = _tetris.nextstoneColor;
    });
    return _nextStoneField;
  }

  /**
   * Bewegungensstatus für den Tetris Stein [down], [left], [right].
   * Bewegungen sind nur im Status [running] möglich.
   */
  void moveTetris() {
    if (running) tetris.move();
  }

  /**
   * Returns den Tetris Stein.
   */
  Tetromino get tetris => _tetris;

  /**
   * Returns die Größe des Spielffeldes. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeHeight => _sizeHeight;

  int get sizeWidth => _sizeWidth;

  /**
   * Returns die Größe des Feldes für den nächsten Stein.
   */
  int get nextStoneFieldHeight => _nextStoneFieldHeight;

  int get nextStoneFieldWidth => _nextStoneFieldWidth;
}
