part of tetris;

/**
 * Definiert ein Tetris Spiel.
 */
class TetrisGame extends PowerUpUser{
  // Tetromino = Tetris Stein
  Tetromino _tetromino;

  // Die Feldgröße des Spiels (n x m Feld)
  final int _fieldHeight;
  final int _fieldWidth;

  // Die Feldgröße für das Extra-Tetromino-Feld (n x m Feld)
  final int _extraFieldHeight = 4;
  final int _extraFieldWidth = 4;

  // Reader
  Reader _configReader;

  // Level Warteschlange
  PriorityQueue<Level> _levels;

  // Aktuelles Level
  Level _currentLevel;

  // Anzahl der abgeschlossenen Level
  int _levelCount;

  // Zaehlt die Anzahl der breits gefallenen Tetrominoes
  int _tetrominoCount;

  // Anzahl an gelöschte Reihen
  int _numberOfRowsCleared;

  // Tetromino Warteschlange
  ListQueue<Tetromino> _tetrominoQueue;

  //Holdbox (leer oder mit Tetromino gefuellt)
  Tetromino _tetrominoOnHold;

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

  /**
   * Gibt den aktuellen Punktestand zurück
   */
  num get score => _score;

  /**
   * Gibt die Nummer an gelöschten Reihen zurück.
   */
  int get numberOfRowsCleared => _numberOfRowsCleared;

  /**
   * Startet des Spiel
   */
  void start() {
    _startNextLevel();
    _fillTetrominoeQueue();
    dumpNextTetromino();
    _gamestate = #running;
  }

  /**
   * Pausiert das Spiel
   */
  void pause() {
    _gamestate = #paused;
  }

