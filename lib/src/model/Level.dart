part of tetris;

/**
 * Ein Level haelt verschiede Werte zur konfiguration des TetrisGame.
 */
class Level {

  TetrisGame _model;

  /**
   * Enthaelt die eindeutigen Ids aller Tetrominoes, die in diesem Level
   * verfuegbar sind.
   */
  List<String> _idsOfAvailableTetrominoes;
  double _scoreMultiplier;
  int _tetrominoSpeedInMs;

  /**
   * Alle Ziele fuer dieses Level. Jedes einzelne Ziel darf maximal einmal
   * vorkommen.
   * //TODO: maybe change this to be just a single goal
   */
  List<Goal> _goals;

  int _priority;
  int _bonusPoints;

  /**
   * Diese Map speichert den aktuellen Zustand aller Werte, die fuer das
   * Erfüllen eines Ziels von Bedeutung sind. Sobald sich einer dieser Werte
   * aendert, muss die Map aktualisiert werden.
   */
  Map<String, double> _goalMetrics;

  Level(){
    _goalMetrics = _initGoalMetrics();
    _goals = new List<Goal>();
  }

  bool isComplete() {
    bool isComplete = true;
    _goals.forEach((goal) {
      if (!goal.isCompleted()) {
        isComplete = false;
      }
    });
    return isComplete;
  }

  /**
   * Initialisiert eine neue Map mit allen Metriken die fuer den Fortschritt des
   * Levels relevant sind.
   */
  Map<String, double> _initGoalMetrics() {
    Map<String, double> metrics = {
      'numberOfRowsCleared': 0.0
    };
    return metrics;
  }

  List<String> get idsOfAvailableTetrominoes => _idsOfAvailableTetrominoes;

  double get scoreMultiplier => _scoreMultiplier;

  int get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  int get priority => _priority;

  int get bonusPoints => _bonusPoints;

  Map<String, double> get goalMetrics => _goalMetrics;

  List<Goal> get goals => _goals;

  Level setPriority(int priority){
    _priority = priority;
    return this;
  }

  Level setBonusPoints(int bonusPoints){
    _bonusPoints = bonusPoints;
    return this;
  }

  Level setTetrominoSpeedInMs(int tetrominoSpeedInMs){
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    return this;
  }

  Level setScoreMultiplier(double scoreMultiplier){
    _scoreMultiplier = scoreMultiplier;
    return this;
  }

  Level setIdsOfAvailableTetrominoes(List<String> idsOfAvailableTetrominoes){
    _idsOfAvailableTetrominoes = idsOfAvailableTetrominoes;
    return this;
  }

  Level setGoals(List<Goal> goals) {
    _goals = goals;
    return this;
  }

  Level setModel(TetrisGame model){
    _model = model;
    return this;
  }
}