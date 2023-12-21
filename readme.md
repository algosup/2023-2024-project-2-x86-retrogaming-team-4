# <div align="center">2023-2024 Project-2 x86-retrogaming Team-4</div>

# <div align="center">Pac-Man Clone</div>

<details>
<summary>Table of Contents</summary>

- [2023-2024 Project-2 x86-retrogaming Team-4](#2023-2024-project-2-x86-retrogaming-team-4)
- [Pac-Man Clone](#pac-man-clone)
  - [Who are we?](#who-are-we)
  - [Overview](#overview)
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Configuration](#configuration)
  
</details>

## Who are we?

| Name             | Role                      | Picture                                                                                 | 🔗                                                                  |
| ---------------- | ------------------------- | --------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| Léo CHARTIER     | Project Manager           | ![Léo's profile picture](https://avatars.githubusercontent.com/u/91249751?size=200)     | [Léo's Github profile](https://github.com/leo-chartier)            | t |
| Antoine PREVOST  | Program Manager           | ![Antoine's profile picture](https://avatars.githubusercontent.com/u/81081224?size=200) | [Antoine's Github profile](https://github.com/leo-chartier)        |
| Malo ARCHIMBAUD  | Tech Lead                 | ![Malo's profile picture](https://avatars.githubusercontent.com/u/97161471?size=200)    | [Malo's Github profile](https://github.com/Malo-Archimbaud)        |
| Maxime THIZEAU   | Junior Software Developer | ![Maxime's profile picture](https://avatars.githubusercontent.com/u/145995586?size=200) | [Maxime's Github profile](https://github.com/MaximeTAlgosup)       |
| Benoît DE KEYN   | Junior Software Developer | ![Benoît's profile picture](https://avatars.githubusercontent.com/u/146000855?size=200) | [Benoît's Github profile](https://github.com/benoitdekeyn-algosup) |
| Maxime CARON     | Quality Assurance         | ![Maxime's profile picture](https://avatars.githubusercontent.com/u/145995231?size=200) | [Maxime's Github profile](https://github.com/MaximeAlgosup)        |
| Thomas PLANCHARD | Quality Assurance         | ![Thomas's profile picture](https://avatars.githubusercontent.com/u/91249646?size=200)  | [Thomas's Github profile](https://github.com/thomas-planchard)     |

## Overview

This project is about recreating a faithful clone of Pac-Man in Assembly X86 using DOSBox and NASM.

## Requirements

To run this project, you need to meet the following requirements:

- Run one of the following operating systems:
  - Windows 7/Windows 8/Windows 8.1/Windows 10/Windows 11
  - Mac OS X
  - Linux
  - FreeBSD
  - Any operating system based on DOS
- Have an installation of [DOSBox](https://www.dosbox.com/download.php?main=1)
- Have an installation of [NASM](https://nasm.us/)

## Installation

1. Clone the repository using [Github Desktop](https://desktop.github.com/) or the following command in the command line: `git clone https://github.com/algosup/2023-2024-project-2-x86-retrogaming-team-4.git`
1. Install [NASM](https://www.nasm.us/pub/nasm/releasebuilds/2.16.01/dos/nasm-2.16.01-dos-upx.zip) by unziping it and place this last in a folder named `nasm` in the clone folder.
1. Install [DOSBox](https://www.dosbox.com/download.php?main=1) following the installation process default instructions.

## Configuration

1. Open your command line and go to your clone folder root: `cd %absolute_path_to_clone_folder%`
2. Run the following command: `nasm/nasm src/main.asm -f bin -o pacman.com`
3. Run DOSBox
4. Type the following commands in the command line interface of DOSBox:
    - `MOUNT c %absolute_path_to_clone_folder%`
    - `c:`
    - `pacman`
5. Enjoy playing Pac-Man! 🙌
