# Pac-Man Project Test Plan

<details>
<summary>Table of Contents</summary>

- [Pac-Man Project Test Plan](#pac-man-project-test-plan)
  - [Product Analysis](#product-analysis)
    - [Overview](#overview)
    - [Challenges](#challenges)
  - [Strategy](#strategy)
    - [Overview](#overview-1)
    - [Tests](#tests)
      - [Unit Tests](#unit-tests)
      - [Manual Tests](#manual-tests)
    - [Monitoring tools](#monitoring-tools)
      - [GitHub Tests Automation](#github-tests-automation)
      - [Coverage Script](#coverage-script)
      - [Unit Test Exploitation Script](#unit-test-exploitation-script)
      - [Git issues](#git-issues)
    - [Documentation](#documentation)
      - [GitHub Wiki](#github-wiki)
      - [Template](#template)
  - [Objectives](#objectives)
  - [Test Criteria](#test-criteria)
  - [Allocated Resources](#allocated-resources)
    - [Time](#time)
    - [People](#people)
  - [Test Environment](#test-environment)
    - [X86](#x86)
      - [Overview](#overview-2)
      - [Code Example](#code-example)
    - [DOSBox](#dosbox)
      - [Overview](#overview-3)
      - [Configurations](#configurations)
  - [Schedule and Estimation](#schedule-and-estimation)
      - [Key Tasks:](#key-tasks)
      - [Tasks Time Estimation:](#tasks-time-estimation)
      - [Schedule:](#schedule)
  - [Deliverables and Schedule](#deliverables-and-schedule)
    - [Deliverables and Estimation](#deliverables-and-estimation)
    - [Schedule](#schedule-1)
  - [Glossary](#glossary)

</details>

---

## Product Analysis

### Overview

This project targets a diverse audience, from those well-acquainted with the original Pac-Man to individuals who may be discovering the game for the first time. With a dual purpose, the product aims to serve as an educational tool for learning assembly language coding and as an entertainment game.

We will illustrate the operational flow of the software and provide a visual representation through a diagram. For further details, refer to the [functional specifications](../functional/functional-specifications.md) document.

![](../pictures/diagramWalkthrough.png)

The software specifications encompass the DOSBox emulator, while the hardware requirements include an emulator with a 16-bit processor, X86 architecture, 65,536 bytes of RAM.

### Challenges

## Strategy

### Overview

The strategy for ensuring the quality of the project and the final product is based on 3 points:
- Testing
- Monitoring
- Documentation

These 3 points not only aim to improve the final product, but also play an important role in improving the working conditions of each team member.

### Tests

#### Unit Tests

Unit testing is an important part of the process. These tests are developed in X86 assembler and executed on DOSBox, in order to have an environment as close as possible to that of the final game.

These tests are developed throughout the project in parallel with game development, corresponding to an exploratory testing approach.

The main objectives of these tests are:
- Check that the game's essential functions are working properly.
- Check all other game functions as far as possible.
- Serve as non-regression tests between each game update.

#### Manual Tests

Manual testing is carried out by people playing the game during defined sessions.

These tests last at least 1 hour every week, until the end of the project.

Each test session is filmed and saved, enabling us to see the exact cause of any error and to reproduce the bug conditions as closely as possible afterwards.

In order not to forget any tests during verification sessions, a list is given to the tester. This test list is created and completed by all project members to ensure that it is as complete as possible.

The main objectives of these tests are to
- Check that the essential game mechanics are working properly.
- Check all other game functions as far as possible.
- To serve as a non-regression test between game updates.

### Monitoring tools

#### GitHub Tests Automation

#### Coverage Script

#### Unit Test Exploitation Script

#### Git issues

### Documentation

#### GitHub Wiki

#### Template

## Objectives

## Test Criteria

## Allocated Resources

### Time

### People

## Test Environment
### X86
#### Overview
#### Code Example

### DOSBox
#### Overview
DOSBox is an emulator that simulates an MS-DOS-compatible environment for running programs formerly developed for this system. Here it is used to run programs written in X86 assembly language on a 16-bit processor.

#### Configurations
**1. Download and Install:**

Download and install DOSBox. You can find the latest version on the official [DOSBox website](https://www.dosbox.com/). Follow the installation instructions provided.

**2. Configure DOSBox for Development:**

1. Launch DOSBox.
2. Mount a directory where you'll store your project files using the following command:
   ```
   mount C C:\path\to\your\pacmanProject
   ```
   Replace `C:\path\to\your\pacmanProject` with the actual path to your project directory.

**3. Install an Assembler:**

Install an x86 assembler in DOSBox to write and compile assembly code. The technical team chose to pick NASM (Netwide Assembler) as the reference. 

## Schedule and Estimation

#### Key Tasks:

1. Create a unit test template and give it to all developers. Each developer will then write their unit tests for their functions.
2. Write unit tests for each project function; it will help us to find bugs and errors in the code. This part will be done in parallel with the development of the project.
3. Automate tests with GitHub Actions, this will allow us to run tests automatically after each commit and avoid errors on the main branch. This will also permit to have an integrated overview of failure and coverage of the code directly in GitHub.
4. Organize regular test sessions to hand-test the game. Each test session will be filmed to better visualize problem cases and identify errors more quickly. This will allow us to have a visual overview of the game and to see if the game is working as expected.

#### Tasks Time Estimation:
| Task | Time | Comment |
| --- | --- | --- |
| Create and give template for documentation | 1-2 days | |
| Organize a meeting with all developers | 1 hour | Meeting are planned every week. |
| Review the documentation | 1-2 days | Review are planned every week. |
| Unit tests | 1-2 days | Unit test will be done in parallel with the development of the project. |
| Test session | 1 hour | Test session will be done every week. |
| GitHub Actions | 1 week | |
| Coverage script | 1 week | |
| Unit test formater script | 1 week | |

#### Schedule:
| Task | Start Date | End Date |
| ---- | ---------- | -------- |
| Create and give template for documentation | November 13, 2023 | November 13, 2023 |
| Organize a meeting with all developers | November 13, 2023 | December 22, 2023 |
| Unit tests | November 13, 2023 | December 22, 2023 |
| Review the documentation | November 20, 2023 | December 22, 2023 |
| Test session | November 20, 2023 | December 22, 2023 |
| GitHub Actions | November 27, 2023 | December 3, 2023 |
| Coverage script | December 4, 2023 | December 12, 2023 |
| Unit test formater script | December 4, 2023 | December 12, 2023 |

## Deliverables and Schedule
### Deliverables and Estimation
### Schedule

## Glossary