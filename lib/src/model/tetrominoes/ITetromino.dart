part of tetris;

class ITetromino extends Tetromino{

  ITetromino(TetrisGame model) : super(model, [
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 2 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 - 1 },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2     },
    { 'row' : 0,    'col' : model.sizeWidth ~/ 2 + 1 }
  ], #cyan);

  void rotate(int angle){

  }
}