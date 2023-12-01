# Test Cases

## Overview

This document outlines the test scenarios to ensure the proper functioning of the Pac-Man application during gameplay.

## Priority

Test priorities are indicated by the following colors:
| Color | Priority |
| --- | --- |
| 🟨 | Low |
| 🟧 | Medium |
| 🟥 | High |

## 1. Start the Game

| ID | T01 |
| --- | --- |
| Name | Start the Game |
| Test Description | Verify that the game starts successfully |
| Requirement(s) | The game is not started |
| Step(s) | 1. Launch DOSBox, 2. Execute Pac-Man file in DOSBox |
| Expected Result | The game starts |
| Priority | 🟥 |

## 2. Stop the Game

| ID | T02 |
| --- | --- |
| Name | Stop the Game |
| Test Description | Verify that the game stops properly |
| Requirement(s) | The game is started |
| Step(s) | 1. Launch DOSBox, 2. Execute Pac-Man file in DOSBox, 3. Press "ESC" key |
| Expected Result | The game stops |
| Priority | 🟥 |

## 3. Move Pac-Man Left

| ID | T03 |
| --- | --- |
| Name | Move Pac-Man Left |
| Test Description | Verify Pac-Man moves left when the left arrow key is pressed and there is no wall |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press the left arrow key |
| Expected Result | Pac-Man moves left |
| Priority | 🟥 |

## 4. Move Pac-Man Right

| ID | T04 |
| --- | --- |
| Name | Move Pac-Man Right |
| Test Description | Verify Pac-Man moves right when the right arrow key is pressed and there is no wall |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press the right arrow key |
| Expected Result | Pac-Man moves right |
| Priority | 🟥 |

## 5. Move Pac-Man Up

| ID | T05 |
| --- | --- |
| Name | Move Pac-Man Up |
| Test Description | Verify Pac-Man moves up when the up arrow key is pressed and there is no wall |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press up arrow key |
| Expected Result | Pac-Man moves up |
| Priority | 🟥 |

## 6. Move Pac-Man Down

| ID | T06 |
| --- | --- |
| Name | Move Pac-Man Down |
| Test Description | Verify Pac-Man moves down when the down arrow key is pressed and there is no wall |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Press the down arrow key |
| Expected Result | Pac-Man moves down |
| Priority | 🟥 |

## 7. Pac-Man Collision: Wall

| ID | T07 |
| --- | --- |
| Name | Pac-Man Collision: Wall |
| Test Description | Verify Pac-Man is stopped by a wall and cannot pass through it |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Move toward a wall |
| Expected Result | Pac-Man is stopped and cannot pass through the wall |
| Priority | 🟥 |

## 8. Pac-Man Collision: Ghost Without Power Pellet

| ID | T08 |
| --- | --- |
| Name | Pac-Man Collision: Ghost Without Power Pellet |
| Test Description | Verify Pac-Man is killed by a ghost when colliding without a power pellet |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Move toward a ghost |
| Expected Result | Pac-Man is killed by the ghost |
| Priority | 🟥 |

## 9. Pac-Man Collision: Ghost With a Power Pellet

| ID | T09 |
| --- | --- |
| Name | Pac-Man Collision: Ghost With a Power Pellet |
| Test Description | Verify Pac-Man kills a ghost when colliding with a power pellet |
| Requirement(s) | The game is started, Pac-Man eats a power pellet |
| Step(s) | 1. Start the game, 2. Eat a power pellet, 3. Move toward a ghost |
| Expected Result | Pac-Man kills the ghost |
| Priority | 🟥 |

## 10. Pac-Man Collision: Ghost Eyes Only

| ID | T10 |
| --- | --- |
| Name | Pac-Man Collision: Ghost Eyes Only |
| Test Description | Verify Pac-Man does not collide with ghost's eyes when crossing them |
| Requirement(s) | The game is started, Pac-Man eats a power pellet |
| Step(s) | 1. Start the game, 2. Eat a power pellet, 3. Kill a ghost, 4. Cross ghost eyes when they return to the ghost house |
| Expected Result | Pac-Man should cross ghost eyes without any interaction |
| Priority | 🟥 |

## 11. Pac-Man Eat Pellet

