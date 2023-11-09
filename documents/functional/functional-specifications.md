# Functional Specifications | Team 4

---
|                 |                  |
| --------------- | ---------------- |
| Document name   | Functional specifications  |
| Document owner  | Antoine PREVOST  |
| Creation date   | November 6, 2023 |
| Lastest version | November 9, 2023 |

<details>
<summary>Table of Contents</summary>

- [Functional Specifications | Team 4](#functional-specifications--team-4)
  - [Project Overview](#project-overview)
  - [Stakeholders](#stakeholders)
  - [Project scope](#project-scope)
    - [Resource: DOSBox Emulator](#resource-dosbox-emulator)
  - [Deliverables](#deliverables)
  - [Personas and use cases](#personas-and-use-cases)
    - [Target Audience](#target-audience)
    - [1. Retro Gaming Enthusiast - Alex 🕹️](#1-retro-gaming-enthusiast---alex-️)
    - [2. Novice Player - Emily 🆕](#2-novice-player---emily-)
    - [3. Nostalgic 90s Gamer - Mike 💾](#3-nostalgic-90s-gamer---mike-)
    - [4. Tandy 1000 Enthusiast - Jason 📟](#4-tandy-1000-enthusiast---jason-)
  - [Evaluation criteria](#evaluation-criteria)
    - [Gameplay Requirements](#gameplay-requirements)
    - [AI and Enemy Behavior Requirements](#ai-and-enemy-behavior-requirements)
    - [Controls and Responsiveness Requirements](#controls-and-responsiveness-requirements)
    - [Graphics Requirements](#graphics-requirements)
    - [User Experience Requirements](#user-experience-requirements)
    - [Bug-Free Gameplay Requirements](#bug-free-gameplay-requirements)
  - [Solution overview](#solution-overview)
    - [System architecture](#system-architecture)
    - [User interface](#user-interface)
    - [Game mechanics overview](#game-mechanics-overview)
      - [Graphics](#graphics)
        - [Colors](#colors)
        - [Game window](#game-window)
        - [Sprites](#sprites)
    - [Gameplay](#gameplay)
      - [Player Controls](#player-controls)
      - [Movement](#movement)
      - [Interactions](#interactions)
      - [Game Rules](#game-rules)
      - [Winning and Losing Conditions](#winning-and-losing-conditions)
      - [Game Over Screen](#game-over-screen)
  - [Timeline](#timeline)
  - [Risks and assumptions](#risks-and-assumptions)
    - [Copyright and license](#copyright-and-license)
  - [Glossary](#glossary)

</details>

---

## Project Overview

ALGOSUP's school commissioned us to create a Pac-Man game clone in assembly x86 using DOSBox[^1]. The software's primary objective is to completely fit all the original gameplay systems.

## Stakeholders

| Stakeholder      | Role                     | Description                        | 🔗                                            |
| ---------------- | ------------------------ | ---------------------------------- | ---------------------------------------------- |
| ALGOSUP          | Client                   | Client of this project.            | [Website](https://algosup.com/)                |
| Léo CHARTIER     | Project Manager          | In charge of project management.   | [Github](https://github.com/leo-chartier)      |
| Antoine PREVOST  | Program Manager          | In charge of program management.   | [Github](https://www.github.com/TechXplorerFR) |
| Malo ARCHIMBAUD  | Tech Lead                | In charge of technical aspects.    | [Github](https://github.com/Malo-Archimbaud)   |
| Benoît DE KEYN   | Junior Software Engineer | In charge of software development. | [Github](https://github.com/benoitdekeyn-algosup)              |
| Maxime THIZEAU   | Junior Software Engineer | In charge of software development. | [Github](https://github.com/MaximeTAlgosup)    |
| Maxime CARON     | Quality Assurance        | In charge of project quality.      | [Github](https://github.com/MaximeAlgosup)     |
| Thomas PLANCHARD | Quality Assurance        | In charge of project quality.      | [Github](https://github.com/thomas-planchard)  |

## Project scope

The project aims to develop a faithful recreation of the classic Pac-Man game using Assembly language, within an emulated 90s computer environment. The primary objective is to deliver an experience that captures the essence of the original Pac-Man gameplay while accommodating both regular players and newcomers.

### Resource: DOSBox Emulator

To achieve the emulation of a 90s computer environment, the project will leverage the use of the DOSBox emulator. DOSBox will serve as the platform for executing and testing the Pac-Man clone, ensuring compatibility with the simulated hardware and software of the era.

## Deliverables

Here is a table of milestones and deliverables dates:
| Date    | Milestone / Deliverable       |
| ------------------ |-------------------- |
| November 13, 2023, 1.30pm|  Functional specification    |
| November 27, 2023, 5pm    | Technical specification  |
| December 8, 2023, 5pm   | Test plan  |
| December 11, 2023, 5pm   | Working prototype  |
| December 21, 2023, 5pm   | Final product  |

## Personas and use cases

### Target Audience

The game is designed to cater to a wide range of players, from those well-acquainted with the original Pac-Man to individuals who may be discovering the game for the first time.
The following personas are based on the target audience we assume to have.

### 1. Retro Gaming Enthusiast - Alex 🕹️

- Goals:
  - Alex's primary goal is to experience a faithful recreation of the original Pac-Man game. He is looking for a challenge that closely mirrors the difficulty level of the original arcade version.
  - He wants to relive the nostalgia of playing Pac-Man and appreciate the game's classic gameplay mechanics.

- Challenges:
  - Ensuring that the game's difficulty level closely matches that of the original Pac-Man can be a challenge, as it requires fine-tuning various gameplay elements.
  - Meeting the expectations of a dedicated retro gaming enthusiast like Alex, who may have a deep understanding and appreciation for the nuances of the original game.

### 2. Novice Player - Emily 🆕

- Goals:
  - Emily is interested in discovering and learning how to play Pac-Man for the first time. She wants an accessible experience that doesn't overwhelm her with complexity.
  - Her goal is to have fun while playing and potentially develop an interest in classic arcade games.

- Challenges:
  - Designing the game to be accessible and user-friendly for a novice player like Emily, while still maintaining the essence and challenge of Pac-Man.
  - Balancing the game's difficulty so that it provides a satisfying challenge without becoming frustrating for someone new to the game.

### 3. Nostalgic 90s Gamer - Mike 💾

- Goals:
  - Mike's main goal is to recapture the magic of the 90s arcade experience on his modern machine. He seeks an authentic recreation of Pac-Man.

- Challenges:
  - Ensuring that the Pac-Man clone provides a seamless and enjoyable experience on Mike's new machine, taking into account any hardware or software compatibility issues.
  - Striking the right balance between preserving the retro charm of the original game and incorporating modern elements to enhance the overall gaming experience for Mike.

### 4. Tandy 1000 Enthusiast - Jason 📟

- Goals:
  - Jason's primary goal is to experience Pac-Man on his Tandy 1000, as it's a system he holds dear to his heart.
  - He seeks a version of Pac-Man that is optimized for the Tandy 1000's[^2] hardware and provides an authentic 80s computing experience.

- Challenges:
  - Ensuring that the Pac-Man clone is compatible with the Tandy 1000's specific hardware configurations and limitations.
  - Fine-tuning the game's performance to run smoothly on the Tandy 1000, taking into account any potential resource constraints.

## Evaluation criteria

To assess the performance and quality of the project, a set of evaluation criteria has been established. These criteria serve as benchmarks against which the project's functionality, design, and overall execution will be measured. The evaluation process aims to ensure that the final product meets the specified objectives. Below are the key areas of focus that will be considered during the evaluation.

### Gameplay Requirements

- **Movement and Responsiveness:** The character's movement speed must be precisely 60 pixels per second. Player inputs for movement must result in immediate and responsive character actions.

- **Winning and Losing Conditions:** Winning the game should be achieved by consuming all the dots within a level. Losing conditions must be triggered when "Pac-Man" either exhausts all lives or is captured by an enemy.

- **Level Progression:** The game must feature progressively challenging levels. Initial levels should present uncomplicated mazes with fewer enemies, while later levels should introduce more intricate mazes and faster enemies.

### AI and Enemy Behavior Requirements

- **Enemies Intelligence:** Enemies should exhibit intelligent behavior, using pathfinding algorithms to pursue "Pac-Man" logically. Their movements should dynamically respond to "Pac-Man's" position.

- **Fairness and Challenge:** Strive to maintain a balanced and challenging gameplay experience. Enemies should be swift and pose a challenge without causing undue frustration for the player.

### Controls and Responsiveness Requirements

- **Control Response Time:** The game should acknowledge player inputs with minimal delay. Specifically, key presses must be recognized within 50 milliseconds of being executed.

### Graphics Requirements

- **Visual Quality:** Visual elements, including character sprites, animations, and maze designs, should be visually appealing and run smoothly. There should be no graphical glitches during gameplay.

### User Experience Requirements

- **Menu and Transitions:** Menu transitions and animations must provide a seamless user experience. Transitions between menus and screens should not exceed 200 milliseconds to ensure a fluid feel.

- **Replay Value:** Encourage replayability through features such as high-score tracking and the inclusion of hidden bonuses within mazes, motivating players to revisit levels.

### Bug-Free Gameplay Requirements

- **Collision Detection:** The game should undergo rigorous testing to ensure it is entirely free from gameplay bugs. Specifically, collisions between "Pac-Man" and enemies must be detected accurately without any hitbox discrepancies.

## Solution overview

### System architecture

As requested by ALGOSUP, we are going to use DOSBox, an emulator for Intel 80386 family CPUs which is cross-platform and does not require any DOS distribution or an x86 architecture CPU.
Our game will be based on a 16-bit address bus, limiting addressable RAM to 65,536 bytes.

### User interface

### Game mechanics overview

As we need to respect the original gameplay rules, we have to be focused on many aspects during development:

- **Graphics**: This includes sprites for both pac-man and ghosts, as well as map elements such as walls, pallets, and bonus fruits
- **Map creation and gestion**: This includes creating a map, managing pellets, fruit cycles, and other hazard on the map
- **Gameplay**: This includes moving, life system, score system and changes between levels
- **Moving**: This includes both pac-man and ghosts deplacements and collision
- **Sound**: This includes music and sound effects
- **Score**: This includes score storing and keeping high scores

#### Graphics

##### Colors

As Pac-Man is an 8-bit color-like game, we must adopt a similar style. The original Pac-Man game uses 16 colors, which means the colors could be coded on only 4 bits. However, the colors would be inaccurate as some red, green, and blue components are not always multiples of 16, leading us to use 8 bits to code the color space of our Pac-Man clone.

Here is the color palette we are going to use:

|Swatch|Color|24-bit RGB|Uses|
| --- | --- | --- | --- |
|![black](https://readme-swatches.vercel.app/000000)|Black|0, 0, 0|Background|
|![red](https://readme-swatches.vercel.app/fc0000)|Red|252, 0, 0|Blinky, cherry, strawberry, apple, Galaxian ship|
|![brown](https://readme-swatches.vercel.app/d89055)|Brown|216, 144, 85|Orange top, cherry stream|
|![pink](https://readme-swatches.vercel.app/fcb4ff)|Pink|252, 180, 255|Pinky, ghost house door|
|![black](https://readme-swatches.vercel.app/000000)|Black|0, 0, 0|Background|
|![cyan](https://readme-swatches.vercel.app/00fcff)|Cyan|0, 252, 255|Inky, player text|
|![blue](https://readme-swatches.vercel.app/48b4ff)|Blue|72, 180, 255|Key top, bell bottom|
|![orange](https://readme-swatches.vercel.app/fcb455)|Orange|252, 180, 85|Clyde, orange|
|![black](https://readme-swatches.vercel.app/000000)|Black|0, 0, 0|Background|
|![yellow](https://readme-swatches.vercel.app/fcfc00)|Yellow|252, 252, 0|Pac-man, ready!, bell, Galaxian ship|
|![black](https://readme-swatches.vercel.app/000000)|Black|0, 0, 0|Background|
|![indigo](https://readme-swatches.vercel.app/2424ff)|Indigo|36, 36, 255|Maze walls, flashings ghosts, ghost pupils, Galaxian ship|
|![green](https://readme-swatches.vercel.app/00fc00)|Green|0, 252, 0|Melon, strawberry top, orange leaf|
|![teal](https://readme-swatches.vercel.app/48b4aa)|Teal|72, 180, 170|Melon wrinkles and stem|
|![salmon](https://readme-swatches.vercel.app/fcb4aa)|Salmon|252, 180, 170|Dots, ghost body, ghost face when flashing|
|![white](https://readme-swatches.vercel.app/fcfcff)|White|252, 252, 255|Flashing ghosts, scores, text, ghost eyes, fruit highlights|

To convert those 24-bit encoded colors into 8-bit colors, our image has to go through a process called color quantization[^3]. The simplest form for this process is to assign 3 bits to red, 3 bits to green, and only 2 bits to blue as the human eye is less sensitive to this color. This creates a 3-3-2 8-bit color image, following the following table structure:

``` txt
Bit:   7  6  5  4  3  2  1  0
Data:  R  R  R  G  G  G  B  B
```

##### Game window

<!-- A redécrire (similar) -->
The game will take place in a maze similar to the example displayed below. Of course, the maze shape, 

![pac-maze](../pictures/Pac-Maze.png)

##### Sprites

Here are the different sprites that will be used to create the game

|Name|Dimensions|Pictures|
| --- | --- | --- |
|Pac-Man|16x8|![Pac-Man](../pictures/Pac-Man.png)|
|Pellets|8x8|![Pellets](../pictures/Pellets.png)|
|Ghosts|16x8|![Ghosts](../pictures/Ghosts.png)|
|Scared Ghosts|16x8|![ScaredGhosts](../pictures/ScaredGhosts.png)|
|Eyes|5x5|![Eyes](../pictures/Eyes.png)|
|Fruits|8x8|![Fruits](../pictures/Fruits.png)|

Pac-Man will be able to face 4 directions, up, left, down, and right, and open his mouth.
Ghosts will be able to see in those 4 directions.

At the start of each level, the map will be similar to this

![FilledMaze](../pictures/FilledPac-Maze.png)

Let's provide more concrete details and examples for the gameplay mechanics:

---

### Gameplay

#### Player Controls

- The player will control Pac-Man using the keyboard arrow keys:
  - Up Arrow: Move Pac-Man upward.
  - Down Arrow: Move Pac-Man downward.
  - Left Arrow: Move Pac-Man to the left.
  - Right Arrow: Move Pac-Man to the right.
- The player can also exit the game:
  - Escape: Quit the game and close the DOSBox emulator

As a bonus which will be added if there is still time, we plan to add a main menu which will be displayed when starting the game and losing a game. It would contain the high scores, the different themes of the game, a 2-player game mode, and another mode to control ghosts.

Here is the table of the different controls across the various potential features:

---

- **Startup/Lost game/Main menu**:
  - Up Arrow: Select the upward option.
    - When on the top option, pressing this key does not warp to the bottom one, instead does nothing.
  - Down Arrow: Select the downward option.
    - When on the bottom option, pressing this key does not warp to the bottom, instead does nothing.
  - Enter key/Space bar: Choose this option and enter the sub-menu associated with it.

---

- **High scores sub-menu**:
  - Enter key/Space bar: Go back to the main menu.

---

- **Themes sub-menu**:
  - Arrow left: Select the sub-option situated on the left.
    - When on the leftmost option, pressing this key does not warp to the rightmost sub-option of this option or the previous option's rightmost sub-option, instead does nothing.
  - Arrow right: Select the sub-option situated on the right.
    - When on the rightmost option, pressing this key does not warp to the leftmost sub-option of this option or the previous option's leftmost sub-option, instead does nothing.
  - Arrow down: Select the first sub-option of the lower option.
    - When on the bottom option, pressing this key does not warp to the top option, instead does nothing.
  - Arrow up: Select the first sub-option of the upper option.
    - When on the top option, pressing this key does not warp to the bottom option, instead does nothing.
  - Enter key/ Space bar: Choose and apply the sub-option of an option.
    - When selecting a sub-option of an option, it unselects the previously selected option.

---

- **2-players game mode**:
  - First player moves:
    - Up Arrow: Move the Pac-Man character without a hair bow upward.
    - Down Arrow: Move the Pac-Man character Pac-Man without a hair bow downward.
    - Left Arrow: Move the Pac-Man character Pac-Man without a hair bow to the left.
    - Right Arrow: Move the Pac-Man character Pac-Man without a hair bow to the right.
  - Second player moves:
    - Z: Move the Pac-Man character without a hair bow upward.
    - S: Move the Pac-Man character Pac-Man without a hair bow downward.
    - Q: Move the Pac-Man character Pac-Man without a hair bow to the left.
    - D: Move the Pac-Man character Pac-Man without a hair bow to the right.

---

- **Control ghosts**:
  
---

#### Movement

Pac-Man moves through the maze at a rate of one cell per frame. Each frame is rendered at 60 frames per second, ensuring smooth movement.

#### Interactions

- **Eating Dots:**
  - Small dots (pellets) are strategically placed throughout the maze. When Pac-Man comes into contact with a dot, it is immediately consumed, and the player's score increases by 10 points.
- **Power Pellets:**
  - There are four power pellets located at the corners of the maze. When Pac-Man consumes a power pellet, it gains the ability to eat ghosts for a limited duration of 10 seconds.
- **Ghosts:**
  - Blinky, Pinky, Inky, and Clyde are the four ghosts that roam the maze. Each ghost has a unique movement pattern:
    - Blinky: Directly targets Pac-Man.
    - Pinky: Tries to position itself in front of Pac-Man's path.
    - Inky: Combines elements of Blinky and Pinky's behavior.
    - Clyde: Switches between random movement and targeting Pac-Man.
  - If Pac-Man collides with a ghost while not under the effects of a power pellet, Pac-Man loses a life.
- **Fruit (Optional):**
  - At certain intervals, a fruit bonus may appear in the maze. When Pac-Man collects the fruit, additional points are awarded.

#### Game Rules

- **Scoring:**
  - Small dots: 10 points each.
    - Power Pellets: 50 points each.
    - Eating a ghost (while under the effects of a power pellet): 200, 400, 800, 1600 points (depending on consecutive ghost eats).
    - Fruit (if implemented): Varies based on the type of fruit.
  - **Level Progression:**
    - Each level starts with a new maze layout. The difficulty increases as players progress through levels, with faster ghosts and more complex mazes.
  - **Extra Lives:**
    - Pac-Man starts with three lives. An extra life is awarded upon reaching 10,000 points.

#### Winning and Losing Conditions

- **Winning:**
  - The player must successfully navigate the maze, consuming all of the small dots (pellets) while strategically using power pellets to temporarily gain the ability to eat ghosts. This process continues through multiple levels, with the ultimate goal of achieving the highest possible score and clearing all the levels.
- **Losing:**
  - Pac-Man loses a life if it collides with a ghost without the effects of a power pellet. The game ends if all lives are depleted.

#### Game Over Screen

When the game ends, the player is presented with a game over screen displaying their final score, along with options to restart or quit.

## Timeline

<!-- Léo put a timeline of the project here-->

## Risks and assumptions

| Risk | Impact | Mitigation |
| :----: | :------ | :------------- |
| Scope creep   | We might try to make the project too big which could lead to the project running out of time. |  We must plan our work by doing a breakdown of the different tasks in sub-tasks and estimate a specific time which will be dedicated to this sub-task realisation.|
| Technical issues   | Assembly, which is the language used during this project, is part of a niche for development as only a few software developers are still using this low-level language. <br>This explains why only a few people is our team already know how to code in depth with it. For this reason, many bugs or crashes could happen during the project realisation, mainly caused by memory leaks.| These unexpected behaviour must be found and patched as reliability and user friendliness are the key-points of a non-necessary software such as a video-game to keep users interested. <br>However, patching behaviour issues might be challenging as we may encounter errors which have not been previously documented.|

### Copyright and license

As Pac-Man is still under license, we had to take into consideration the fact that it could be an issue. After asking the client, he told us this should not be an issue for several reasons. The first one is that as being an educational purpose project which will not be sold, it is allowed to use the sprites of the original game. Also, the owner of the copyright, Bandai Namco Entertainment Inc., is very unlikely to find this project, and if they sue us, it would be bad publicity and could discredit their image.

## Glossary

[^1]: DOSBox is an emulator program that emulates an IBM PC-compatible computer running a DOS operating system.

[^2]: The Tandy 1000 was the first in a line of IBM PC-compatible home computer systems produced by the Tandy. The Tandy 1000 is powered by an x86 processor operating on a 16-bit architecture. This means that it utilizes the Intel 8088, which is a 16-bit microprocessor compatible with the x86 instruction set.  

[^3]: The process of creating a color map for a less color-dense image from a more dense image.
