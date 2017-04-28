part of tetris;

/**
 *  * Definiert ein Tetromino im Tetris Spiel.
 */
class Tetromino {

  /**
   * Verweist auf das Spiel.
   */
  final TetrisGame _game;

  /**
   * Liste der Stein Elemente von dem Tetromino
   */
  var _stone = [];

  /**
   * Liste der Stein Elemente von dem Tetromino für das Nächste-Tetris-Stein-Feld
   */
  var _nextstone = [];

  /**
   * Farbe des Tetromino im Spielfeld
   */
  Symbol _stoneColor;

  /**
   * Farbe des Tetromino im Nächsten-Tetromino-Feld
   */
  Symbol _nextstoneColor;

  /**
   * Temporäre Farbe des Tetromino
   */
  Symbol _tempColor;

  /**
   * Vertikale, Reihe (row), Bewegung von dem Tetromino. Mögliche Richtung nur nach unten: +1.
   */
  int _dr;

  /**
   * Horizontale, Spalte (col), Bewegung von dem Tetromino. Mögliche Richtungen: links, bleiben, rechts:  -1, 0, 1.
   */
  int _dc;

  /**
   * Variable für den ersten Tetromino. Damit der nächste Tetromino um einen versetzt ist für die Vorschau
   */
  bool _firstStone = true;

  /**
   * Temporäre Nummer des Tetromino
   */
  int _tempStone;

  /**
   * Konstuktor um ein [Tetromino] Objekt für ein [TetrisGame] zu erzeugen.
   * @param _game = TetrisGame Objekt
   */
  Tetromino.on(this._game) {
    nextTetromino();
    down();
  }

  /**
   * Generiert einen zufälligen Tetromino.
   */
  void nextTetromino() {
    final r = new Random();

    // Prüfe ob es der aller erste Tetromino ist
    if (_firstStone) {
      // generie den ersten zufalls Tetromino
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

      // Vorschau auf den nächsten Tetromino
      _tempStone = r.nextInt(7);
      _nextstone = randomTetris(_tempStone, _game._nextStoneFieldHeight - 1, _game._nextStoneFieldWidth);
      // Farbe setzen
      _nextstoneColor = _tempColor;
    }

    // sonst alle anderen Tetromino
    // Den normalen Tetromino erzeugen
    _stone = randomTetris(_tempStone, 0, _game._sizeWidth);

    //Die Zellen, welche von dem aktuellen Tetromino belegt sind als aktiv
    //makieren
    _stone.forEach((cell){
      this._game._field[cell['row']][cell['col']].isActive = true;
    });
    // Farbe setzen
    _stoneColor = _nextstoneColor;
    // Vorschau auf den nächsten Tetromino
    _tempStone = r.nextInt(7);
    _nextstone = randomTetris(_tempStone, _game._nextStoneFieldHeight - 1, _game._nextStoneFieldWidth);
    // Farbe setzen
    _nextstoneColor = _tempColor;
  }

