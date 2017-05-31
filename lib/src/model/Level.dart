part of tetris;

/**
 * Ein Level haelt verschiede Werte zur konfiguration des TetrisGame.
 */
class Level{
  TetrisGame _model;

  /**
   * Enthaelt die eindeutigen Ids aller Tetrominoes, die in diesem Level
   * verfuegbar sind.
   */
  List<String> _idsOfAvailableTetrominoes;
  //TODO: maybe add a spwan chance for each tetromino
  double _scoreMultiplier;
  int _tetrominoSpeedInMs;
  Map<String, double> _goals;
  int _priority;
  //TODO: add a reward (bonus points, special power up)
  //TODO: show current goals in in view

  Map<String, Function> _goalCheckers =
  {'numberOfRowsCleared': _numberOfRowsClearedComplete,
   'endlessGame': _endlessGame};

  //TODO: refactor constructor messs to use benefits of builder, move initis
  //to initializer
  Level(TetrisGame model, List<String> idsOfAvailableTetrominoes,
      double scoreMultiplier, int tetrominoSpeedInMs, Map<String, double> golas,
      int priority){
    _model = model;
    _idsOfAvailableTetrominoes = idsOfAvailableTetrominoes;
    _scoreMultiplier = scoreMultiplier;
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    _goals = golas;
    _priority = priority;
  }

  /*
  Eine Auswahl an Level Zielen soll vorhanden sein. Fuer jedes Ziel muss eine
  Check Funktion implementiert werden (siehe unten). In der JSON Datei wird dann
  folgendes stehen: {'numberOfRowsCleared': 5.0, 'pointsReched': 3000}
  Wenn alle Bedingungen erfuellt sind, ist das Level beendet und das model muss
  das naechste Level laden.
   */
  static bool _numberOfRowsClearedComplete(TetrisGame model, double numberOfRows){
    if(model.numberOfRowsCleared >= numberOfRows.toInt()){
      return true;
    }
    return false;
  }

  static bool _endlessGame(TetrisGame model, double value){
    return false;
  }

  bool isComplete(){
    /*TODO: check for each condition in the goal map if it is satisfied.
    possible goals are:
      -number of rows cleared
      -number of tetrominoes dumped by game
      -number of points reached
    */
    //TODO: implement null check for goal?!
    bool isComplete = true;
    _goals.forEach((goal, value){
      if(!_goalCheckers[goal](_model, value)){
        isComplete = false;
      }
    });
    if(isComplete) {
      window.console.log('>>>: LEVEL COMPLETE');
    }
    //window.console.log('number of rows cleared: ${_model.numberOfRowsCleared}');
    return isComplete;
  }

  get idsOfAvailableTetrominoes => _idsOfAvailableTetrominoes;

  get scoreMultiplier => _scoreMultiplier;

  get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  get priority => _priority;
}