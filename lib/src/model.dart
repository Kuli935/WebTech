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
   * Liste der Stein Elemente von dem Tetris Stein für das Nächste-Tetris-Stein-Feld
   */
  var _nextstone = [];

  /**
   * Farbe des Tetris Steins im Spielfeld
   */
  Symbol _stoneColor;

  /**
   * Farbe des Tetris Steins im Nächsten-Tetris-Stein-Feld
   */
  Symbol _nextstoneColor;

  /**
   * Temporäre Farbe des Tetris Steins
   */
  Symbol _tempColor;

  /**
   * Vertikale, Reihe (row), Bewegung von dem Tetris Stein. Mögliche Richtung nur nach unten: +1.
   */
  int _dr;

  /**
   * Horizontale, Spalte (col), Bewegung von dem Tetris Stein. Mögliche Richtungen: links, bleiben, rechts:  -1, 0, 1.
   */
  int _dc;

  /**
   * Variable für den ersten Tetris Stein. Damit der nächste Stein um einen versetzt ist.
   */
  bool _firstStone = true;

  /**
   * Temporäre Nummer des Tetris Stein
   */
  int _tempStone;

  /**
   * Konstuktor um ein [Tetris] Objekt für ein [TetrisGame] zu erzeugen.
   */
  Tetris.on(this._game) {
    nextTetris();
    down();
  }

  /**
   * Generiert einen zufälligen Tetris Stein.
   */
  void nextTetris() {
    final r = new Random();

    // Prüfe ob es der aller erste Tetris Stein ist
    if (_firstStone) {
      // generie den ersten zufalls Tetris Stein
      final random = r.nextInt(7);
      _stone = randomTetris(random, 0, _game._sizeWidth);
      // Farbe setzen
      _stoneColor = _tempColor;
      _firstStone = false;

      // Vorschau auf den nächsten Stein
      _tempStone = r.nextInt(7);
      _nextstone = randomTetris(_tempStone, _game._nextStoneFieldHeight - 1, _game._nextStoneFieldWidth);
      // Farbe setzen
      _nextstoneColor = _tempColor;
    }

    // sonst alle anderen Steine
    // Den normalen Tetris stein erzeugen
    _stone = randomTetris(_tempStone, 0, _game._sizeWidth);
    // Farbe setzen
    _stoneColor = _nextstoneColor;
    // Vorschau auf den nächsten Stein
    _tempStone = r.nextInt(7);
    _nextstone = randomTetris(_tempStone, _game._nextStoneFieldHeight - 1, _game._nextStoneFieldWidth);
    // Farbe setzen
    _nextstoneColor = _tempColor;
  }

  /**
   * Generiert einen zufälligen Tetris Stein.
   * @param: int randoom = Einen Zufallswert von 0-6
   * @param int height = Höhe
   * @param int width = Bereite
   * @return Liste des Tetris Steins
   */
  List<Map<String, int>> randomTetris(int random, int height, int width){
    List<Map<String, int>> temp;
    switch(random) {
      case 0:
        // Erzeugt ein I Tetris Stein in der Farbe hellblau
        _tempColor = #cyan;
        temp = [
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 2 },
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2,    'col' : width ~/ 2     },
          { 'row' : height ~/ 2,    'col' : width ~/ 2 + 1 }
        ];
        break;
      case 1:
        // Erzeugt ein J Tetris Stein in der Farbe blau
        _tempColor = #blue;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
      case 2:
        // Erzeugt ein L Tetris Stein in der Farbe orange
        _tempColor = #orange;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 3:
        // Erzeugt ein O Tetris Stein in der Farbe gelb
        _tempColor = #yellow;
        temp = [
          { 'row' : height ~/ 2,      'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2,      'col' : width ~/ 2     },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2     }
        ];
        break;
      case 4:
        // Erzeugt ein S Tetris Stein in der Farbe grün
        _tempColor = #green;
          temp = [
            { 'row' : height ~/ 2,       'col' : width ~/ 2      },
            { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 2  }
          ];
          break;
      case 5:
        // Erzeugt ein T Tetris Stein in der Farbe lila
        _tempColor = #purple;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 6:
        // Erzeugt ein Z Tetris Stein in der Farbe rot
        _tempColor = #red;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
    }
    return temp;
  }







  /**
   * Bewegungen von dem Tetris Stein und seine Richtungen (down, left, right)
   */
  void move() {

    var _move = [
      { 'row' : _stone.elementAt(0)['row'] + _dr,  'col' : _stone.elementAt(0)['col'] + _dc  },
      { 'row' : _stone.elementAt(1)['row'] + _dr,  'col' : _stone.elementAt(1)['col'] + _dc  },
      { 'row' : _stone.elementAt(2)['row'] + _dr,  'col' : _stone.elementAt(2)['col'] + _dc  },
      { 'row' : _stone.elementAt(3)['row'] + _dr,  'col' : _stone.elementAt(3)['col'] + _dc  }
    ];


    if (onField(_move)){
      _stone = _move;
    } else {
      nextTetris();
    }


  }



  /**
   * Teilt dem Tetris Stein die Bewegung nach unten mit [move]s.
   */
  void down()  { _dr =  1; _dc =  0; }

  /**
   * Teilt dem Tetris Stein die Bewegung nach links mit [move]s.
   */
  void left()  { _dr =  0; _dc = -1; }

  /**
   * Teilt dem Tetris Stein die Bewegung nach rechts mit [move]s.
   */
  void right() { _dr =  0; _dc =  1; }


  /**
   * Überprüfen ob sich der Tetris Stein noch im Feld befindet
   */
  bool onField(var moveTo) {
    bool stoneOne = moveTo.elementAt(0)['row'] >= 0&&
        moveTo.elementAt(0)['row'] < _game._sizeHeight &&
        moveTo.elementAt(0)['col'] >= 0 &&
        moveTo.elementAt(0)['col'] < _game._sizeWidth;

    bool stoneTwo = moveTo.elementAt(1)['row'] >= 0&&
        moveTo.elementAt(1)['row'] < _game._sizeHeight &&
        moveTo.elementAt(1)['col'] >= 0 &&
        moveTo.elementAt(1)['col'] < _game._sizeWidth;

    bool stoneThree = moveTo.elementAt(2)['row'] >= 0&&
        moveTo.elementAt(2)['row'] < _game._sizeHeight &&
        moveTo.elementAt(2)['col'] >= 0 &&
        moveTo.elementAt(2)['col'] < _game._sizeWidth;

    bool stoneFour = moveTo.elementAt(3)['row'] >= 0&&
        moveTo.elementAt(3)['row'] < _game._sizeHeight &&
        moveTo.elementAt(3)['col'] >= 0 &&
        moveTo.elementAt(3)['col'] < _game._sizeWidth;

    return stoneOne && stoneTwo && stoneThree && stoneFour;

  }

  /**
   * Returns die Farbe des Steins im Spielfeld.
   */
  Symbol get stoneColor => _stoneColor;

  /**
   * Returns die Farbe des Steins im Nächsten-Tetris-Stein-Feld
   */
  Symbol get nextstoneColor => _nextstoneColor;

  /**
   * Returns die Steine von dem Tetris Element und die Position von dem Element.
   */
   get stone => _stone;

  /**
   * Returns die Steine von dem Tetris Element und die Position von dem Element im Nächsten-Tetris-Stein-Tabelle.
   */
  get nextstone => _nextstone;

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
      if (r < 0 || r >= sizeHeight) return;
      if (c < 0 || c >= sizeWidth) return;
      _field[r][c] = _tetris.stoneColor;
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
    // Tetris Stein setzen
    _tetris.nextstone.forEach((s) {
      final r = s['row'];
      final c = s['col'];
      if (r < 0 || r >= nextStoneFieldHeight) return;
      if (c < 0 || c >= nextStoneFieldWidth) return;
      _nextStoneField[r][c] = _tetris.nextstoneColor;
    });
    return _nextStoneField;
  }

  /**
   * Bewegungensstatus für den Tetris Stein [down], [left], [right].
   * Bewegungen sind nur im Status [running] möglich.
   */
  void moveTetris() { if (running) tetris.move(); }


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