  /**
   * Generiert einen zufälligen Tetromino.
   * @param int random = Zufallswert von 0-6, Zahl ermittelt den Tetromino
   * @param int height = Höhe
   * @param int width = Breite
   * @return Liste des Tetromino
   */
  List<Map<String, int>> randomTetris(int random, int height, int width){
    List<Map<String, int>> temp;
    switch(random) {
      case 0:
        // Erzeugt ein I Tetromino in der Farbe hellblau
        _tempColor = #cyan;
        temp = [
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 2 },
          { 'row' : height ~/ 2,    'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2,    'col' : width ~/ 2     },
          { 'row' : height ~/ 2,    'col' : width ~/ 2 + 1 }
        ];
        break;
      case 1:
        // Erzeugt ein J Tetromino in der Farbe blau
        _tempColor = #blue;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
      case 2:
        // Erzeugt ein L Tetromino in der Farbe orange
        _tempColor = #orange;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 3:
        // Erzeugt ein O Tetromino in der Farbe gelb
        _tempColor = #yellow;
        temp = [
          { 'row' : height ~/ 2,      'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2 - 1 },
          { 'row' : height ~/ 2,      'col' : width ~/ 2     },
          { 'row' : height ~/ 2 + 1,  'col' : width ~/ 2     }
        ];
        break;
      case 4:
        // Erzeugt ein S Tetromino in der Farbe grün
        _tempColor = #green;
          temp = [
            { 'row' : height ~/ 2,       'col' : width ~/ 2      },
            { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 2  }
          ];
          break;
      case 5:
        // Erzeugt ein T Tetromino in der Farbe lila
        _tempColor = #purple;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 6:
        // Erzeugt ein Z Tetromino in der Farbe rot
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
   * Drehen des Tetromino um 90 Grad
   * Spiegelung um die Diagonalachse row = col, col = row
   * Spiegelung um die Vertikalachse col = Breite - 1 - Element
   **/
  void rotate(){
    //TODO: Richtige Rotation um 90 Grad
    //TODO: Aktualisierungsfehler des Spielfeldes
   var _rotate = [
      { 'row' : _stone.elementAt(0)['col'],  'col' : _game._sizeWidth - 1 - _stone.elementAt(0)['row'] },
      { 'row' : _stone.elementAt(1)['col'],  'col' : _game._sizeWidth - 1 - _stone.elementAt(1)['row'] },
      { 'row' : _stone.elementAt(2)['col'],  'col' : _game._sizeWidth - 1 - _stone.elementAt(2)['row'] },
      { 'row' : _stone.elementAt(3)['col'],  'col' : _game._sizeWidth - 1 - _stone.elementAt(3)['row'] }
    ];

    _stone = _rotate;
  }

  /**
   * Bewegungen von dem Tetromino und seine Richtungen (down, left, right)
   */
  void move() {
    var _move = [
      { 'row' : _stone.elementAt(0)['row'] + _dr,  'col' : _stone.elementAt(0)['col'] + _dc  },
      { 'row' : _stone.elementAt(1)['row'] + _dr,  'col' : _stone.elementAt(1)['col'] + _dc  },
      { 'row' : _stone.elementAt(2)['row'] + _dr,  'col' : _stone.elementAt(2)['col'] + _dc  },
      { 'row' : _stone.elementAt(3)['row'] + _dr,  'col' : _stone.elementAt(3)['col'] + _dc  }
    ];

    // Prüfen ob der Tetromino nicht die Seiten verlässt
    if (notOnSide(_move)){
      // Prüfen ob der Tetromino den Grund des Feldes erreicht
      //window.console.log('onGround: ${onGround(_move)}');
      if (notOnGround(_move)){
        //den Tetromino von der alten Postion entfernen
        this._stone.forEach((piece){
          this._game._field[piece['row']][piece['col']].isActive = false;
          this._game._field[piece['row']][piece['col']].color = #empty;
        });
        _stone = _move;
        //TODO: check if the current tetromino hit another tetromino that
        //is already placed on the field
      } else {
        nextTetromino();
      }
    }

    this._game.updateField();
  }

  /**
   * Teilt dem Tetromino die Bewegung nach unten mit [move]s.
   */
  void down()  { _dr =  1; _dc =  0; }

  /**
   * Teilt dem Tetromino die Bewegung nach links mit [move]s.
   */
  void left()  { _dr =  0; _dc = -1; }

  /**
   * Teilt dem Tetromino die Bewegung nach rechts mit [move]s.
   */
  void right() { _dr =  0; _dc =  1; }

  /**
   * Überprüfen ob der Tetromino an den Seiten angekommen ist
   * @param var moveTo = neue Position vom Tetromino
   * @return bool = true Seite nicht erreicht, false = Seite erreicht
   */
  bool notOnSide(var moveTo) {
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
   * Überprüfen ob der Tetromino am Grund angekommen ist
   * @param var moveTo = neue Position vom Tetromino
   * @return bool = true nicht den Boden berührt, false = Boden berührt
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
   * Gibt die Farbe des Tetromino im Spielfeld zurück.
   */
  Symbol get stoneColor => _stoneColor;

  /**
   * Gibt die Farbe des Tetromino im Nächsten-Tetromino-Feld zurück.
   */
  Symbol get nextstoneColor => _nextstoneColor;

  /**
   * Gibt die Elemente des Tetromino und die Position zurück.
   */
   get stone => _stone;

  /**
   * Gibt die Elemente des Tetromino für den nächsten Tetromino und die Position zurück.
   */
  get nextstone => _nextstone;

}