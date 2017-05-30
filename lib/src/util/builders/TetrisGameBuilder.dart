part of tetris;

class TetrisGameBuilder extends Builder<TetrisGame>{

  TetrisGameBuilder(JsonReader reader):super(reader){}

  TetrisGame build(){
    Map<String, Object> modelConfiguration = _reader.readModelConfiguration();
    //TODO: set levels
    TetrisGame model = new TetrisGame(modelConfiguration['fieldWidth'],
                                      modelConfiguration['fieldHeight']);
    return model;
  }
}