  /**
   * Fuehrt das Spiel nach einer Pause fort.
   */
  void resume(){
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
   * @param int _sizeHeight = Höhe des Spielfeldes
   * @param int _sizeWidth = Breite des Spielfeldes
   * @param int _extraFieldHeight = Höhe des Extra-Tetromino-Feldes
   * @param int _extraFieldWidth = Breite des Extra-Tetromino-Feldes
   */
  TetrisGame(int fieldWidth, int fieldHeight, Reader configReader):
    _fieldWidth = fieldWidth, _fieldHeight = fieldHeight,
    _configReader = configReader{
    _score = 0;
    _levelCount = 1;
    _tetrominoCount = 0;
    _tetrominoOnHold = null;
    _numberOfRowsCleared = 0;
    this._field = new Iterable.generate(_fieldHeight, (row) {
      return new Iterable.generate(
          _fieldWidth, (col) => new Cell(row, col, #empty)).toList();
    }).toList();
    _tetrominoQueue = new ListQueue();
  }

  /**
   * Füllt die Tetromino Warteschlange
   */
  void _fillTetrominoeQueue(){
    Set<Tetromino> setOfTetrominoes = new Set();
    _currentLevel.idsOfAvailableTetrominoes.forEach((tetrominoId){
      setOfTetrominoes.add(new TetrominoBuilder(_configReader, this).build(tetrominoId));
    });
    List<Tetromino> shuffledTetrominoes = setOfTetrominoes.toList();
    shuffledTetrominoes.shuffle();
    _tetrominoQueue.addAll(shuffledTetrominoes);
  }

  /**
   * Fügt dem Spielfeld den nächsten fallenden Tetromino hinzu
   */
  void dumpNextTetromino(){
    _tetromino = _tetrominoQueue.removeFirst();
    if(_tetrominoQueue.isEmpty){
      _fillTetrominoeQueue();
    }
    _tetrominoCount++;
    _tetromino.addToField();
    _tetromino.down();
  }

  /**
  * Methode für den direkten Fall des Tetrominoes.
  */
  void hardDropCurrentTetromino(){
    int currentTetrominoCout = this._tetrominoCount;
    while(currentTetrominoCout == this._tetrominoCount){
      this.moveTetromino();
    }
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
    if(_currentLevel.isComplete()){
      _score += _currentLevel.bonusPoints;
      _levelCount++;
      _startNextLevel();
    }
    //den aktuellen Tetromino von der alten Position entfernen
    _field.forEach((row) {
      row.forEach((cell) {
        if (cell.isActive) {
          cell.color = #empty;
        }
      });
    });
    //den aktuellen Tetromino an der neuen Position zeichnen
    _tetromino.stones.forEach((piece) {
      _field[piece['row']][piece['col']].color = _tetromino.color;
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
    //Leeres Feld erzeugen
    var nextStoneField = new Iterable.generate(extraFieldHeight, (row) {
      return new Iterable.generate(extraFieldWidth, (col) => #empty)
          .toList();
    }).toList();

    if(_tetrominoQueue.isNotEmpty) {
      _tetrominoQueue.elementAt(0).preview.forEach((stone) {
        nextStoneField[stone['row']][stone['col']] = _tetrominoQueue.elementAt(0).color;
      });
    }

    return nextStoneField;
  }

  /**
   * Gibt das Gehalteten-Tetromino-Feld als eine Liste von Listen zurück.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   * @return Gehalteten-Tetromino-Feld als eine Liste von Listen
   */
  List<List<Symbol>> get holdStoneField {
    var _holdStoneField = new Iterable.generate(extraFieldHeight, (row) {
      return new Iterable.generate(extraFieldWidth, (col) => #empty)
          .toList();
    }).toList();
    // Tetromino setzen
    if(_tetrominoOnHold != null) {
      _tetrominoOnHold.preview.forEach((piece) {
        final r = piece['row'];
        final c = piece['col'];
        if (r < 0 || r >= extraFieldHeight) return;
        if (c < 0 || c >= extraFieldWidth) return;
        _holdStoneField[r][c] = _tetrominoOnHold.color;
      });
    }
    return _holdStoneField;
  }

  /**
   * Bewegungensstatus für den Tetromino [down], [left], [right].
   * Bewegungen sind nur im Status [running] möglich.
   */
  void moveTetromino() {
    if (running && _tetromino != null){
      tetromino.move();
    }
  }

  /**
   * Pausiert das Spiel und gibt es beim nächsten Aufruf wieder frei.
   */
  void pauseTetromino(){
    // Wenn das Spiel läuft, dann Pausieren
    if (running){
      pause();
      tetromino.stop();

      // Wenn das Spiel pausiert ist, dann freigeben
    } else if (paused) {
      resume();
      tetromino.down();
    }
  }

  /**
   * Legt den aktuellen Tetrominoe in die Hold Box. Falls bereits ein Tetrominoe
   * in der Hold Box ist, wird diser aus der Box genommen und faellt herunter.
   */
  void holdCurrentTetrominoe(){
    if(_tetrominoOnHold == null){
      _tetrominoOnHold = _tetromino;
      dumpNextTetromino();
    } else{
      _tetrominoOnHold.resetPosition();
      _tetrominoQueue.addFirst(_tetrominoOnHold);
      _tetrominoOnHold = _tetromino;
      _tetromino.removeFromField();
      dumpNextTetromino();
    }
  }

  /**
   * Gibt eine Liste mit den Indizes aller Zeilen die vollstaendig sind
   * zurueck. Eine Reihe gilt als vollstaendig, falls alle ihre Zellen
   * gefuellt und inaktiv sind.
   */
  List<num> getIndexOfCompletedRows(){
    List<num> rowsCompleted = new List();
    //fuer jede Zeile pruefen, ob alle Zellen belegt und inaktiv sind
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
    removeRows(completedRows);
  }

  /**
   * Entfernt eine vollständige Tetromino Reihe
   * @param List<num> rows = Liste an Reihen
   */
  void removeRows(List<num> rows){
    //falls keine Reihen vervollständigt wurden, muss nichts entfernt werden
    if(rows.length == 0){
      return;
    }
    //TODO: list may contains duplicates, use set instead
    _numberOfRowsCleared += rows.length;
    //increase score
    this._score += this.calculateScoreOfMove(rows.length);
    //keep track of how many row were completed this level
    _currentLevel.goalMetrics['numberOfRowsCleared'] += rows.length;
    //remove completed rows
    rows.forEach((rowIndex) {
      this.field[rowIndex].forEach((cell){
        cell.color = #empty;
        cell.isActive = false;
      });
    });
    //move upper rows down
    rows.sort((a, b) => (a-b).toInt());
    rows.forEach((rowIndex){
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
   * @param num rowsCompleted = Anzahl an kompletten Reihen
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
      default:
        score = 1500;
    }
    return score * _currentLevel.scoreMultiplier;
  }

  /**
   * Erhöht den Tetromino Zähler
   */
  void incrementTetrominoCount(){
    this._tetrominoCount++;
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
  int get sizeHeight => _fieldHeight;

  /**
   * Gibt die Breite des Spielfeldes zurück. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeWidth => _fieldWidth;

  /**
   * Gibt die Höhe des Feldes für den Nächsten-Tetromino-Feld zurück.
   */
  int get extraFieldHeight => _extraFieldHeight;

  /**
   * Gibt die Breite des Feldes für den Nächsten-Tetromino-Feld zurück.
   */
  int get extraFieldWidth => _extraFieldWidth;

  /**
   * Gibt das aktuelle Level des Spiel zuruek.
   */
  Level get currentLevel => _currentLevel;

  /**
   * Gibt die Anzanl der abgeschlossenen Level zurueck
   */
  int get levelCount => _levelCount;
  /**
   * Fügt Levels hinzu.
   * @param Level level = Das Level was hinzugefügt werden soll
   */
  void addLevel(Level level){
    if(_levels == null){
      _levels = new PriorityQueue(
              (Level l1, Level l2) => (l2.priority - l1.priority));
    }
    _levels.add(level);
  }

  /**
   * Startet den nächsten Level.
   */
  void _startNextLevel(){
    if(_levels.isNotEmpty){
      _currentLevel = _levels.removeFirst();
    } else{

      //TODO: let the user decide (in the json file) if the endless mode
      // should be enabled afterall levels are completed.

      //after all levels are completed switch to endless mode
      Level endlessMode = new Level(this, _configReader.readAllTetrominoIds(),
          1.0, 1, 0, 1);
      List<Goal> endlessGoals = new List();
      Goal endlessGoal = new EndlessGoal(endlessMode);
      endlessGoals.add(endlessGoal);
      endlessMode.goals = endlessGoals;
      _currentLevel = endlessMode;
    }
    _tetrominoQueue.clear();
    _fillTetrominoeQueue();
    dumpNextTetromino();
  }
}
