part of tetris;

/// Ein Builder zum Erstellen von Level Instanzen. Die Konfiguration fuer die
/// Level wird aus dem zugehoerigen [Reader] ausgelesen.
class LevelBuilder extends Builder<Level> {

  /// Das Model zum dem dieses Level gehoert.
  final TetrisGame _model;

  /// Erstellt einen neuen [LevelBuilder]. Die von diesem [LevelBuilder]
  /// erstellten [Level] gehoeren zu [model].
  LevelBuilder(Reader reader, TetrisGame model)
      : _model = model,
        super(reader) {}

  /// Erstell ein neues [Level] mit den im [Reader] gespeicherten Parameter
  /// mit der [id]
  Level build(String id) {
    Map<String, Object> levelConfig = _reader.readLevelConfiguration(id);
    if (levelConfig == null) {
      window.alert('Could not find a Level configuration with the '
          'id: "${id}" in the file: "${_reader.dataUri}". Please make sure '
          'your game configuration file is correct. You can find the manual '
          'and a sample configuration file at: '
          'https://github.com/Kuli935/WebTech');
      return null;
    }

    Level level = new Level().setModel(_model).
      setIdsOfAvailableTetrominoes(levelConfig['availibleTetrominoes']).
      setScoreMultiplier(levelConfig['scoreMultiplier']).
      setTetrominoSpeedInMs(levelConfig['tetrominoSpeedInMs']).
      setBonusPoints(levelConfig['bounsPoints']).
      setPriority(levelConfig['priority']);

    List<Goal> goals = new List();
    //ATM it only is possible to load one goal for each level
    GoalBuilder builder = new GoalBuilder(_reader, level, levelConfig['goal']);
    goals.add(builder.build(''));
    level.setGoals(goals);

    return level;
  }
}