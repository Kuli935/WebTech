part of tetris;

class OTetromino extends Tetromino{


  OTetromino(TetrisGame model) : super(model, [
     { 'row' : 0, 'col' : model.sizeWidth ~/ 2 - 1 },
     { 'row' : 1, 'col' : model.sizeWidth ~/ 2 - 1 },
     { 'row' : 0, 'col' : model.sizeWidth ~/ 2     },
     { 'row' : 1, 'col' : model.sizeWidth ~/ 2     }
     ], #yellow);

  rotate(int angle){}
}