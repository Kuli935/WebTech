part of tetris;

class GoalBuilder extends Builder<Goal> {

  Level _level;
  Map<String, Object> _goalConfiguration;

  GoalBuilder(Reader reader, Level level, Map<String, Object> goalConfiguration)
      :
        _level = level,
        _goalConfiguration = goalConfiguration,
        super(reader) {}

  Goal build(String id) {
    id = _goalConfiguration.keys.toList()[0];
    switch (id) {
      case 'numberOfRowsCleared':
        return new NumberOfRowClearedGoal(_level, _goalConfiguration[id]);
      default:
        window.alert('There is no Goal with id: ${id}. Please make sure '
            'your game configuration file is correct. You can find the manual '
            'and a sample configuration file at: '
            'https://github.com/Kuli935/WebTech');
    }
  }
}