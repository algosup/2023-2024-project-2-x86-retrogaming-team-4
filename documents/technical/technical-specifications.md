# Technical specification | Team 4

---

<details>
<summary>Table of Contents</summary>

- [Technical specification | Team 4](#technical-specification--team-4)
  - [Introduction](#introduction)
    - [Overview](#overview)
    - [Assumptions](#assumptions)
  - [Technical Solution](#technical-solution)
    - [Graphics](#graphics)
    - [Fright time](#fright-time)
    - [Score management](#score-management)
    - [Ghost AI](#ghost-ai)
    - [Collision Handling](#collision-handling)
    - [Level Progression](#level-progression)
    - [Game Over](#game-over)
  - [Game run](#game-run)
    - [Game initialization](#game-initialization)
    - [Game loop](#game-loop)
      - [Input check](#input-check)
      - [Collision Check](#collision-check)
      - [Game update](#game-update)
      - [Rendering](#rendering)
      - [Sound effects](#sound-effects)
  - [Algorithm](#algorithm)
    - [Set the colors of the palette](#set-the-colors-of-the-palette)
    - [Sound generation](#sound-generation)
    - [Game loop code](#game-loop-code)
  - [File Architecture](#file-architecture)
    - [Constant](#constant)
    - [Sprites](#sprites)
    - [Collider](#collider)
    - [GameState](#gamestate)
    - [Keyboard](#keyboard)
    - [Sound](#sound)
  - [Test Plan](#test-plan)
  - [Release Plan](#release-plan)
  - [Further Considerations](#further-considerations)
    - [Third-party services and platform considerations](#third-party-services-and-platform-considerations)
    - [Risks](#risks)
  - [Glossary](#glossary)

</details>

---

## Introduction

### Overview

ALGOSUP's school commissioned us to create a Pac-Man game clone in assembly x86 using DOSBox[^1]. The software's primary objective is to completely fit all the original gameplay systems.

### Assumptions

We assumed that copyright was not an issue. This is a student project for non-commercial purposes, and it is generally allowed to use assets from old games to create it.

---

## Technical Solution

### Graphics

The different sprites will be drawn according to this spritesheet.

![sprite sheet](../pictures/spritesheet.png)

As shown above, each ghost has two separate sprites. We can create animations by alternating which sprite is displayed every 0.25 seconds. Pac-Man also has 2 different sprites, being the ones with the mouth half opened and fully opened. We can create the same animation by alternating each 0.25 second.
We can rotate these 2 sprites to make sure that Pac-Man can face all 4 directions.
As the ghosts are looking in the direction they are moving in, the adequate eye sprite will be drawn on top of the ghosts at their position.
When the ghost is frightened, it turns dark blue and keeps the same kind of animation as before. They start blinking in white 2 seconds before the end of the fright time.
When a ghost is eaten, only its eyes remain, which head back to the ghost house. Once arrives, the ghost goes back to his original.
Pac-Man has a death animation composed of 10 frames which lasts 1 second.

The maze layout is as follows

![maze](../pictures/Pac-Maze.png)

The maze is 224 wide by 248 height.
The rectangle in the middle of the maze is called the ghost house. This is where 3 out of the 4 ghosts start, and where they come back when they have been eaten.
The fruits appear on the row just below the ghost house, in the middle of the row.

### Fright time

Each time a big pellet is eaten, the game enters fright time. During this time, Pac-Man becomes invulnerable and ghosts can be eaten.
The duration is 6 seconds in the first level, and changes as the levels go along.

| Level | Duration of the ghosts frightening (in seconds) |
| --- | --- |
| 1            |6|
| 2            |5|
| 3            |4|
| 4            |3|
| 5            |2|
| 6            |5|
| 7 and 8      |2|
| 9            |1|
| 10           |5|
| 11           |2|
| 12 and 13    |1|
| 14           |3|
| 15 and 16    |1|
| 17           |0|
| 18           |1|
| 19 and after | 0|

The ghosts start blinking 2 seconds before the end of the fright time to indicate to the player that the game will soon be reversed to its normal state. If the fright time is 2 seconds or less, the ghosts blink from the start of the fright time.

Each time a ghost is eaten, the screen should freeze for 2 seconds and display the amount of points scored where the ghost has been eaten.

### Score management

Each small pellet eaten is worth 10 points. Each big one is worth 50 points.
A fruit, a cherry for us, appears just below the ghost house when 70 pellets have been eaten. It will stay there for 10 seconds. Another fruit can spawn when 170 pellets have been eaten.
The number of points ghosts can give you is as follows.

|Number of ghost eaten|Points scored|
|---|---|
|1|200|
|2|400|
|3|800|
|4|1600|

The cherry is worth 100 points. This means that in a level, the player can reach a maximum of 14800 points, if he eats the 4 ghosts during the 4 fright time available, and gets the two cherries that appear on the level.
A player can get a life for 10000 points reached.

### Ghost AI

All the ghosts have a scatter mode. In this mode, they stay in the corner they are assigned to, as described in [the functional specification](/documents/functional/functional-specifications.md)

Each ghost has a different behavior pattern.

- Blinky, the red one, is the most aggressive one. He is always chasing Pac-Man, wherever it goes. He starts outside of the ghost house, being the first one able to move freely in the maze. He always tries to reach the exact tile Pac-Man is on.
- Pinky, the pink ghost, has a more strategic approach. Instead of targeting the position of Pac-Man, it targets the direction of Pac-Man, moving in parallel compared to the player. it is the second one to go out of the ghost house. He aims for 4 tiles ahead of Pac-Man, leading him to always try to trap him rather than chase him like Blinky.
- Clyde, the orange one, has a more random movement. It's not always random. When Pac-Man is more than 8 tiles away, he directly targets Pac-Man, as Blinky does. However, when he is closer to Pac-Man like Blinky, it goes back into scatter mode. He is the third one, to go out of the ghost house.
- Inky, the blue one, has the most complex pattern. He is moving concerning the position of both Pac-Man and Blinky. He always tries to trap Pac-Man between him and Blinky's position. The farther Blinky is from Pac-Man, the more random he will move.

A ghost should always be in movement.
During fright time, all the ghosts try to run away from Pac-Man. They recover their normal behavior when they are no longer frightened.

### Collision Handling

We need to handle collisions. There are three types of collision: walls, ghosts, and score elements.

- Walls: When Pac-Man collides with walls, it stops in the frame it is in and doesn't move until a new input is provided. To check where Pac-Man and the ghosts can go, we will use a table composed of 0 and 1, with 0 for the tile where it is not possible to move on and 1 for where it is possible. The only special wall is the door of the ghost house. It is a one-way door, and only the ghost can go through it.
- When Pac-Man collides with a score element, such as pellets, he wins points according to the element encountered. The element is then cleared from the current level layout. It reappears when the level is finished.
- When Pac-Man collides with a ghost, there are 2 different outcomes. The first one is that Pac-Man loses a life. When so, both Pac-Man and the ghosts respawn at their starting position, and eaten pellets remain eaten until the end of the level. The second one is that Pac-Man eats the ghost, winning points and making the ghost reappear at the ghost house.

### Level Progression

When all the pellets of a level have been eaten, the player progresses to the next level. When a new level starts, Pac-Man and the ghosts are reset to their original position, and the levels are filled with pellets again.
When the player reaches a new level, the maze is reset and the difficulty increases. It increases by reducing the duration of the fright time and increasing the movement speed of the ghosts.
There are no "real" winning conditions in the original Pac-Man. When you collect all the pellets of a level, you would go to the next level, and so on. When reaching level 256, the game would bug due to some memory overflow, known as the map [256 glitch](https://pacman.fandom.com/wiki/Map_256_Glitch).

### Game Over

A Game Over occurs when the player loses all his life. Then, the Game Over animation of Pac-Man displays and the score is set as high score if it is higher than the previous one. The player just has to press a key to start a new game.
If the player closes the game, the current high score will be deleted and will not be saved for when the player launches the program.

## Game run

### Game initialization

The first thing that has to be done is to set up the graphic mode. In our case, the graphic mode used will be VGA mode, with a screen resolution of 640 by 480 pixels and 16 colors available, video mode 12h.
The high score will be set back to 0. The player starts with 3 lives and 0 points at level 1.
The placement of pellets, Pac-Man and ghosts as well are their starting directions are as follows.

![filled maze](../pictures/FilledPac-Maze.png)

There are 240 small pellets, as well as 4 big ones.
The player has to wait for the intro music to stop for him to be able to move.
The screen with the maze will be put in memory, allowing it to have to display it once, preventing further calculations

### Game loop

A game loop is executed at each frame. The game should be running at 24 FPS (frames per second)

#### Input check

At each game loop, the first step is to check if the player did an input and check what the input is. Only 5 inputs are recognized by the game, all 4 direction arrows and escape. The direction arrows are used to move in the maze, only if possible. It is possible to move in a direction only if there are no walls. Escape is used to quit the game at any time. When the game is closed, all progress is lost.

#### Collision Check

The goal of this step is to check if any element of the game collides between them. This will be done thanks to the logic described in the [collision handler](#collision-handling).

#### Game update

This is where we check if anything needs an update. First, we need to update the score. Then we need to check if the [fruit apparition condition](#score-management) is met.
We need to update the current direction of the ghosts to match their comportment. A ghost can do a full U-turn on itself. Remember that when frightened, ghosts try to run away from Pac-Man. They go back to their normal behavior after that.
We also need to check if we go, stay in or leave fright time.
Next, we need to check if we have to go to the next level, stay, or lose a life. If a life is lost, Pac-Man and the ghosts are set back at their initial position, but the pellets eaten remain eaten until the end of the level.
Lastly, we need to check if the [Game Over conditions](#game-over) are met and do accordingly.

#### Rendering

After updating their position in the code, we have to display the actual new position of ghosts and Pac-Man in the maze. We also need to change the score, display the fruit if needed or any animation depending on the conditions.
The sprites will be displayed line by line.

#### Sound effects

Here, we need to check if any sound effect needs to be played depending on the situation and output them.
Otherwise, the background music should be looping.

## Algorithm

### Set the colors of the palette

We are using the video mode 12h. This video mode can only display 16 different colors. However, it is possible to change the colors used.
The most efficient way is to create a macro function. We just have to indicate how many parameters your function needs, and then call the macro. An example of use is featured below.

```assembly

%macro setpalette 4 
        mov bx, %1
        mov dh, %2
        mov ch, %3
        mov cl, %4
        mov ax, 1010h
        int 10h
%endmacro

    Start:
        mov ax, 0A000h
        mov es, ax

        ;set video mode to 640x480 16 color 
        mov ax, 12h 
        int 10h

        setpalette 14h,0ffh,0ffh,0ffh

```

This the the relation between the index of the palette and the register attached to it.

```text
0  1  2  3  4  5  6 7  8  9  A  B  C  D  E  F     palette register
0  1  2  3  4  5 14 7 38 39 3A 3B 3C 3D 3E 3F     color register
```

The code featured above is setting the palette register 6 with the color ffffff, which is white.

### Sound generation

To generate some sound, we can use the code below

```assembly
    mov     al, 182
    out     43h, al

    mov     ax, 2153        ; countdown value is stored in ax. It is calculated by dividing 1193180 by the desired frequency with the number being the frequency at which the main system oscillator runs
    out     42h, al         
    mov     al, ah          
    out     42h, al               

    in      al, 61h         
                            ; to connect the speaker to timer 2
    or      al, 00000011b  
    out     61h, al         ; Send the new value
```

### Game loop code

This is a draft of what the main file would look like. This is the file where everything will be put together

```assembly
; IT'S ONLY A DRAFT
; ALL NAMES AND FILE NAMES ARE NOT FINAL

section .text

; INITIALISATION FUNCTION
start:
call initialisation ; This include variables, sprites, map processing
jmp gameloop

; GAME LOOP
gameloop:
call input; check if input and process it

call updatepositions; update positions

call collisions; chekc collision

call updategamestate; update game state (score, fright time, refer to the tech specs)

call rendering; update rendering

call sound; update sound
jmp gameloop
```

At each game loop, we have to wait to have 24 frames per second.

## File Architecture

There should be several files. Several files allow for a better organization of the code and better readability in the game loop.

```text
/project-root
│
├── src
│   ├── main.asm
│   ├── constant.asm
│   ├── sprites.asm
│   ├── collider.asm
│   ├── gamestate.asm
│   ├── keyboard.asm
│   └── sound.asm
```

### Constant

This file will contain every constant defined to help with the development.

### Sprites

This file will contain all the different functions used to draw sprites, but also to calculate their new positions.

### Collider

This file will contain the [collision handler](#collision-handling) and check that the movements done by Pac-Man and ghosts are possible.
To handle collisions, we will check if the sprites overlap. This means that if the position of a sprite on any axis is the same, then the check will be done and follow any scenarios given above. The collision check is done before the rendering, to ensure that any impossible locations are displayed.

### GameState

This file will contain every function necessary to update the game status. This includes ghost target, score, fruits, fright time, losing a life, game over and finishing a level.

### Keyboard

This file will be used to handle key input by the player.

### Sound

This file will manage all the sound systems.

## Test Plan

For the test plan, please refer to [this document](../QA/test-plan.md).

## Release Plan

At first, the game will only be available as a .com[^2] file in the [repository](https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-4). To run this file, a DOS environment is required, such as DOSBox.

In a second time, the user would be able to download the latest release files and follow the installation steps which will be described in the README. The user will launch the compiled program, which is executed on the same environment, thanks to the DOSBox emulator.

---

## Further Considerations

### Third-party services and platform considerations

- Our code base will be hosted on [GitHub](https://github.com) on [this repository](https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-4/). In case of an outage of the website or its closure, the source code and compiled files of the releases will not be accessible and downloadable for the end-user.
- DOSBox is an external platform downloadable via [DOSBox's official website](https://www.dosbox.com/). In case of an outage of the website or its closure, the executable file allowing the program to run on different platforms the assembly files will not be :
  - Use an alternative such as [DOSBox-X](https://dosbox-x.com/) or [DOSBox SVN Daum](http://ykhwong.x-y.net/). However, these pieces of software may require some code adaptations.
  - Download it from other sources. As DOSBox is open-source, its source code can be downloaded from [SourceForge](https://sourceforge.net/projects/dosbox/).
- NASM (Netwide Assembler) is the assembly language compiler we are using to turn our assembly files into machine code files. It is available for download from the [NASM 'project's official website](https://nasm.us/). If this site is unavailable or the project is terminated, the executable should be downloaded from another source:
  - [NASM GitHub official repository](https://github.com/netwide-assembler/nasm)
  - Via various package managers and command lines:
    - apt: `sudo apt-get -y install nasm`
    - yum: `sudo dnf -y install nasm`
    - brew: `brew install nasm`

### Risks

| Risk |Impact | Mitigation |
|---| --- | --- |
|   Scope creep    | We might try to make the project too big which could lead to the project running out of time.| We must plan our work by doing a breakdown of the different tasks in sub-tasks and estimate a specific time which will be dedicated to this sub-task realization. |
| Technical issues | Assembly, which is the language used during this project, is part of a niche for development as only a few software developers are still using this low-level language. <br>This explains why only a few people is our team already know how to code in depth with it. For this reason, many bugs or crashes could happen during the project realisation, mainly caused by memory leaks. | These unexpected behaviour must be found and patched as reliability and user friendliness are the key-points of a non-necessary software such as a video-game to keep users interested. <br>However, patching behaviour issues might be challenging as we may encounter errors which have not been previously documented. |
|Delays| Our project could be delayed because of some code-related bugs or issues, obliging us to spend more time than planned on a feature. | We will spend addtional time on the project as a consequence of potential delays|
|Colors| As of today, the palette colors used in the video mode chosen does not have the original colours.|We can either use different colors or modify the palette to have the required colors|

---

## Glossary

[^1]: DOSBox is an emulator program that emulates an IBM PC-compatible computer running in a DOS operating system.

[^2]: A .com file is an assembly program already compiled. This file is meant to be used in DOS or MS-DOS environment.
