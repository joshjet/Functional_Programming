module LogicTest where
import Test.HUnit
import SantoriniRep
import TestBoards
import SantoriniLogic

-- Top level test case.
logicTests = TestList [TestLabel "isFullBoard Tests" fbTests,
                       TestLabel "Proximity Function Tests" proxTests,
                       TestLabel "getBuildable Tests" buildableTests,
                       TestLabel "getMoveable Tests" moveableTests,
                       TestLabel "movePlayer Tests" movePlayerTests,
                       TestLabel "buildLvl Tests" buildLvlTests,
                       TestLabel "placePlayer Tests" placePlayerTests]

-- Full Board tests
fbTests = TestList [TestLabel "Player 1 Start" fbP1,
                    TestLabel "Player 2 Start" fbP2,
                    TestLabel "Full Game"      fbFull]

fbP1 = TestCase (assertEqual
                       "Assert that we get walls when we're in the top left corner."
                       False
                       (isFullBoard p1IBoard))

fbP2 = TestCase (assertEqual
                       "Assert that we get walls when we're in the top left corner."
                       False
                       (isFullBoard p2IBoard))

fbFull = TestCase (assertEqual
                       "Assert that isFullBoard is true once we're past setup."
                       True
                       (isFullBoard provIBoard))

-- Proximity tests.
proxTests = TestList [TestLabel "Free Space Proximity" proxEmpt,
                      TestLabel "Wall Proximity" proxWall,
                      TestLabel "'Trapped by Walls' Proximity" proxTrap,
                      TestLabel "Ramp Proximity" proxRamp,
                      TestLabel "Player Proximity" proxPlayers]

proxEmpt = TestCase (assertEqual
                     "Assert that we can get a proximity from empty spaces."
                     [
                      Space (IPt 0 0) 0, Space (IPt 0 1)  0, Space (IPt 0 2) 0,
                      Space (IPt 1 0) 0, Space (IPt 1 1)  0, Space (IPt 1 2) 0,
                      Space (IPt 2 0) 0, Space (IPt 2 1)  0, Space (IPt 2 2) 0
                     ]
                     (getProx emptIBoard (IPt 1 1)))

proxWall = TestList [TestLabel "Top Left Corner" proxWallTL,
                     TestLabel "Top Right Corner" proxWallTR,
                     TestLabel "Bottom Left Corner" proxWallBL,
                     TestLabel "Bottom Right Corner" proxWallBR]


proxWallTL = TestCase (assertEqual
                       "Assert that we get walls when we're in the top left corner."
                       [
                        Wall , Wall              , Wall             ,
                        Wall , Player (IPt 0 0) 0, Space (IPt 0 1) 0,
                        Wall , Space  (IPt 1 0) 0, Space (IPt 1 1) 0
                       ]
                       (getProx cwiseIBoard (IPt 0 0)))

proxWallTR = TestCase (assertEqual
                       "Assert that we get walls when we're in the top right corner."
                       [
                        Wall             , Wall              , Wall,
                        Space (IPt 0 3) 0, Player (IPt 0 4) 0, Wall,
                        Space (IPt 1 3) 0, Space  (IPt 1 4) 0, Wall
                       ]
                       (getProx cwiseIBoard (IPt 0 4)))

proxWallBL = TestCase (assertEqual
                       "Assert that we get walls when we're in the bottom left corner."
                       [
                        Space (IPt 3 3) 0, Space  (IPt 3 4) 0, Wall,
                        Space (IPt 4 3) 0, Player (IPt 4 4) 0, Wall,
                        Wall             , Wall              , Wall
                       ]
                       (getProx cwiseIBoard (IPt 4 4)))

proxWallBR = TestCase (assertEqual
                       "Assert that we get walls when we're in the bottom right corner."
                       [
                        Wall , Space  (IPt 3 0) 0, Space (IPt 3 1) 0,
                        Wall , Player (IPt 4 0) 0, Space (IPt 4 1) 0,
                        Wall , Wall              , Wall
                       ]
                       (getProx cwiseIBoard (IPt 4 0)))

proxTrap = TestCase (assertEqual
                     "Assert that we get walls when we're near capped towers."
                     [
                      Wall , Wall              , Wall,
                      Wall , Player (IPt 1 1) 0, Wall,
                      Wall , Wall              , Wall
                     ]
                     (getProx trapIBoard (IPt 1 1)))

