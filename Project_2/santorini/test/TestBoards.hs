module TestBoards where
import SantoriniRep
-- Some standard boards, for testing.

-- Player 1 Setup
p1BoardStr =
  "[{\"card\":\"Artemis\"}, \
   \{\"card\":\"Prometheus\"}]"

p1JBoard =
  JBoard
    { turn = Nothing,
      spaces = Nothing,
      players = [ JPlayer {card = "Artemis", tokens = Nothing},
                  JPlayer {card = "Prometheus", tokens = Nothing}
                ]
    }
p1IBoard = fromJBoard p1JBoard

-- Player 2 Setup
p2BoardStr = "[{\"card\":\"Prometheus\"}, \
              \{\"card\":\"Artemis\",\"tokens\":[[2,3],[4,4]]}]"

p2JBoard =
  JBoard
    { turn = Nothing,
      spaces = Nothing,
      players = [ JPlayer { card = "Prometheus", tokens = Nothing},
                  JPlayer { card = "Artemis", tokens = Just [[2, 3], [4, 4]]}
                ]
    }
p2IBoard = fromJBoard p1JBoard

-- One of the provided boards.
provBoardStr =
    "{\"players\":[{\"card\":\"Artemis\",\"tokens\":[[2,3],[4,4]]},\
                  \{\"card\":\"Prometheus\",\"tokens\":[[2,5],[3,5]]}],\
    \ \"spaces\":[[0,0,0,0,2],\
                 \[1,1,2,0,0],\
                 \[1,0,0,3,0],\
                 \[0,0,3,0,0],\
                 \[0,0,0,1,4]],\
    \ \"turn\":18}"

provJBoard =
  JBoard
    { turn = Just 18,
      spaces =
        Just
          [ [0, 0, 0, 0, 2],
            [1, 1, 2, 0, 0],
            [1, 0, 0, 3, 0],
            [0, 0, 3, 0, 0],
            [0, 0, 0, 1, 4]
          ],
      players =
        [ JPlayer { card = "Artemis", tokens = Just [[2, 3], [4, 4]]},
          JPlayer { card = "Prometheus", tokens = Just [[2, 5], [3, 5]]}
        ]
    }
provIBoard = fromJBoard provJBoard

-- An empty board, with the four players clustered in the
-- bottom left-hand corner.
emptBoardStr =
  "{\"players\":[{\"card\":\"Apollo\",\"tokens\":[[4,4],[4,5]]},\
                \{\"card\":\"Artemis\",\"tokens\":[[5,4],[5,5]]}],\
   \ \"spaces\":[[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0]],\
   \ \"turn\":1}"

emptJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[4, 4], [4, 5]]},
          JPlayer { card = "Artemis", tokens = Just [[5, 4], [5, 5]]}
        ]
    }
emptIBoard = fromJBoard emptJBoard

-- An empty board, where the player positions are all in the corners, listed
-- alternatingly by player and clockwise.
cwiseBoardStr =
  "{\"players\":[{\"card\":\"Apollo\",\"tokens\":[[1,1],[5,5]]},\
                \{\"card\":\"Artemis\",\"tokens\":[[1,5],[5,1]]}],\
   \ \"spaces\":[[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0]],\
   \ \"turn\":1}"

cwiseJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[1, 1], [5, 5]]},
          JPlayer { card = "Artemis", tokens = Just [[1, 5], [5, 1]]}
        ]
    }
cwiseIBoard = fromJBoard cwiseJBoard

-- An empty board, where the player positions are all in the corners, listed
-- alternatingly by player and counter-clockwise.
ccwiseBoardStr =
  "{\"players\":[{\"card\":\"Apollo\",\"tokens\":[[5,1],[1,5]]},\
                \{\"card\":\"Artemis\",\"tokens\":[[5,5],[1,1]]}],\
   \ \"spaces\":[[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0],\
                \[0,0,0,0,0]],\
   \ \"turn\":1}"

ccwiseJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[5, 1], [1, 5]]},
          JPlayer { card = "Artemis", tokens = Just [[5, 5], [1, 1]]}
        ]
    }
ccwiseIBoard = fromJBoard ccwiseJBoard

-- A board where all players are trapped.
trapJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [4, 4, 4, 4, 4],
            [4, 0, 4, 0, 4],
            [4, 4, 4, 4, 4],
            [4, 0, 4, 0, 4],
            [4, 4, 4, 4, 4]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 2], [2, 4]]},
          JPlayer { card = "Artemis", tokens = Just [[4, 2], [4, 4]]}
        ]
    }
trapIBoard = fromJBoard trapJBoard

