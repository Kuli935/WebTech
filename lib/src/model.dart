part of tetris;

/**
 *  * Definiert ein Tetris-Block im Tetris Spiel.
 */
class Tetris {

  /**
   * Verweist auf das Spiel.
   */
  final TetrisGame _game;

  /**
   * Liste der Stein Elemente von dem Tetris Stein
   */
  var _stone = [];

  /**
   * Farbe des Tetris Steins
   */
  Symbol _color;
  /**
   * Konstuktor um ein [Tetris] Objekt für ein [TetrisGame] zu erzeugen.
   */
  Tetris.on(this._game) {
    nextTetris();
  }

  /**
   * Generiert einen zufälligen Tetris Stein.
   */
  void nextTetris(){
    final r = new Random();
    final randomTetris = r.nextInt(7);

    switch(randomTetris) {
      case 0:
        createI(_game._sizeWidth);
        break;
      case 1:
        createJ(_game._sizeWidth);
        break;
      case 2:
        createL(_game._sizeWidth);
        break;
      case 3:
        createO(_game._sizeWidth);
        break;
      case 4:
        createS(_game._sizeWidth);
        break;
      case 5:
        createT(_game._sizeWidth);
        break;
      case 6:
        createZ(_game._sizeWidth);
        break;
    }
  }

  /**
   * Erzeugt ein I Tetris Stein in der Farbe hellblau
   */
  void createI(int width){
    _color = #cyan;
    _stone = [
      { 'row' : 0,    'col' : width ~/ 2 - 2 },
      { 'row' : 0,    'col' : width ~/ 2 - 1 },
      { 'row' : 0,    'col' : width ~/ 2     },
      { 'row' : 0,    'col' : width ~/ 2 + 1 }
    ];
  }

  /**
   * Erzeugt ein J Tetris Stein in der Farbe blau
   */
  void createJ(int width){
    _color = #blue;
    _stone = [
      { 'row' : 0,    'col' : width ~/ 2 - 1  },
      { 'row' : 0,    'col' : width ~/ 2      },
      { 'row' : 0,    'col' : width ~/ 2 + 1  },
      { 'row' : 1,    'col' : width ~/ 2 + 1  }
    ];
  }

  /**
   * Erzeugt ein L Tetris Stein in der Farbe orange
   */
  void createL(int width){
    _color = #orange;
    _stone = [
      { 'row' : 1,    'col' : width ~/ 2 - 1  },
      { 'row' : 0,    'col' : width ~/ 2 - 1  },
      { 'row' : 0,    'col' : width ~/ 2      },
      { 'row' : 0,    'col' : width ~/ 2 + 1  }
    ];
  }

  /**
   * Erzeugt ein O Tetris Stein in der Farbe gelb
   */
  void createO(int width){
    _color = #yellow;
    _stone = [
      { 'row' : 0,     'col' : width ~/ 2 - 1 },
      { 'row' : 1,     'col' : width ~/ 2 - 1 },
      { 'row' : 0,     'col' : width ~/ 2     },
      { 'row' : 1,     'col' : width ~/ 2     }
    ];
  }

  /**
   * Erzeugt ein S Tetris Stein in der Farbe grün
   */
  void createS(int width){
    _color = #green;
    _stone = [
      { 'row' : 0,    'col' : width ~/ 2      },
      { 'row' : 0,    'col' : width ~/ 2 - 1  },
      { 'row' : 1,    'col' : width ~/ 2 - 1  },
      { 'row' : 1,    'col' : width ~/ 2 - 2  }
    ];
  }

  /**
   * Erzeugt ein T Tetris Stein in der Farbe lila
   */
  void createT(int width){
    _color = #purple;
    _stone = [
      { 'row' : 0,      'col' : width ~/ 2 - 1  },
      { 'row' : 0,      'col' : width ~/ 2      },
      { 'row' : 1,      'col' : width ~/ 2      },
      { 'row' : 0,      'col' : width ~/ 2 + 1  }
    ];
  }

  /**
   * Erzeugt ein Z Tetris Stein in der Farbe rot
   */
  void createZ(int width){
    _color = #red;
    _stone = [
      { 'row' : 0,  'col' : width ~/ 2 - 1  },
      { 'row' : 0,  'col' : width ~/ 2      },
      { 'row' : 1,  'col' : width ~/ 2      },
      { 'row' : 1,  'col' : width ~/ 2 + 1  }
    ];
  }





  /**
   * Returns die Farbe des Steins.
   */
  Symbol get color => _color;

  /**
   * Returns die Steine von dem Tetris Element und die Position von dem Element.
   */
   get stone => _stone;

}




/**
 * Definiert ein Tetris Spiel. Eine Tetris Spielkonstante ist das n x m Feld.
 */
class TetrisGame {

  // Tetris Stein
  Tetris _tetris;

  // Die Feldgröße des Spiels (n x m Feld)
  final int _sizeHeight;
  final int _sizeWidth;

  // Die Feldgröße für nächsten Tetris Stein (n x m Feld)
  final int _nextStoneFieldHeight;
  final int _nextStoneFieldWidth;


  // Spielzustand #running or #stopped.
  Symbol _gamestate;

  /**
   * Gibt an, ob das Spiel gestoppt wird
   */
  bool get stopped => _gamestate == #stopped;

  /**
   * Gibt an, ob das Spiel läuft
   */
  bool get running => _gamestate == #running;

  /**
   * Startet des Spiel
   */
  void start() { _gamestate = #running; }

  /**
   * Stopt das Spiel
   */
  void stop() { _gamestate = #stopped; }

  /**
   * Konstruktor um ein neues Tetris Spiel zu erzeugen
   */
  TetrisGame(this._sizeHeight, this._sizeWidth, this._nextStoneFieldHeight, this._nextStoneFieldWidth) {
    start();
    _tetris = new Tetris.on(this);
    stop();
  }


  /**
   * Returns ein Spielfeld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get field {
    var _field = new Iterable.generate(sizeHeight, (row) {
      return new Iterable.generate(sizeWidth, (col) => #empty).toList();
    }).toList();
    // Tetris Stein setzen
    _tetris.stone.forEach((s) {
      final r = s['row'];
      final c = s['col'];
      if (r < 0 || r >= _sizeWidth) return;
      if (c < 0 || c >= _sizeHeight) return;
      _field[r][c] = _tetris.color;
    });
    return _field;
  }

  /**
   * Returns Nächster-Tetris-Stein-Feld als eine Liste von Listen.
   * Jedes Element des Feldes hat genau eine aus acht gültigen Zustände (Symbole).
   * Wobei es es sich eigentlich um zwei Zustände handelt, leer und gefärbt.
   * Leerzustand: #empty,
   * Farben: #cyan, #blue, #yellow, #orange, #red, #green, #purple
   */
  List<List<Symbol>> get nextStoneField {
    var _nextStoneField = new Iterable.generate(nextStoneFieldHeight, (row) {
      return new Iterable.generate(nextStoneFieldWidth, (col) => #empty).toList();
    }).toList();
    //andere Elemente
    return _nextStoneField;
  }


  /**
   * Returns den Tetris Stein.
   */
  Tetris get tetris => _tetris;

  /**
   * Returns die Größe des Spielffeldes. Das Spiel wird auf einen n x m Feld gespielt.
   */
  int get sizeHeight => _sizeHeight;
  int get sizeWidth => _sizeWidth;

  /**
   * Returns die Größe des Feldes für den nächsten Stein.
   */
  int get nextStoneFieldHeight => _nextStoneFieldHeight;
  int get nextStoneFieldWidth => _nextStoneFieldWidth;
}