| ID | T11 |
| --- | --- |
| Name | Pac-Man Eat Pellet |
| Test Description | Verify the interaction and effects of Pac-Man consuming regular pellets |
| Requirement(s) | The game is started, Pac-Man eats pellets |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat pellets |
| Expected Result | Pac-Man should consume the pellets, and the score should increase by 10 points |
| Priority | 🟨 |

## 12. Pac-Man Eat Power Pellet

| ID | T12 |
| --- | --- |
| Name | Pac-Man Eat Power Pellet |
| Test Description | Verify that Pac-Man can eat power pellets and ghosts become vulnerable and blue |
| Requirement(s) | The game is started, Pac-Man eats power pellets |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat power pellets |
| Expected Result | Ghosts should become blue and vulnerable to Pac-Man, and the score should increase by 50 points |
| Priority | 🟧 |

## 13. Pac-Man Eat Cherry

| ID | T13 |
| --- | --- |
| Name | Pac-Man Eat Bonus Fruits/Items |
| Test Description | Verify that Pac-Man can eat Cherry and the score increases |
| Requirement(s) | The game is started, and Pac-Man eats a Cherry |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a Cherry |
| Expected Result | The score should increase of 100 points |
| Priority | 🟨 |

## 14. Ghost Collision: Ghost

| ID | T14 |
| --- | --- |
| Name | Ghost Collision: Ghost |
| Test Description | Verify that ghosts can cross each other without collision or visual bugs |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe ghost behavior |
| Expected Result | Ghosts should be able to cross each other without collision or visual bugs |
| Priority | 🟥 |

## 15. Ghost Collision: Wall

| ID | T15 |
| --- | --- |
| Name | Ghost Collision: Wall |
| Test Description | Verify that ghosts don't collide with walls and can't pass through them |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe ghost behavior |
| Expected Result | Ghosts should be able to move without collision with walls |
| Priority | 🟥 |

## 16. Ghosts Death

| ID | T16 |
| --- | --- |
| Name | Ghosts Death |
| Test Description | Verify that ghosts can die and return to the ghost house |
| Requirement(s) | The game is started, player kills a ghost |
| Step(s) | 1. Start the game, 2. Play the game, 3. Kill a ghost, 4. Observe ghost behavior |
| Expected Result | Ghost sprite should change to eyes, and they should return to the ghost house |
| Priority | 🟥 |

## 17. Ghosts Respawn

| ID | T17 |
| --- | --- |
| Name | Ghosts Respawn |
| Test Description | Verify that ghosts can respawn after the eyes reach the ghost house |
| Requirement(s) | The game is started, player kills a ghost |
| Step(s) | 1. Start the game, 2. Play the game, 3. Kill a ghost, 4. Observe ghost behavior |
| Expected Result | Ghosts should respawn after the eyes reach the ghost house |
| Priority | 🟥 |

## 18. Blinky (Red Ghost) Behavior: Chase Mode

| ID | T18 |
| --- | --- |
| Name | Blinky (Red Ghost) Behavior: Chase Mode |
| Test Description | Verify Blinky's (red ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe Blinky behavior |
| Expected Result | Blinky should follow Pac-Man |
| Priority | 🟧 |

## 19. Pinky (Pink Ghost) Behavior: Chase Mode

| ID | T19 |
| --- | --- |
| Name | Pinky (Pink Ghost) Behavior: Chase Mode |
| Test Description | Verify Pinky's (pink ghost) behavior when she is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe Pinky behavior |
| Expected Result | Pinky should try to go 2 Pac-Dots in front of Pac-Man |
| Priority | 🟧 |

## 20. Inky (Blue Ghost) Behavior: Chase Mode

| ID | T20 |
| --- | --- |
| Name | Inky (Blue Ghost) Behavior: Chase Mode |
| Test Description | Verify Inky's (blue ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe Inky behavior |
| Expected Result | Inky should select the two Pac-Dots positioned in front of Pac-Man in its current direction of travel |
| Priority | 🟧 |

## 21. Clyde (Orange Ghost) Behavior: Chase Mode

| ID | T21 |
| --- | --- |
| Name | Clyde (Orange Ghost) Behavior: Chase Mode |
| Test Description | Verify Clyde's (orange ghost) behavior when he is in chase mode |
| Requirement(s) | The game is started |
| Step(s) | 1. Start the game, 2. Play the game, 3. Observe Clyde's behavior |
| Expected Result | Clyde should follow Pac-Man directly and try to head for his scatter corner when within 8 dots of Pac-Man |
| Priority | 🟧 |

