part of tetris;

class Level{
  TetrisGame _model;
  List<Tetromino> _availibleTetrominoes;
  double _scoreMultiplier;
  int _tetrominoSpeedInMs;
  Map<String, double> _goals;
  int _priority;
  Map<String, Function> _goalCheckers =
  {'numberOfRowsCleared':_numberOfRowsClearedComplete};

  Level(TetrisGame model, List<Tetromino> availibleTetrominoes,
      double scoreMultiplier, int tetrominoSpeedInMs, Map<String, double> golas,
      int priority){
    _model = model;
    _availibleTetrominoes = availibleTetrominoes;
    _scoreMultiplier = scoreMultiplier;
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    _goals = golas;
    _priority = priority;
  }

  static bool _numberOfRowsClearedComplete(double numberOfRows){
    if(numberOfRows.toInt() >= 5){
      return true;
    }
    return false;
  }

  bool isComplete(){
    /*TODO: check for each condition in the goal map if it is satisfied.
    possible goals are:
      -number of rows cleared
      -number of tetrominoes dumped by game
      -number of points reached
    */
    bool isComplete = true;
    _goals.forEach((goal, value){
      if(!_goalCheckers[goal](value)){
        isComplete = false;
      }
    });
   
    return isComplete;
  }

  get availibleTetrominoes => _availibleTetrominoes;

  get scoreMultiplier => _scoreMultiplier;

  get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  get priority => _priority;
}