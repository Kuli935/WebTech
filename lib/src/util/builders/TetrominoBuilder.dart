part of tetris;

class TetrominoBuilder extends Builder<Tetromino>{

  TetrisGame _model;

  TetrominoBuilder(Reader reader, TetrisGame model):_model = model, super(reader){}

  Tetromino build(String id){
    Map<String, Object> tetrominoConfig = _reader.readTetrominoeConfiguration(id);
    if(tetrominoConfig == null){
      window.alert('Could not find a Tetrominoe configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}". Please make sure '
          'your game configuration file is correct. You can find the manual '
          'and a sample configuration file at: '
          'https://github.com/Kuli935/WebTech');
      return null;
    }
    Tetromino tetromino = new Tetromino(_model,
        tetrominoConfig['stones'],
        tetrominoConfig['transitions'],
        tetrominoConfig['preview'],
        new Symbol(tetrominoConfig['color']));

    List<String> powerUpIds = tetrominoConfig['powerUps'];
    powerUpIds.forEach((powerUpId){
      PowerUp powerUp = new PowerUpBuilder(_reader, _model, tetromino).build(powerUpId);
      tetromino.addPowerUp(powerUp);
    });
    return tetromino;
  }

}