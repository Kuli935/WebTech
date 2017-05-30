part of tetris;

class TetrisGameBuilder{

  final JsonReader _reader;

  TetrisGameBuilder(JsonReader reader):_reader = reader{}

  TetrisGame build(){
    Map<String, Object> modelConfiguration = _reader.readModelConfiguration();
    TetrisGame model = new TetrisGame(modelConfiguration['fieldWidth'],
                                      modelConfiguration['fieldHeight']);
    return model;
  }
}