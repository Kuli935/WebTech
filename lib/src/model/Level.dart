part of tetris;

/// Ein Level enthaelt verschiedene Kafigurationen fuer das Spiel
/// ([TetrisGame]). Ein Level betitzt ein Ziel, wenn dieses erreicht wurde
/// ist das Level beendet.
class Level {

  /// Das zum Level zugehoerige [TetrisGame]
  TetrisGame _model;

  /// Enthaelt die eindeutigen Ids aller Tetrominoes, die in diesem Level
  /// verfuegbar sind.
  List<String> _idsOfAvailableTetrominoes;

  /// Der [scoreMultiplier] veraendert die Berechung der Punkte die der User
  /// in diesem Level fuer das vervollstaendigen von Reihen erhaelt.
  double _scoreMultiplier;

  /// Der [tetrominoSpeedInMs] andert die Fallgeschwindigkeit des Tetrominos
  /// solange dieses Level aktiv ist.
  int _tetrominoSpeedInMs;

  // TODO: refactor to use just one goal
  List<Goal> _goals;

  /// Der Spieler erhaelt [bonusPoints] viele Extrapunkte, nachdem er das Ziel
  /// dieses Levels erfuellt hat.
  int _bonusPoints;

  /// Die [priority] bestimmt die Reihenfolge der verschiedenen Level.
  ///
  /// Das Level mit der hoechsten Prioritaet wird als erstes gestartet.
  int _priority;

  /// Diese Map speichert den aktuellen Zustand aller Werte, die fuer das
  /// Erfüllen eines Ziels von Bedeutung sind. Sobald sich einer dieser Werte
  /// aendert, muss die Map aktualisiert werden.
  Map<String, double> _goalMetrics;

  /// Er stellt eine neue [Level] Instanz, welche NICHT KONFIGURIERT IST.
  ///
  /// Es sollte der entsprechende LevelBuilder genutzt werden, oder das Level
  /// wird über die setter Methoden konfiguritert.
  Level(){
    _goalMetrics = _initGoalMetrics();
    _goals = new List<Goal>();
  }

  /// Prueft ob das Ziel dieses Levels erfuellt wurde.
  bool isComplete() {
    bool isComplete = true;
    _goals.forEach((goal) {
      if (!goal.isCompleted()) {
        isComplete = false;
      }
    });
    return isComplete;
  }

   /// Initialisiert eine neue Map mit allen Metriken die fuer den Fortschritt des
   /// Levels relevant sind.
  Map<String, double> _initGoalMetrics() {
    Map<String, double> metrics = {
      'numberOfRowsCleared': 0.0
    };
    return metrics;
  }

  /// Gibt die Ids aller in diesem Level verfuegbaren Tetrominoes zurueck.
  List<String> get idsOfAvailableTetrominoes => _idsOfAvailableTetrominoes;

  /// Gibt den Multiplikator fuer die Punktzahl dieses Levels zurueck.
  double get scoreMultiplier => _scoreMultiplier;

  /// Gibt die Fallgeschwindigkeit des Tetromino in diesem Level zurueck.
  int get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  /// Gibt die Prioritaet diese Levels zurueck.
  int get priority => _priority;

  /// Gibt die Anzahl der Bonuspunkte zurueck, die der Spieler erhaelt, nachdem
  /// er das Ziel des Levels erfuellt hat.
  int get bonusPoints => _bonusPoints;

  /// Gibt eine Map aller Werte zurueck, die fuer den Fortschritt des Levelziels
  /// relevant sind.
  Map<String, double> get goalMetrics => _goalMetrics;

  /// Gibt das Ziel dieses Levels zurueck.
  List<Goal> get goals => _goals;

  /// Setzt die Prioritaet dieses Levels auf [priority] und gibt die Level
  /// Instanz zurueck.
  Level setPriority(int priority){
    _priority = priority;
    return this;
  }

  /// Setzt die Bonuspunkte dieses Levels auf [bonusPoints] und gibt die Level
  /// Instanz zurueck.
  Level setBonusPoints(int bonusPoints){
    _bonusPoints = bonusPoints;
    return this;
  }

  /// Setzt die Fallgeschwindigkeit des Tetromino in diesem Level auf
  /// [tetrominoSpeedInMs] und gibt die Level Instanz zurueck.
  Level setTetrominoSpeedInMs(int tetrominoSpeedInMs){
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    return this;
  }

  /// Setzt den Punktemultiplikator dieses Levels auf [scoreMultiplier] und
  /// gibt die Level Instanz zurueck.
  Level setScoreMultiplier(double scoreMultiplier){
    _scoreMultiplier = scoreMultiplier;
    return this;
  }

  /// Setzt die in diesem Level verfügbaren Tetrominoes auf
  /// [idsOfAvailableTetrominoes] und gibt die Level Instanz zurueck.
  Level setIdsOfAvailableTetrominoes(List<String> idsOfAvailableTetrominoes){
    _idsOfAvailableTetrominoes = idsOfAvailableTetrominoes;
    return this;
  }

  /// Setzt das Ziel dieses Levels auf [goals] und gibt die Level Instanz
  /// zurueck.
  Level setGoals(List<Goal> goals) {
    _goals = goals;
    return this;
  }

  /// Setzt das zugehoerige Model dieses Levels auf [model] und gibt die Level
  /// Instanz zurueck.
  Level setModel(TetrisGame model){
    _model = model;
    return this;
  }
}