proxRamp = TestCase (assertEqual
                     "Assert that we get proper ordering and values by checking the Ramp board"
                     [
                      Space (IPt 0 0) 2 ,Space  (IPt 0 1) 3, Space (IPt 0 2) 2,
                      Space (IPt 1 0) 1 ,Player (IPt 1 1) 0, Space (IPt 1 2) 2,
                      Space (IPt 2 0) 2 ,Space  (IPt 2 1) 3, Space (IPt 2 2) 2
                     ]
                     (getProx ramp2WinIBoard (IPt 1 1)))

proxPlayers = TestList [TestLabel "Player proximity on flat ground." proxPlayersFlat,
                        TestLabel "Player proximity on a set of steps" proxPlayersSteps]

proxPlayersFlat = TestCase (assertEqual
                        "Assert that we get players back from proximity (Flat)"
                        [
                         Space (IPt 2 2) 0 ,Space  (IPt 2 3) 0, Space  (IPt 2 4) 0,
                         Space (IPt 3 2) 0 ,Player (IPt 3 3) 0, Player (IPt 3 4) 0,
                         Space (IPt 4 2) 0 ,Player (IPt 4 3) 0, Player (IPt 4 4) 0
                        ]
                        (getProx emptIBoard (IPt 3 3)))

proxPlayersSteps = TestCase (assertEqual
                        "Assert that we get players back from proximity (Steps)"
                        [
                         Player (IPt 0 0) 3, Player (IPt 0 1) 2, Space (IPt 0 2) 0,
                         Player (IPt 1 0) 2, Player (IPt 1 1) 1, Space (IPt 1 2) 0,
                         Space  (IPt 2 0) 0, Space  (IPt 2 1) 0, Space (IPt 2 2) 0
                        ]
                        (getProx p1WIBoard (IPt 1 1)))

-- Buildable Tests
-- NOTE: We can get away with testing this a little less thoroughly, because
--       getProx is tested extensively.
buildableTests = TestList [TestLabel "Flat Space is Buildable" bFlat,
                           TestLabel "Stepped Space is Buildable" bRamp,
                           TestLabel "Towers can be capped" bBlock,
                           TestLabel "Players are not Buildable" nbPlayers,
                           TestLabel "Walls are not Buildable" nbWalls]

bFlat = TestCase (assertEqual
                  "Assert that we can build on flat, empty spaces."
                  [Space (IPt 0 0) 0, Space (IPt 0 1)  0, Space (IPt 0 2) 0,
                   Space (IPt 1 0) 0, Space (IPt 1 1)  0, Space (IPt 1 2) 0,
                   Space (IPt 2 0) 0, Space (IPt 2 1)  0, Space (IPt 2 2) 0
                  ]
                  (getBuildable emptIBoard (IPt 1 1)))

bRamp = TestCase (assertEqual
                  "Assert that we can build on other planes ('stepped' space)"
                  [
                   Space (IPt 0 0) 2 ,Space  (IPt 0 1) 2, Space (IPt 0 2) 2,
                   Space (IPt 1 0) 1 ,{- PLAYER -}        Space (IPt 1 2) 2,
                   Space (IPt 2 0) 2 ,Space  (IPt 2 1) 2, Space (IPt 2 2) 2
                  ]
                  (getBuildable ramp2BuildIBoard (IPt 1 1)))

bBlock = TestCase (assertEqual
                  "Assert that we can build to block players from winning."
                  [
                   Space (IPt 0 0) 2 ,Space  (IPt 0 1) 3, Space (IPt 0 2) 2,
                   Space (IPt 1 0) 1 ,{- PLAYER -}        Space (IPt 1 2) 2,
                   Space (IPt 2 0) 2 ,Space  (IPt 2 1) 3, Space (IPt 2 2) 2
                  ]
                  (getBuildable ramp2WinIBoard (IPt 1 1)))

nbPlayers = TestCase (assertEqual
                      "Assert that we can't build on player spaces."
                      [Space (IPt 2 2) 0, Space (IPt 2 3)  0, Space (IPt 2 4) 0,
                       Space (IPt 3 2) 0, -- MISSING, AS THERE ARE PLAYERS
                       Space (IPt 4 2) 0  -- IN THESE LOCATIONS.
                      ]
                      (getBuildable emptIBoard (IPt 3 3)))

nbWalls = TestCase (assertEqual
                    "Assert that we can't build on walls."
                    [-- WALLS ----------------------------------
                     {-Wall-} Space (IPt 0 0) 0, Space (IPt 0 1) 0,
                     {-Wall-} Space (IPt 1 0) 0, Space (IPt 1 1) 0
                    ]
                    (getBuildable emptIBoard (IPt 0 0)))

