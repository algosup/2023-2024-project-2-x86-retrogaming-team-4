# Test Cases

## Overview
This document defines all the tests we will run on the application to ensure that it is working as expected.
The following tests will be done by playing the game and checking that the expected result is obtained.

## Priority

The priority of the test is defined by the following colors:
| Color | Priority |
| --- | --- |
| 🟨 | Low |
| 🟧 | Medium |
| 🟥 | High |

## 1. Start the game

| ID | 1 |
| --- | --- |
| Name | Start the game |
| Test Description | Verify that the game is starting well |
| Requirement(s) | The game is not started |
| Step(s) | 1. Run DOSBox, 2. Run PacMan file on DOSBox |
| Expected Result | The game start |
| Priority | 🟥 |

## 2. Stop the game

| ID | 2 |
| --- | --- |
| Name | Stop the game |
| Test Description | Verify that the game is stopping well |
| Requirement(s) | The game is started |
| Step(s) | 1. Run DOSBox, 2. Run PacMan file on DOSBox, 3. Press "esc" |
| Expected Result | The game stop |
| Priority | 🟥 |

## 3. Move left

| ID | 3 |
| --- | --- |
| Name | Move Pac-Man to the left with keyboard arrow |
| Test Description | Verify that Pac-Man can go left when user pressing the left arrow of the keyboard and there is no wall in this direction |
| Requirement(s) | The game is started |
| Step(s) |1. Start the game, 2. Press on the left arrow of the keyboard |
| Expected Result | Pac-Man move to the left in the game |
| Priority | 🟥 |

## 4. Move right

| ID | 4 |
| --- | --- |
| Name | Move Pac-Man to the right with keyboard arrow |
| Test Description | Verify that Pac-Man can go right when usery pressing the right arrow of the keyboard and there is no wall in this direction |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press on the right arrow of the keyboard |
| Expected Result | Pac-Man move to the right in the game |
| Priority | 🟥 |

## 5. Move up

| ID | 5 |
| --- | --- |
| Name | Move Pac-Man up with keyboard arrow |
| Test Description | Verify that Pac-Man can go up b when userressing the up arrow of the keyboard and there is no wall in this direction |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press on the up arrow of the keyboard |
| Expected Result | Pac-Man move to the up in the game |
| Priority | 🟥 |

## 6. Move down

| ID | 6 |
| --- | --- |
| Name | Move Pac-Man down with keyboard arrow |
| Test Description | Verify that Pac-Man can go down when user pressing the down arrow of the keyboard and there is no wall in this direction |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press on the down arrow of the keyboard |
| Expected Result | Pac-Man move to the down in the game |
| Priority | 🟥 |

## 7. Pac-Mac Collision: Wall

| ID | 7 |
| --- | --- |
| Name | Pac-Mac Collision : Wall |
| Test Description | Verify that Pac-Man is stopped by a wall and can't pass through it |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Move in the direction of a wall |
| Expected Result | Pac-Man should be stopped and not pass through it |
| Priority | 🟥 |

## 8. Pac-Mac Collision: Ghost Without Power Pellet

| ID | 8 |
| --- | --- |
| Name | Pac-Mac Collision: Ghost Without Power Pellet |
| Test Description | Verify that Pac-Man is killed by a ghost when he doesn't eat power pellet and collide it |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Move in the direction of a ghost |
| Expected Result | Pac-Man should be killed by the ghost |
| Priority | 🟥 |

## 9. Pac-Mac Collision: Ghost With a Power Pellet

| ID | 9 |
| --- | --- |
| Name | Pac-Mac Collision: Ghost With a Power Pellet |
| Test Description | Verify that Pac-Man kill a ghost when he eat power pellet and collide it |
| Requirement(s) | The game is started, Pac-Man eat power pellet |
| Step(s) | 1. Start the game, 2. Eat power pellet 3. Move in the direction of a ghost |
| Expected Result | Pac-Man should kill the ghost |
| Priority | 🟥 |

## 10. Pac-Mac Collision: Ghost eyes only