-- A board where all players are surrounded by movable, but uneven, spaces.
moundJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [1, 1, 1, 1, 1],
            [1, 0, 2, 0, 1],
            [1, 2, 1, 2, 1],
            [1, 0, 2, 0, 1],
            [1, 1, 1, 1, 1]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 2], [2, 4]]},
          JPlayer { card = "Artemis", tokens = Just [[4, 2], [4, 4]]}
        ]
    }
moundIBoard = fromJBoard moundJBoard

-- A board where all players are trapped. Buildable, just not movable.
btrapJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [2, 2, 2, 2, 2],
            [2, 0, 2, 0, 2],
            [2, 2, 2, 2, 2],
            [2, 0, 2, 0, 2],
            [2, 2, 2, 2, 2]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 2], [2, 4]]},
          JPlayer { card = "Artemis", tokens = Just [[4, 2], [4, 4]]}
        ]
    }
btrapIBoard = fromJBoard trapJBoard

-- A board where players' only options is to go up a ramp to win.
ramp2WinJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [2, 3, 2, 3, 2],
            [1, 0, 2, 0, 1],
            [2, 3, 2, 3, 2],
            [1, 0, 2, 0, 1],
            [2, 2, 2, 2, 2]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 2], [2, 4]]},
          JPlayer { card = "Artemis", tokens = Just [[4, 2], [4, 4]]}
        ]
    }
ramp2WinIBoard = fromJBoard ramp2WinJBoard

-- A board where players can't win without building, with ramps.
ramp2BuildJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [2, 2, 2, 2, 2],
            [1, 0, 2, 0, 1],
            [2, 2, 2, 2, 2],
            [1, 0, 2, 0, 1],
            [2, 2, 2, 2, 2]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 2], [2, 4]]},
          JPlayer { card = "Artemis", tokens = Just [[4, 2], [4, 4]]}
        ]
    }
ramp2BuildIBoard = fromJBoard ramp2BuildJBoard

-- A board where all four players are clustered at the top right corner, with
-- the first player winning
p1WJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [3, 2, 0, 0, 0],
            [2, 1, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[1, 1], [2, 2]]},
          JPlayer { card = "Artemis", tokens = Just [[2, 1], [1, 2]]}
        ]
    }
p1WIBoard = fromJBoard p1WJBoard

-- A board where all four players are clustered at the top right corner, with
-- the second player winning
p2WJBoard =
  JBoard
    { turn = Just 1,
      spaces =
        Just
          [ [3, 2, 0, 0, 0],
            [2, 1, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Apollo", tokens = Just [[2, 1], [1, 2]]},
          JPlayer { card = "Artemis", tokens = Just [[1, 1], [2, 2]]}
        ]
    }
p2WIBoard = fromJBoard p1WJBoard

-- A flat board with players in all four corners.
-- Four boards, with a player added to each corner, clockwise.
cwPlayersJBoard1 =
  JBoard
    { turn = Just (-1),
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Artemis", tokens = Just [[1, 1]] },
          JPlayer { card = "Prometheus", tokens = Nothing }
        ]
    }
cwPlayersIBoard1 = fromJBoard cwPlayersJBoard1

cwPlayersJBoard2 =
  JBoard
    { turn = Just (-1),
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Artemis", tokens = Just [[1, 5], [1, 1]]},
          JPlayer { card = "Prometheus", tokens = Nothing }
        ]
    }
cwPlayersIBoard2 = fromJBoard cwPlayersJBoard2

-- CWBoard: Flip players so Prometheus is placing.
cwPlayersJBoard2Flip =
  JBoard
    { turn = Just (-1),
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Prometheus", tokens = Nothing },
          JPlayer { card = "Artemis", tokens = Just [[1, 5], [1, 1]]}
        ]
    }
cwPlayersIBoard2Flip = fromJBoard cwPlayersJBoard2Flip

cwPlayersJBoard3 =
  JBoard
    { turn = Just (-1),
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Prometheus", tokens = Just [[5, 5]]},
          JPlayer { card = "Artemis", tokens = Just [[1, 5], [1, 1]]}
        ]
    }
cwPlayersIBoard3 = fromJBoard cwPlayersJBoard3

cwPlayersJBoard4 =
  JBoard
    { turn = Just (-1),
      spaces =
        Just
          [ [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
          ],
      players =
        [ JPlayer { card = "Prometheus", tokens = Just [[5, 1], [5, 5]]},
          JPlayer { card = "Artemis", tokens = Just [[1, 5], [1, 1]]}
        ]
    }
cwPlayersIBoard4 = fromJBoard cwPlayersJBoard4