-- Movable Tests
-- NOTE: This is the same as buildable. We test the general proximity function
--       pretty well.

-- NOTE 2: These test cases often return a space at the point called. In
--         practice, there'll always be a player there, and we handle that
--         independently, so it's not a problem. Maybe an advantage, when cards
--         come along.
moveableTests = TestList [TestLabel "Walls cannot be moved to" nmWalls,
                          TestLabel "Players cannot be moved to" nmPlayers,
                          TestLabel "We can move to flat spaces" mFlat,
                          TestLabel "We can move up by 1 vertical level" mUp,
                          TestLabel "We can move down by one vertical level" mDown,
                          TestLabel "We can move either up or down" mUpDown]

nmWalls = TestCase (assertEqual
                    "Assert that we can't move to walls."
                    [-- WALLS ----------------------------------
                     {-Wall-} Space (IPt 0 0) 0, Space (IPt 0 1) 0,
                     {-Wall-} Space (IPt 1 0) 0, Space (IPt 1 1) 0
                    ]
                    (getMoveable emptIBoard (IPt 0 0)))

nmPlayers = TestCase (assertEqual
                      "Assert that we can't move to player spaces."
                      [Space (IPt 2 2) 0, Space (IPt 2 3)  0, Space (IPt 2 4) 0,
                       Space (IPt 3 2) 0, -- MISSING, AS THERE ARE PLAYERS
                       Space (IPt 4 2) 0  -- IN THESE LOCATIONS.
                      ]
                      (getMoveable emptIBoard (IPt 3 3)))

mFlat = TestCase (assertEqual
                  "Assert that we can move to flat, empty spaces."
                  [
                   Space (IPt 0 0) 0, Space (IPt 0 1)  0, Space (IPt 0 2) 0,
                   Space (IPt 1 0) 0, Space (IPt 1 1)  0, Space (IPt 1 2) 0,
                   Space (IPt 2 0) 0, Space (IPt 2 1)  0, Space (IPt 2 2) 0
                  ]
                  (getMoveable emptIBoard (IPt 1 1)))

mUp = TestCase (assertEqual
                "Assert that we can't move to planes more than 1 step above the source space"
                [
                 Space (IPt 0 0) 1, Space (IPt 0 1) 1, Space (IPt 0 2) 1,
                 Space (IPt 1 0) 1, {-    Player    -} {-    Too High   -}
                 Space (IPt 2 0) 1, {-   Too High   -} Space (IPt 2 2) 1
                ]
                (getMoveable moundIBoard (IPt 1 1)))

mDown = TestCase (assertEqual
                  "Assert that we can't move to planes more than 1 step below the source space"
                  [
                   Space (IPt 0 1) 1, Space (IPt 0 2)  1, Space (IPt 0 3) 1,
                   {-   Too Low    -} Space (IPt 1 2)  2, {-   Too Low    -}
                   Space (IPt 2 1) 2, Space (IPt 2 2)  1, Space (IPt 2 3) 2
                  ]
                  (getMoveable moundIBoard (IPt 1 2)))

mUpDown = TestCase (assertEqual
                    "Assert that we can move either up or down, given they're reachable."
                    [{-    Wall    -} {-     Wall     -} {-     Wall     -}
                     {-    Wall    -} Space (IPt 0 0) 2, Space (IPt 0 1)  3,
                     {-    Wall    -} Space (IPt 1 0) 1  {-  Player/Low   -}
                    ]
                    (getMoveable ramp2WinIBoard (IPt 0 0)))
-- Board Mutation Tests

-- movePlayer Tests
movePlayerTests =
  TestList
    [ TestLabel "Players can be moved from flat ground." mPFlat,
      TestLabel "Players can be moved from uneven ground." mPUneven,
      TestLabel "Players can be moved to any location." mPAnywhere,
      TestLabel "Players can be moved to any altitude." mPAnyAlt
    ]

mPFlat =
  TestCase
    ( assertEqual
        "Assert that we can move a player on flat ground."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers =
                [ [IPt 3 1, IPt 4 4],
                  [IPt 0 4, IPt 0 0]
                ]
            }
        )
        (movePlayer cwPlayersIBoard4 (IPt 4 0) (IPt 3 1))
    )

