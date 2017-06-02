part of tetris;

class PowerUpBuilder extends Builder<PowerUp>{

  TetrisGame _model;
  PowerUpUser _target;

  PowerUpBuilder(Reader reader, TetrisGame model, PowerUpUser target):
        _model = model, _target = target, super(reader){}

  PowerUp build(String id){
    switch(id){
      case "RemoveAllRowsOfTetromino":
        return new RemoveAllRowsOfTetromino(_model, _target);
    }
    return null;
  }
}