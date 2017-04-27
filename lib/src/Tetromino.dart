part of tetris;

/**
 *  * Definiert ein Tetris-Block im Tetris Spiel.
 */
class Tetromino {

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
   * Konstuktor um ein [Tetromino] Objekt für ein [TetrisGame] zu erzeugen.
   */
  Tetromino.on(this._game) {
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
      //TODO: nach dem der erste Stein auf das Spielfeld gesetzt wird, wird die
      //View nich aktualisiert. Dies geschieht erst, wenn der Stein einmal
      //bewegt wurde, weshalb der erste Stein erst in der zweiten Zeile
      //erscheint.
      _stone.forEach((cell){
        this._game._field[cell['row']][cell['col']].isActive = true;
      });

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

    //Die Zellen, welche von dem aktuellen Tetromino belegt sind als aktiv
    //makieren
    _stone.forEach((cell){
      this._game._field[cell['row']][cell['col']].isActive = true;
    });
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
          {'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
    }
    return temp;
  }

  /**
   * Drehen des Tetris Steins um 90 Grad
   * Y-Koordinate: row
   * X-Koordinate: col
   * Rotationsformal für 90 Grad:
   * x' = x * cos(90) - y * sin(90)
   * y' = x * sin(90) + y * cos(90)
   */
  void rotate(){
    var _rotate = [
      { 'row' : (_stone.elementAt(0)['col'] * sin(90).round() + _stone.elementAt(0)['row'] * cos(90).round()),  'col' : (_stone.elementAt(0)['col'] * cos(90).round() - _stone.elementAt(0)['row'] * sin(90).round()) },
      { 'row' : (_stone.elementAt(1)['col'] * sin(90).round() + _stone.elementAt(1)['row'] * cos(90).round()),  'col' : (_stone.elementAt(1)['col'] * cos(90).round() - _stone.elementAt(1)['row'] * sin(90).round()) },
      { 'row' : (_stone.elementAt(2)['col'] * sin(90).round() + _stone.elementAt(2)['row'] * cos(90).round()),  'col' : (_stone.elementAt(2)['col'] * cos(90).round() - _stone.elementAt(2)['row'] * sin(90).round()) },
      { 'row' : (_stone.elementAt(3)['col'] * sin(90).round() + _stone.elementAt(3)['row'] * cos(90).round()),  'col' : (_stone.elementAt(3)['col'] * cos(90).round() - _stone.elementAt(3)['row'] * sin(90).round()) }
    ];

    _stone = _rotate;
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

    // Prüfen ob der Tetris Stein die Seiten verlässt
    if (onSide(_move)){
      // Prüfen ob der Stein den Grund des Feldes erreicht
      //window.console.log('onGround: ${onGround(_move)}');
      if (notOnGround(_move)){
        //den Stein von der alten Postion entfernen
        this._stone.forEach((piece){
          this._game._field[piece['row']][piece['col']].isActive = false;
          this._game._field[piece['row']][piece['col']].color = #empty;
        });
        _stone = _move;
        //TODO: check if the current tetromino hit another tetromino that
        //is already placed on the field
      } else {
        nextTetris();
      }
    }

    this._game.updateField();
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
   * Überprüfen ob der Tetris Stein an den Seiten angekommen ist
   */
  bool onSide(var moveTo) {
    bool stoneOne = moveTo.elementAt(0)['row'] >= 0&&
        moveTo.elementAt(0)['col'] >= 0 &&
        moveTo.elementAt(0)['col'] < _game._sizeWidth;

    bool stoneTwo = moveTo.elementAt(1)['row'] >= 0&&
        moveTo.elementAt(1)['col'] >= 0 &&
        moveTo.elementAt(1)['col'] < _game._sizeWidth;

    bool stoneThree = moveTo.elementAt(2)['row'] >= 0&&
        moveTo.elementAt(2)['col'] >= 0 &&
        moveTo.elementAt(2)['col'] < _game._sizeWidth;

    bool stoneFour = moveTo.elementAt(3)['row'] >= 0&&
        moveTo.elementAt(3)['col'] >= 0 &&
        moveTo.elementAt(3)['col'] < _game._sizeWidth;

    return stoneOne && stoneTwo && stoneThree && stoneFour;
  }

  /**
   * Überprüfen ob der Tetris Stein am Grund angekommen ist
   */
  bool notOnGround(var moveTo) {
    bool stoneOne = moveTo.elementAt(0)['row'] >= 0&&
        moveTo.elementAt(0)['row'] < _game._sizeHeight;

    bool stoneTwo = moveTo.elementAt(1)['row'] >= 0&&
        moveTo.elementAt(1)['row'] < _game._sizeHeight;

    bool stoneThree = moveTo.elementAt(2)['row'] >= 0&&
        moveTo.elementAt(2)['row'] < _game._sizeHeight;

    bool stoneFour = moveTo.elementAt(3)['row'] >= 0&&
        moveTo.elementAt(3)['row'] < _game._sizeHeight;

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