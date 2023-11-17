# Technical specification | Team 4

---
|||
|---|---|
|Document name| Technical specification|
|Document owner| Malo Archimbaud|
|Creation date| 13/11/23|
|Last modified|16/11/23|

<details>
<summary>Table of Contents</summary>

- [Technical specification | Team 4](#technical-specification--team-4)
  - [Introduction](#introduction)
    - [Overview](#overview)
    - [Assumptions](#assumptions)
  - [Solutions](#solutions)
    - [Proposed Solution](#proposed-solution)
      - [Winning and losing solutions](#winning-and-losing-solutions)
      - [Moving](#moving)
    - [Test Plan](#test-plan)
    - [Release Plan](#release-plan)
  - [Further Considerations](#further-considerations)
    - [Third-party services and platforms considerations](#third-party-services-and-platforms-considerations)
    - [Risks](#risks)
  - [Glossary](#glossary)

</details>

---

## Introduction

### Overview

ALGOSUP's school commissioned us to create a Pac-Man game clone in assembly x86 using DOSBox[^1]. The software's primary objective is to completely fit all the original gameplay systems.

### Assumptions

We assumed that copyright is not an issue. This is a student project for non comercial purpose, and the it is generally allowed to use assets from old games to create it. Also, an international billion dolar company has surely something else to do than search for our repo, or answer our mails on this matter.

---

## Solutions

### Proposed Solution

#### Winning and losing solutions

There are no "real" winning condition in the original Pac-Man. When you collect all the pellets of a level, you would go to the next level and so on. When reaching level 256, the game would bug due to some memory overflow, known as the [map 256 glitch](https://pacman.fandom.com/wiki/Map_256_Glitch).
The losing codition is when you run out of lives. When this happens, if the score is better than the previous high score, then this score will be stored in place of the current one.
![Losing Conditions](../pictures/LosingCon.png)

#### Moving

When a key pressed, these instructions will be applied
![Pressed Key](../pictures/PressedKey.png)
Then, the game will check what is on the tile
![Move on a tile](../pictures/MoveOnTile.png)

### Test Plan

For the test plan, please refer to [this document](../QA/test-plan.md)

### Release Plan

At first, the game will only be available as a .com[^2] file in the [repository](https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-4). In order to run this file, a DOS environment is required, such as DOSBox. 

In a second time, the user would be able to download the latest release files and follow the installation steps which will be described in the README. The user will launch the compiled program, which is executed on the same platform, thanks to the DOSBox emulator.

---

## Further Considerations

### Third-party services and platforms considerations

### Risks

---

## Glossary

[^1]: DOSBox is an emulator program that emulates an IBM PC-compatible computer running a DOS operating system.

[^2]: A .com file is an assembly program already compiled. This file is meant to be used a DOS or MS-DOS environment.
