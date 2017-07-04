part of tetris;

class PowerUpBuilder extends Builder<PowerUp> {

  TetrisGame _model;
  PowerUpUser _target;

  PowerUpBuilder(Reader reader, TetrisGame model, PowerUpUser target)
      :
        _model = model,
        _target = target,
        super(reader) {}

  PowerUp build(String id) {
    switch (id) {
      case "RemoveAllRowsOfTetromino":
        return new RemoveAllRowsOfTetromino(_model, _target);
      case "TetrominoBomb":
        return new TetrominoBomb(_model, _target);
      default:
        window.alert('Could not find a Powerup configuration with the '
            'id: "${id}" in the file: "${_reader.dataUri}". Please make sure '
            'your game configuration file is correct. You can find the manual '
            'and a sample configuration file at: '
            'https://github.com/Kuli935/WebTech');
    }
    return null;
  }
}