| ID | 10 |
| --- | --- |
| Name | Pac-Mac Collision : Ghost eyes |
| Test Description | Verify that Pac-Man not collide ghost's eyes when he cross only them |
| Requirement(s) | The game is started, Pac-Man eat power pellet |
| Step(s) | 1. Start the game, 2. Eat power pellet, 3. Kill a ghost, 4. Cross ghost eyes when they back to the ghost house |
| Expected Result | Pac-Man should cross them without any interaction |
| Priority | 🟥 |

## 11. Pac-Mac Eat Pellet

| ID | 11 |
| --- | --- |
| Name | Pac-Mac Eat Pellet |
| Test Description | Verify the interaction and effects of Pac-Man consuming regular pellets |
| Requirement(s) | The game is started, Pac-Man eat pellets |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat pellets |
| Expected Result | Pac-Man should consume the pellets, and the score should increase of 10 points |
| Priority | 🟨 |

## 12. Pac-Mac Eat Power pellet

| ID | 12 |
| --- | --- |
| Name | Pac-Mac Eat Power pellet |
| Test Description | Verify that Pac-Man can eat power pellet and that the ghosts become vulnerable and blue |
| Requirement(s) | The game is started, Pac-Man eat power pellets |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellets |
| Expected Result | The ghosts should become blue and vulnerable to Pac-Man and the score should increase of 50 points|
| Priority | 🟧 |


## 13. Pac-Mac Eat Cherry

| ID | 13 |
| --- | --- |
| Name | Pac-Mac Eat Bonus Fruits/Items |
| Test Description | Verify that Pac-Man can eat bonus fruits/items and that the score increase |
| Requirement(s) | The game is started, Pac-Man eat Cherry |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat Cherry |
| Expected Result | The score should increase |
| Priority | 🟨 |

## 14. Ghost Collision: Ghost

| ID | 14 |
| --- | --- |
| Name | Ghost Collision: Ghost |
| Test Description | Verify that ghosts can cross with each other without collision or visual bugs |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe ghost behavior |
| Expected Result | Ghosts should be able to cross each other without collision or visual bugs |
| Priority | 🟥 |


## 15. Ghost Collision: Wall

| ID | 15 |
| --- | --- |
| Name | Ghost Collision: Wall |
| Test Description | Verify that ghosts don't collide with walls and that they can't pass through it |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe ghost behavior |
| Expected Result | Ghosts should be able to move without collision with walls |
| Priority | 🟥 |

## 16. Ghosts Death

| ID | 16 |
| --- | --- |
| Name | Ghosts Death |
| Test Description | Verify that ghosts can die and that they return to the ghost house |
| Requirement(s) | The game is started, player kill a ghost|
| Step(s) | 1. Start the game, 2. Play game, 3. Kill a ghost, 4. Observe ghost behavior |
| Expected Result | Ghosts sprite should change to eyes and they should return to the ghost house |
| Priority | 🟥 |

## 17. Ghosts Respawn

| ID | 17 |
| --- | --- |
| Name | Ghosts Respawn |
| Test Description | Verify that ghosts can respawn after the eyes reach the ghost house |
| Requirement(s) | The game is started, player kill a ghost|
| Step(s) | 1. Start the game, 2. Play game, 3. Kill a ghost, 4. Observe ghost behavior |
| Expected Result | Ghosts should respawn after the eyes reach the ghost house |
| Priority | 🟥 |

## 18. Blinky (Red Ghost) Behavior: Chase Mode