## 22. Blinky (Red Ghost) Behavior: Scatter Mode

| ID | T22 |
| --- | --- |
| Name | Blinky (Red Ghost) Behavior: Scatter Mode |
| Test Description | Verify Blinky's (red ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe Blinky behavior |
| Expected Result | Blinky should go to the top right corner |
| Priority | 🟧 |

## 23. Pinky (Pink Ghost) Behavior: Scatter Mode

| ID | T23 |
| --- | --- |
| Name | Pinky (Pink Ghost) Behavior: Scatter Mode |
| Test Description | Verify Pinky's (pink ghost) behavior when she is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe Pinky behavior |
| Expected Result | Pinky should go to the top left corner |
| Priority | 🟧 |

## 24. Inky (Blue Ghost) Behavior: Scatter Mode

| ID | T24 |
| --- | --- |
| Name | Inky (Blue Ghost) Behavior: Scatter Mode |
| Test Description | Verify Inky's (blue ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe Inky behavior |
| Expected Result | Inky should go to the bottom right corner |
| Priority | 🟧 |

## 25. Clyde (Orange Ghost) Behavior: Scatter Mode

| ID | T25 |
| --- | --- |
| Name | Clyde (Orange Ghost) Behavior: Scatter Mode |
| Test Description | Verify Clyde's (orange ghost) behavior when he is in scatter mode |
| Requirement(s) | The game is started, eat power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe Clyde's behavior |
| Expected Result | Clyde should go to the bottom left corner |
| Priority | 🟧 |

## 26. Game Over Handling

| ID | T26 |
| --- | --- |
| Name | Game Over Handling |
| Test Description | Confirm appropriate handling of game over conditions |
| Requirement(s) | The player is playing the game |
| Step(s) | 1. Start the game, 2. Play the game, 3. Lose all Pac-Man's lives |
| Expected Result | The game should display a "Game Over" screen with the option to restart or exit |
| Priority | 🟨 |

## 27. Ghost Behavior: Return to Normal State

| ID | T27 |
| --- | --- |
| Name | Ghost Behavior: Return to Normal State |
| Test Description | Confirm that all ghosts return to their normal, active state after the vulnerable period |
| Requirement(s) | Pac-Man eats power pellets, and all ghosts are present in the game |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe ghost behavior after the vulnerable period expires |
| Expected Result | Blinky, Pinky, Inky, and Clyde should cease defensive behavior and resume their typical pursuit of Pac-Man |
| Priority | 🟧 |

## 28. Test Winning Conditions

| ID | T28 |
| --- | --- |
| Name | Test Winning Conditions |
| Test Description | Confirm that the game ends when all Pac-Dots are eaten |
| Requirement(s) | The player consumes all dots within a level |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat all Pac-Dots |
| Expected Result | The game should run a "sound effect" and move to the next level |
| Priority | 🟧 |

## 29. Test Power Pellet Duration

| ID | T29 |
| --- | --- |
| Name | Test Power Pellet Duration |
| Test Description | Confirm that the power pellet duration is 6 seconds |
| Requirement(s) | The player eats a power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe power pellet duration |
| Expected Result | The power pellet should last 6 seconds |
| Priority | 🟨 |

## 30. Test Ghost Vulnerability Period

| ID | T30 |
| --- | --- |
| Name | Test Ghost Vulnerability Period |
| Test Description | Confirm that the ghost vulnerability period is 6 seconds |
| Requirement(s) | The player eats a power pellet |
| Step(s) | 1. Start the game, 2. Play the game, 3. Eat a power pellet, 4. Observe ghost vulnerability period |
| Expected Result | The ghost vulnerability period should last 6 seconds |
| Priority | 🟧 |

## 31. Pac-Man Spawn Location 
| ID | T31 |
| --- | --- |
| Name | Pac-Man Spawn Location |
| Test Description | Confirm that Pac-Man spawns in the correct location at the start of the game |
| Requirement(s) | The game is started |
| Step(s) | 1. Launch DOSBox, 2. Execute PacMan file in DOSBox, 3. Observe Pac-Man spawn location |
| Expected Result | Pac-Man should spawn below the ghost home |
| Priority | 🟨 |