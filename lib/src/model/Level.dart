part of tetris;

/**
 * Ein Level haelt verschiede Werte zur konfiguration des TetrisGame.
 */
class Level{

  static final Map<String, String> goalDescriptions = {
    "numberOfRowsCleared": "Vervollständige Reihen",
    "endlessGame": "Endlos Modus"
  };

  TetrisGame _model;

  /**
   * Enthaelt die eindeutigen Ids aller Tetrominoes, die in diesem Level
   * verfuegbar sind.
   */
  List<String> _idsOfAvailableTetrominoes;
  double _scoreMultiplier;
  int _tetrominoSpeedInMs;
  Map<String, double> _goals;
  int _priority;
  String _nameOfFirstGoal;
  double _numericalFirstGoal;
  Map<String, double> _goalMetrics;

  Map<String, Function> _goalCheckers =
  {'numberOfRowsCleared': _numberOfRowsClearedComplete,
   'endlessGame': _endlessGame};

  //TODO: refactor constructor messs to use benefits of builder, move initis
  //to initializer
  Level(TetrisGame model, List<String> idsOfAvailableTetrominoes,
      double scoreMultiplier, int tetrominoSpeedInMs, Map<String, double> golas,
      int priority, String nameOfFirstGoal, numericalFistGoal){
    _model = model;
    _idsOfAvailableTetrominoes = idsOfAvailableTetrominoes;
    _scoreMultiplier = scoreMultiplier;
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    _goals = golas;
    _priority = priority;
    _nameOfFirstGoal = nameOfFirstGoal;
    _numericalFirstGoal = numericalFistGoal;
    _goalMetrics = _initGoalMetrics();
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

  /*

   */
  static bool _endlessGame(TetrisGame model, double value){
    return false;
  }

  bool isComplete(){
    /*
    possible goals are:
      -number of rows cleared
      -number of tetrominoes dumped by game
      -number of points reached
    */
    bool isComplete = true;
    _goals?.forEach((goal, value){
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

  /**
   * Initalize a new metrics map for this Level
   */
  Map<String, double> _initGoalMetrics(){
    Map<String, double> metrics = {
      'numberOfRowsCleared': 0.0
    };
    return metrics;
  }

  List<String> get idsOfAvailableTetrominoes => _idsOfAvailableTetrominoes;

  double get scoreMultiplier => _scoreMultiplier;

  int get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  int get priority => _priority;

  String get goalDescription {
    return goalDescriptions[_nameOfFirstGoal];
  }

  double get numericalFirstGoal => _numericalFirstGoal;

  Map<String, double> get goalMetrics => _goalMetrics;
}