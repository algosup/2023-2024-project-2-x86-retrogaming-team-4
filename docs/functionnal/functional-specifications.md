# Functional Specifications  Team 4

---
Last updated on: November, 6 2023

<details>
<summary>Table of Contents</summary>

- [Functional Specifications  Team 4](#functional-specifications--team-4)
  - [Project Overview](#project-overview)
  - [Stakeholders](#stakeholders)
  - [Project scope](#project-scope)
  - [Personas and use cases](#personas-and-use-cases)
    - [1. Retro Gaming Enthusiast - Alex](#1-retro-gaming-enthusiast---alex)
    - [2. Novice Player - Emily](#2-novice-player---emily)
    - [3. Nostalgic 90s Gamer - Mike](#3-nostalgic-90s-gamer---mike)
    - [4. Tandy 1000 Enthusiast - Jason](#4-tandy-1000-enthusiast---jason)
  - [Risks and assumptions](#risks-and-assumptions)
  - [Solution overview](#solution-overview)
    - [System architecture](#system-architecture)
    - [User interface](#user-interface)
    - [Game mechanics](#game-mechanics)
      - [Graphisms](#graphisms)
  - [Glossary](#glossary)

</details>

---

## Project Overview

ALGOSUP's school commissioned us to create a Pac-Man game clone in Assembly code. The software's primary objective is to completely fit all the original gameplay systems.


## Stakeholders

| Stakeholder      | Role                     | Description                        | 🔗                                             |
| ---------------- | ------------------------ | ---------------------------------- | ---------------------------------------------- |
| ALGOSUP          | Client                   | Client of this project.            | [Website](https://algosup.com/)                |
| Léo CHARTIER     | Project Manager          | In charge of project management.   | [Github](https://github.com/leo-chartier)      |
| Antoine PREVOST  | Program Manager          | In charge of program management.   | [Github](https://www.github.com/TechXplorerFR) |
| Malo ARCHIMBAUD  | Tech Lead                | In charge of technical aspects.    | [Github](https://github.com/Malo-Archimbaud)   |
| Benoît DE KEYN   | Junior Software Engineer | In charge of software development. | [Github](https://www.github.com/)              |
| Maxime THIZEAU   | Junior Software Engineer | In charge of software development. | [Github](https://www.github.com/)              |
| Maxime CARON     | Quality Assurance        | In charge of project quality.      | [Github](https://www.github.com/)              |
| Thomas PLANCHARD | Quality Assurance        | In charge of project quality.      | [Github](https://github.com/thomas-planchard)  |

## Project scope

This software's primary objective is to create a clone of Pac-Man following all the guidelines of the original retro game using [^1]DOSBox.


Here is a table of milestones and deliverables dates:
| Date    | Milestone / Deliverable       |
| ------------------ |------------------------------------------------------------------------------------- |
| November 13, 2023, 1.30pm|  Functional specification    |
| November 27, 2023, 5pm    | Technical specification  |
| December 8, 2023, 5pm   | Test plan  |
| December 11, 2023, 5pm   | Working prototype  |
| December 21, 2023, 5pm   | Final product  |

## Personas and use cases


### 1. Retro Gaming Enthusiast - Alex

- Goals:
  - Alex's primary goal is to experience a faithful recreation of the original Pac-Man game. He is looking for a challenge that closely mirrors the difficulty level of the original arcade version.
  - He want to relive the nostalgia of playing Pac-Man and appreciate the game's classic gameplay mechanics.

- Challenges:
  - Ensuring that the game's difficulty level closely matches that of the original Pac-Man can be a challenge, as it requires fine-tuning various gameplay elements.
  - Meeting the expectations of a dedicated retro gaming enthusiast like Alex, who may have a deep understanding and appreciation for the nuances of the original game.

### 2. Novice Player - Emily

- Goals:
  - Emily is interested in discovering and learning how to play Pac-Man for the first time. She wants an accessible experience that doesn't overwhelm her with complexity.
  - Her goal is to have fun while playing and potentially develop an interest in classic arcade games.

- Challenges:
  - Designing the game to be accessible and user-friendly for a novice player like Emily, while still maintaining the core essence and challenge of Pac-Man.
  - Balancing the game's difficulty so that it provides a satisfying challenge without becoming frustrating for someone new to the game.


### 3. Nostalgic 90s Gamer - Mike


- Goals:
  - Mike's main goal is to recapture the magic of the 90s arcade experience on his modern machine. He seeks an authentic recreation of Pac-Man. 

- Challenges:
  - Ensuring that the Pac-Man clone provides a seamless and enjoyable experience on Mike's new machine, taking into account any hardware or software compatibility issues.
  - Striking the right balance between preserving the retro charm of the original game and incorporating modern elements to enhance the overall gaming experience for Mike.



### 4. Tandy 1000 Enthusiast - Jason


- Goals:
  - Jason's primary goal is to experience Pac-Man on his Tandy 1000, as it's a system he holds dear to his heart.
  - He seeks a version of Pac-Man that is optimized for the [^2]Tandy 1000's hardware and provides an authentic 80s computing experience.

- Challenges:
  - Ensuring that the Pac-Man clone is compatible with the Tandy 1000's specific hardware configurations and limitations.
  - Fine-tuning the game's performance to run smoothly on the Tandy 1000, taking into account any potential resource constraints.


## Risks and assumptions

## Solution overview

### System architecture

As requested by ALGOSUP, we are going to use [^1]DOSBox, an emulator for Intel 80386 family CPUs which is cross-platform and does not require any DOS distribution or an x86 architecture CPU.
Our game will be based on a 16 bits adress bus, limiting adressable RAM to 65,536 bytes.

### User interface

### Game mechanics

As we need to respect the original gameplay rules, we have to be focused on many aspects during development:

- Graphisms: This includes sprites for both pac-man and ghosts, as well as map elements such as walls, pallets and bonus fruits
- Map creation and gestion: This includes creating a map, managing pellets, fruit cycles and other hazard on the map
- Gameplay: This includes moving, life system, score system and changes between levels
- Moving: This includes both pac-man and ghosts deplacements and collision
- Sound: This includes musics and sound effects
- Score: This includes score storing and keeping high scores

#### Graphisms

The game will take place on a [maze](docs\pictures\maze.png) of a size of 240 by 320 pixels

## Glossary

| Term | Definition |
|-----|-----|
| [^1]:| DOSBox is an emulator program that emulates an IBM PC compatible computer running a DOS operating system. |
| [^2]:| The Tandy 1000 was the first in a line of IBM PC compatible home computer systems produced by the Tandy. The Tandy 1000 is powered by an x86 processor operating on a 16-bit architecture. This means that it utilizes the Intel 8088, which is a 16-bit microprocessor compatible with the x86 instruction set.  |
