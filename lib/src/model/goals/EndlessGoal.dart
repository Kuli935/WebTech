part of tetris;

class EndlessGoal extends Goal {

  EndlessGoal(Level level) :super(level, 'Endlos Modus', 42.0) {}

  // endless mode is never completed
  bool isCompleted() {
    return false;
  }

  double getProgress() {
    return 42.0;
  }
}