mPUneven =
  TestCase
    ( assertEqual
        "Assert that we can move a player on uneven ground."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers =
                [ [IPt 3 1, IPt 4 4],
                  [IPt 0 4, IPt 0 0]
                ]
            }
        )
        (movePlayer cwPlayersIBoard4 (IPt 4 0) (IPt 3 1))
    )

mPAnywhere =
  TestCase
    ( assertEqual
        "Assert that we can move a player anywhere on the board."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers =
                [ [IPt 3 1, IPt 4 4],
                  [IPt 0 4, IPt 0 0]
                ]
            }
        )
        (movePlayer cwPlayersIBoard4 (IPt 4 0) (IPt 3 1))
    )

mPAnyAlt =
  TestCase
    ( assertEqual
        "Assert that we can move a player to any non-wall altitude."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers =
                [ [IPt 3 1, IPt 4 4],
                  [IPt 0 4, IPt 0 0]
                ]
            }
        )
        (movePlayer cwPlayersIBoard4 (IPt 4 0) (IPt 3 1))
    )

-- buildLvl Tests
buildLvlTests =
  TestList
    [ TestLabel "Tiles can be built to Level 1." bLLvl1,
      TestLabel "Tiles can be built to Level 2." bLLvl2,
      TestLabel "Tiles can be built to Level 3." bLLvl3,
      TestLabel "Tiles can be built into walls." bLWall,
      TestLabel "We can build everywhere on the board." bLEverywhere
    ]

bLLvl1 =
  TestCase
    ( assertEqual
        "Assert that we can build to level 1."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [1, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers = []
            }
        )
        (buildLvl gIBoardEmpty (IPt 0 0))
    )

bLLvl2 =
  TestCase
    ( assertEqual
        "Assert that we can build to level 2."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [2, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers = []
            }
        )
        ( foldl
            buildLvl
            gIBoardEmpty
            (replicate 2 (IPt 0 0))
        )
    )

bLLvl3 =
  TestCase
    ( assertEqual
        "Assert that we can build to level 3."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [3, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0],
                  [0, 0, 0, 0, 0]
                ],
              iplayers = []
            }
        )
        ( foldl
            buildLvl
            gIBoardEmpty
            (replicate 3 (IPt 0 0))
        )
    )


bLWall =
  TestCase
    ( assertEqual
        "Assert that we can build into walls."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [gIWallHeight, 0, 0, 0, 0],
                  [0,            0, 0, 0, 0],
                  [0,            0, 0, 0, 0],
                  [0,            0, 0, 0, 0],
                  [0,            0, 0, 0, 0]
                ],
              iplayers =
                []
            }
        )
        ( foldl
            buildLvl
            gIBoardEmpty
            (replicate 4 (IPt 0 0))
        )
    )

bLEverywhere =
  TestCase
    ( assertEqual
        "Assert that we can build everywhere on an empty board."
        ( IBoard
            { iturn = -1,
              ispaces =
                [ [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 1, 1, 1, 1]
                ],
              iplayers =
                []
            }
        )
        ( foldl
            buildLvl
            gIBoardEmpty
            [ IPt
                row
                col
              | row <- [0..(row gBrdBnd)],
                col <- [0..(col gBrdBnd)]
            ]
        )
    )

-- Place Player Tests
placePlayerTests =
  TestList
    [ TestLabel "Players can be placed in the top left." placePlayerTL,
      TestLabel "Players can be placed in the top right." placePlayerTR,
      TestLabel "Players can be placed in the bottom right." placePlayerBR,
      TestLabel "Players can be placed in the bottom left." placePlayerBL
    ]

placePlayerTL =
  TestCase
    ( assertEqual
        "Assert that we can place a player in the top left corner."
        cwPlayersIBoard1
        (placePlayer p1IBoard (IPt 0 0))
    )

placePlayerTR =
  TestCase
    ( assertEqual
        "Assert that we can place a player in the top right corner."
        cwPlayersIBoard2
        (placePlayer cwPlayersIBoard1 (IPt 0 4))
    )

placePlayerBL =
  TestCase
    ( assertEqual
        "Assert that we can place a player in the bottom left corner."
        cwPlayersIBoard3
        (placePlayer cwPlayersIBoard2 (IPt 4 4))
    )

placePlayerBR =
  TestCase
    ( assertEqual
        "Assert that we can place a player in the bottom right corner."
        cwPlayersIBoard4
        (placePlayer cwPlayersIBoard3 (IPt 4 0))
    )
