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
      _stone = randomTetromino(random, 0, this._game._sizeWidth);
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
      _nextstone = randomTetromino(_tempStone, this._game._nextStoneFieldHeight - 1, this._game._nextStoneFieldWidth);
      // Farbe setzen
      _nextstoneColor = _tempColor;
    }

    // sonst alle anderen Tetromino
    // Den normalen Tetromino erzeugen
    _stone = randomTetromino(_tempStone, 0, this._game._sizeWidth);

    //Die Zellen, welche von dem aktuellen Tetromino belegt sind als aktiv
    //makieren
    _stone.forEach((cell){
      this._game._field[cell['row']][cell['col']].isActive = true;
    });
    // Farbe setzen
    _stoneColor = _nextstoneColor;
    // Vorschau auf den nächsten Tetromino
    _tempStone = r.nextInt(7);
    _nextstone = randomTetromino(_tempStone, this._game._nextStoneFieldHeight - 1, this._game._nextStoneFieldWidth);
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
  List<Map<String, int>> randomTetromino(int random, int height, int width){
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
          { 'row' : height ~/ 2,       'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }
        ];
        break;
      case 2:
        // Erzeugt ein L Tetromino in der Farbe orange
        _tempColor = #orange;
        temp = [
          { 'row' : height ~/ 2,       'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  }
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
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 1  }, // Drehpunkt
            { 'row' : height ~/ 2,       'col' : width ~/ 2      },
            { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
            { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 - 2  }
          ];
          break;
      case 5:
        // Erzeugt ein T Tetromino in der Farbe lila
        _tempColor = #purple;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2,       'col' : width ~/ 2 + 1  }
        ];
        break;
      case 6:
        // Erzeugt ein Z Tetromino in der Farbe rot
        _tempColor = #red;
        temp = [
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2      }, // Drehpunkt
          { 'row' : height ~/ 2,       'col' : width ~/ 2 - 1  },
          { 'row' : height ~/ 2,       'col' : width ~/ 2      },
          { 'row' : height ~/ 2 + 1,   'col' : width ~/ 2 + 1  }

        ];
        break;
    }
    return temp;
  }


    /**
     * Drehen des Tetromino
     * @param int angle = winkel
     *
     * Anmerkungen:
     * Rotationsformal um einen Punkt um einen anderen um Winkel alpha rotieren zu lassen:
     * x' = x0 + (x - x0) * cos(alpha) - (y - y0) * sin(alpha)
     * y' = y0 + (x - x0) * sin(alpha) + (y - y0) * cos(alpha)
     * Der Computer erwartet als Eingabe für sin() und cos() keinen Winkel,
     * sondern ein Bogenmass, also den Umfang des Kreisabschnittes.
     * Um also aus dem Winkel das Bogenmass zu erhalten,
     * rechnen wir: Winkel / 180 * PI
     * Y-Achse = row / Height
     * X-Achse = col / width
     **/
    void rotate(angle){
      //TODO: Drehungen von I und O Tetromino fehlerhaft
      var _rotate = [
        { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(0)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(0)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(0)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(0)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
        { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(1)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(1)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(1)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(1)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
        { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(2)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(2)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(2)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(2)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() },
        { 'row' : (_stone.elementAt(0)['row'] + (_stone.elementAt(3)['col'] - _stone.elementAt(0)['col']) * sin(angle / 180 * PI) + (_stone.elementAt(3)['row'] - _stone.elementAt(0)['row']) * cos(angle / 180 * PI)).round(),  'col' : (_stone.elementAt(0)['col'] + (_stone.elementAt(3)['col'] - _stone.elementAt(0)['col']) * cos(angle / 180 * PI) - (_stone.elementAt(3)['row'] - _stone.elementAt(0)['row']) * sin(angle / 180 * PI)).round() }
      ];
      

      // Methode aufrufen um Kollisionen zu prüfen,
      // wenn Ja neuer Tetromino fallen lassen
      // ansonsten Stein Setzen
      checkCollisions(_rotate);


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

      // Methode aufrufen um Kollisionen zu prüfen,
      // wenn Ja neuer Tetromino fallen lassen
      // ansonsten Stein Setzen
      checkCollisions(_move);

    }


    /**
     * Teilt dem Tetromino die Bewegung nach unten mit.
     */
    void down()  { _dr =  1; _dc =  0; }

    /**
     * Teilt dem Tetromino die Bewegung nach links mit.
     */
    void left()  { _dr =  0; _dc = -1; }

    /**
     * Teilt dem Tetromino die Bewegung nach rechts mit.
     */
    void right() { _dr =  0; _dc =  1; }



  /**
   * Die Bewegungen des Tetromino auf Kollisionen prüfen.
   * Bei einer Kollision einen neuen Tetromino fallen lassen.
   * @param var moveTo = neue Position vom Tetromino
   */
  checkCollisions(var moveTo) {
    // Prüfen ob der Tetromino nicht die Seiten verlässt
    if (notOnSide(moveTo)){
      // Prüfen ob der Tetromino den Grund des Feldes erreicht
      //window.console.log('onGround: ${onGround(_move)}');
      if (notOnGround(moveTo)){
        //den Tetromino von der alten Postion entfernen
        this._stone.forEach((piece){
          this._game._field[piece['row']][piece['col']].isActive = false;
          this._game._field[piece['row']][piece['col']].color = #empty;
        });
        _stone = moveTo;
        this._game.updateField();
        //TODO: check if the current tetromino hit another tetromino that
        //is already placed on the field
      } else {
        nextTetromino();
      }
    }

  }

    /**
     * Überprüfen ob der Tetromino an den Seiten angekommen ist
     * @param var moveTo = neue Position vom Tetromino
     * @return bool = true Seite nicht erreicht, false = Seite erreicht
     */
    bool notOnSide(var moveTo) {
      bool stoneOne = moveTo.elementAt(0)['row'] >= 0&&
          moveTo.elementAt(0)['col'] >= 0 &&
          moveTo.elementAt(0)['col'] < this._game._sizeWidth;

      bool stoneTwo = moveTo.elementAt(1)['row'] >= 0&&
          moveTo.elementAt(1)['col'] >= 0 &&
          moveTo.elementAt(1)['col'] < this._game._sizeWidth;

      bool stoneThree = moveTo.elementAt(2)['row'] >= 0&&
          moveTo.elementAt(2)['col'] >= 0 &&
          moveTo.elementAt(2)['col'] < this._game._sizeWidth;

      bool stoneFour = moveTo.elementAt(3)['row'] >= 0&&
          moveTo.elementAt(3)['col'] >= 0 &&
          moveTo.elementAt(3)['col'] < this._game._sizeWidth;

      return stoneOne && stoneTwo && stoneThree && stoneFour;
    }

    /**
     * Überprüfen ob der Tetromino am Grund angekommen ist
     * @param var moveTo = neue Position vom Tetromino
     * @return bool = true nicht den Boden berührt, false = Boden berührt
     */
    bool notOnGround(var moveTo) {
      bool stoneOne = moveTo.elementAt(0)['row'] >= 0&&
          moveTo.elementAt(0)['row'] < this._game._sizeHeight;

      bool stoneTwo = moveTo.elementAt(1)['row'] >= 0&&
          moveTo.elementAt(1)['row'] < this._game._sizeHeight;

      bool stoneThree = moveTo.elementAt(2)['row'] >= 0&&
          moveTo.elementAt(2)['row'] < this._game._sizeHeight;

      bool stoneFour = moveTo.elementAt(3)['row'] >= 0&&
          moveTo.elementAt(3)['row'] < this._game._sizeHeight;

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