| ID | 18 |
| --- | --- |
| Name | Blinky (Red Ghost) Behavior: Chase Mode |
| Test Description | Verify Blinky (red ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe Blinky behavior |
| Expected Result | Blinky should follow Pac-Man |
| Priority | 🟧 |

## 19. Pinky (Pink Ghost) Behavior: Chase Mode

| ID | 19 |
| --- | --- |
| Name | Pinky (Pink Ghost) Behavior: Chase Mode |
| Test Description | Verify Pinky (pink ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe Pinky behavior |
| Expected Result | Pinky should try to go 2 Pac-Dots in front of Pac-Man |
| Priority | 🟧 |

## 20. Inky (Blue Ghost) Behavior: Chase Mode

| ID | 20 |
| --- | --- |
| Name | Inky (Blue Ghost) Behavior: Chase Mode |
| Test Description | Verify Inky (blue ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe Inky behavior |
| Expected Result | Inky should select the two Pac-Dots positioned in front of Pac-Man in its current direction of travel. Imagine a vector from Blinky's position to this Pac-Dot, then double the length of the vector. The dots on which this extended vector ends will be the current target |
| Priority | 🟧 |


## 21. Clyde (Orange Ghost) Behavior: Chase Mode

| ID | 21 |
| --- | --- |
| Name | Clyde (Orange Ghost) Behavior: Chase Mode |
| Test Description | Verify Clyde (orange ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play game, 3. Observe Clyde behavior |
| Expected Result | Clyde should follow Pac-Man directly and try to head for his scatter corner when within 8 dots of Pac-Man |
| Priority | 🟧 |

## 22. Blinky (Red Ghost) Behavior: Scatter Mode

| ID | 22 |
| --- | --- |
| Name | Blinky (Red Ghost) Behavior: Scatter Mode |
| Test Description | Verify Blinky (red ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe Blinky behavior |
| Expected Result | Blinky should go to the top right corner |
| Priority | 🟧 |

## 23. Pinky (Pink Ghost) Behavior: Scatter Mode

| ID | 23 |
| --- | --- |
| Name | Pinky (Pink Ghost) Behavior: Scatter Mode |
| Test Description | Verify Pinky (pink ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe Pinky behavior |
| Expected Result | Pinky should go to the top left corner |
| Priority | 🟧 |

## 24. Inky (Blue Ghost) Behavior: Scatter Mode

| ID | 24 |
| --- | --- |
| Name | Inky (Blue Ghost) Behavior: Scatter Mode |
| Test Description | Verify Inky (blue ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe Inky behavior |
| Expected Result | Inky should go to the bottom right corner |
| Priority | 🟧 |

## 25. Clyde (Orange Ghost) Behavior: Scatter Mode

| ID | 25 |
| --- | --- |
| Name | Clyde (Orange Ghost) Behavior: Scatter Mode |
| Test Description | Verify Clyde (orange ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe Clyde behavior |
| Expected Result | Clyde should go to the bottom left corner |
| Priority | 🟧 |

## 26. Game Over Handling

| ID | 26 |
| --- | --- |
| Name | Game Over Handling |
| Test Description | Confirm appropriate handling of game over conditions |
| Requirement(s) | The player is playing to the game |
| Step(s) | 1. Start the game, 2. Play game, 3. Lose all Pac-Man's lives |
| Expected Result | The game should display a "Game Over" screen with the option to restart or exit |
| Priority | 🟨 |



## 27. Ghost Behavior: Return to Normal State

| ID | 27 |
| --- | --- |
| Name | Ghost Behavior: Return to Normal State |
| Test Description | Confirm that all ghosts return to their normal, active state after the vulnerable period |
| Requirement(s) | Pac-Man eat power pellets, and all ghosts are present in the game |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe ghost behavior after the vulnerable period expires |
| Expected Result | Blinky, Pinky, Inky, and Clyde should cease defensive behavior and resume their typical pursuit of Pac-Man |
| Priority | 🟧 |


## 28. Test Winning Conditions

| ID | 28 |
| --- | --- |
| Name | Test Winning Conditions |
| Test Description | Confirm that the game ends when all Pac-Dots are eaten |
| Requirement(s) | The player consume all dots within a level |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat all Pac-Dots |
| Expected Result | The game should run a "sound effect" and run the next level |
| Priority | 🟧 |

## 29. Test Power Pellet Duration

| ID | 29 |
| --- | --- |
| Name | Test Power Pellet Duration |
| Test Description | Confirm that the power pellet duration is 6 seconds |
| Requirement(s) | The player eat a power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe power pellet duration |
| Expected Result | The power pellet should last 6 seconds |
| Priority | 🟨 |


## 30. Test Ghost Vulnerability Period

| ID | 30 |
| --- | --- |
| Name | Test Ghost Vulnerability Period |
| Test Description | Confirm that the ghost vulnerability period is 6 seconds |
| Requirement(s) | The player eat a power pellet |
| Step(s) | 1. Start the game, 2. Play game, 3. Eat power pellet, 4. Observe ghost vulnerability period |
| Expected Result | The ghost vulnerability period should last 6 seconds |
| Priority | 🟧 |

