part of tetris;

/**
 * Definiert ein Tetris Spiel. Eine Tetris Spielkonstante ist das n x m Feld.
 */
class TetrisGame {
  // Tetromino = Tetris Stein
  Tetromino _tetromino;

  // Die Feldgröße des Spiels (n x m Feld)
  final int _sizeHeight;
  final int _sizeWidth;

  // Die Feldgröße für das Nächste-Tetromino-Feld (n x m Feld)
  final int _nextStoneFieldHeight;
  final int _nextStoneFieldWidth;

// interne Representation des Spielfelds
  List<List<Cell>> _field;

  // Spielzustand #running or #stopped.
  Symbol _gamestate;

  // der aktuelle Punktestand
  num _score;

  /**
   * Gibt an, ob das Spiel beendet ist
   */
  bool get stopped => _gamestate == #stopped;

  /**
   * Gibt an, ob das Spiel pausiert ist
   */
  bool get paused => _gamestate == #paused;

  /**
   * Gibt an, ob das Spiel läuft
   */
  bool get running => _gamestate == #running;

  num get score => _score;

  /**
   * Startet des Spiel
   */
  void start() {
    _gamestate = #running;
  }

  /**
   * Pausiert das Spiel
   */
  void pause() {
    _gamestate = #paused;
  }

  /**
   * Stopt das Spiel
   */
  void stop() {
    _gamestate = #stopped;
  }

  /**
   * Konstruktor um ein neues Tetris Spiel zu erzeugen
   * @param int _sizeHeight = Höhe des Spielfeldes
   * @param int _sizeWidth = Breite des Spielfeldes
   * @param int _nextStoneFieldHeight = Höhe des Nächsten-Tetromino-Feldes
   * @param int _nextStoneFieldWidth = Breite des Nächsten-Tetromino-Feldes
   */
  TetrisGame(this._sizeHeight, this._sizeWidth, this._nextStoneFieldHeight,
      this._nextStoneFieldWidth) {
    start();
    this._score = 0;
    this._field = new Iterable.generate(sizeHeight, (row) {
      return new Iterable.generate(
          sizeWidth, (col) => new Cell(row, col, #empty)).toList();
    }).toList();
    _tetromino = new Tetromino.on(this);
    stop();
  }

  /**

   * Gibt eine Representation des Spielfeld als eine Liste von Listen zurück.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   * @return Representation des Spielfeld als eine Liste von Listen
   */

  List<List<Symbol>> get fieldRepresentation {
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
    this._tetromino._stone.forEach((piece) {
      this._field[piece['row']][piece['col']].color = this._tetromino._stoneColor;
    });
  }

  /**
   * Gibt das Nächster-Tetromino-Feld als eine Liste von Listen zurück.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   * @return Nächster-Tetromino-Feld als eine Liste von Listen
   */
  List<List<Symbol>> get nextStoneField {
    var _nextStoneField = new Iterable.generate(nextStoneFieldHeight, (row) {
      return new Iterable.generate(nextStoneFieldWidth, (col) => #empty)
          .toList();
    }).toList();
    // Tetromino setzen
    tetromino.nextstone.forEach((s) {
      final r = s['row'];
      final c = s['col'];
      if (r < 0 || r >= nextStoneFieldHeight) return;
      if (c < 0 || c >= nextStoneFieldWidth) return;
      _nextStoneField[r][c] = _tetromino.nextstoneColor;
    });
    return _nextStoneField;
  }

  /**
   * Bewegungensstatus für den Tetromino [down], [left], [right].
   * Bewegungen sind nur im Status [running] möglich.
   */
  void moveTetromino() {
    if (running) tetromino.move();
  }

  /**
   * Pausiert das Spiel und gibt es beim nächsten Aufruf wieder frei.
   */
  void pauseTetromino(){
    // Wenn das Spiel läuft, dann Pausieren
    if (running){
      pause();
      tetromino.stop();

      // Wenn das Spiel gestoppt ist, dann freigeben
    } else if (paused) {
      start();
      tetromino.down();
    }
  }

  /**
   * Gibt eine Liste mit den Indizes aller Zeilen die vollstaendig sind
   * zurueck. Eine Reihe gilt als vollstaendig, falls alle ihre Zellen
   * gefuellt und inaktiv sind.
   */
  List<num> getIndexOfCompletedRows(){
    List<num> rowsCompleted = new List();
    //fuer jede Zeile pruefen, ob alle cellen belegt und inaktiv sind
    for(num rowIndex=0; rowIndex < this.field.length; rowIndex++){
      bool isCompleted = true;
      for(num colIndex=0; colIndex < this.field[rowIndex].length; colIndex++){
        Cell cell = this.field[rowIndex][colIndex];
        if(cell.color == #empty || cell.isActive){
          isCompleted = false;
          break;
        }
      }
      (isCompleted == true) ? rowsCompleted.add(rowIndex) : null;
    }
    return rowsCompleted;
  }

  /**
   * Entfernt alle vollstaendigen Reihen vom Spielfeld.
   */
  void removeCompletedRows(){
    List<num> completedRows = this.getIndexOfCompletedRows();
    //falls keine Reihen vervollständigt wurden, muss nichts entfernt werden
    if(completedRows.length == 0){
      return;
    }
    //increase score
    this._score += this.calculateScoreOfMove(completedRows.length);
    //remove completed rows
    completedRows.forEach((rowIndex) {
      this.field[rowIndex].forEach((cell){
        cell.color = #empty;
        cell.isActive = false;
      });
    });
    //move upper rows down
    completedRows.sort((a, b) => (a-b).toInt());
    completedRows.forEach((rowIndex){
      for(num i=rowIndex-1; i >= 0; i--){
        this.field[i].forEach((cell) {
          this.field[i+1][cell.col].color = cell.color;
          cell.color = #empty;
        });
      }
    });
  }

  /**
   * Berechnet wie viele Punkte das letzte vervollstaendigen wert ist.
   */
  num calculateScoreOfMove(num rowsCompleted){
    //TODO: change  score formula later to account for the current level
    num score;
    switch(rowsCompleted){
      case 1:
        score = 40;
        break;
      case 2:
        score = 100;
        break;
      case 3:
        score = 300;
        break;
      case 4:
        score = 1200;
        break;
    }
    return score;
  }

  /**
   * Gibt die interne Representation des Feldes zurück.
   */

  List<List<Cell>> get field => this._field;

  /**
   * Gibt den Tetromino zurück.
   */
  Tetromino get tetromino => _tetromino;

  /**
   * Gibt die Höhe des Spielfeldes zurück. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeHeight => _sizeHeight;

  /**
   * Gibt die Breite des Spielfeldes zurück. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeWidth => _sizeWidth;

  /**
   * Gibt die Höhe des Feldes für den Nächsten-Tetromino-Feld zurück.
   */
  int get nextStoneFieldHeight => _nextStoneFieldHeight;

  /**
   * Gibt die Breite des Feldes für den Nächsten-Tetromino-Feld zurück.
   */
  int get nextStoneFieldWidth => _nextStoneFieldWidth;
}
