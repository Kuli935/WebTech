part of tetris;

class LevelBuilder extends Builder<Level> {


  final TetrisGame _model;

  LevelBuilder(Reader reader, TetrisGame model)
      : _model = model,
        super(reader) {}

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


    Level level = new Level(_model,
        levelConfig['availibleTetrominoes'],
        levelConfig['scoreMultiplier'],
        levelConfig['tetrominoSpeedInMs'],
        levelConfig['bounsPoints'],
        levelConfig['priority']);

    List<Goal> goals = new List();
    //ATM it only is possible to load one goal for each level
    GoalBuilder builder = new GoalBuilder(_reader, level, levelConfig['goal']);
    goals.add(builder.build(''));

    //add the goals to the level
    level.goals = goals;
    return level;
  }
}