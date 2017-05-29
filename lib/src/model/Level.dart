part of tetris;

class Level{
  TetrisGame _model;
  List<Type> _availibleTetrominoes;
  double _scoreMultiplier;
  int _tetrominoSpeedInMs;
  Map<String, double> _goals;
  int _priority;
  Map<String, Function> _goalCheckers =
  {'numberOfRowsCleared':_numberOfRowsClearedComplete};

  Level(TetrisGame model, List<Type> availibleTetrominoes,
      double scoreMultiplier, int tetrominoSpeedInMs, Map<String, double> golas,
      int priority){
    _model = model;
    _availibleTetrominoes = availibleTetrominoes;
    _scoreMultiplier = scoreMultiplier;
    _tetrominoSpeedInMs = tetrominoSpeedInMs;
    _goals = golas;
    _priority = priority;
  }

  static bool _numberOfRowsClearedComplete(TetrisGame model, double numberOfRows){
    if(model.numberOfRowsCleared >= numberOfRows.toInt()){
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

  get availibleTetrominoes => _availibleTetrominoes;

  get scoreMultiplier => _scoreMultiplier;

  get tetrominoSpeedInMs => _tetrominoSpeedInMs;

  get priority => _priority;
}