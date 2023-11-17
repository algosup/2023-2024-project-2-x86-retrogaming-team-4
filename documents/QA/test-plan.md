# Pac-Man Project Test Plan

<details>
<summary>Table of Contents</summary>

- [Pac-Man Project Test Plan](#pac-man-project-test-plan)
  - [Product Analysis](#product-analysis)
    - [Overview](#overview)
  - [Strategy](#strategy)
    - [Test](#test)
    - [Scope of Testing](#scope-of-testing)
    - [Type of Testing](#type-of-testing)
    - [1. Smoke Testing Strategy](#1-smoke-testing-strategy)
      - [Objective](#objective)
      - [Scope](#scope)
      - [Execution](#execution)
      - [Benefits](#benefits)
      - [Automation Consideration](#automation-consideration)
    - [2. Unit Tests](#2-unit-tests)
      - [Manual Tests](#manual-tests)
    - [Monitoring tools](#monitoring-tools)
      - [3. Managing Test Cases with Excel](#3-managing-test-cases-with-excel)
        - [Step 1: Create an Excel Spreadsheet](#step-1-create-an-excel-spreadsheet)
        - [Step 2: Populate Test Cases](#step-2-populate-test-cases)
      - [GitHub Tests Automation](#github-tests-automation)
        - [Unit Test Exploitation Script](#unit-test-exploitation-script)
      - [GitHub issues](#github-issues)
    - [Documentation](#documentation)
      - [GitHub Wiki](#github-wiki)
      - [Template](#template)
  - [Objectives](#objectives)
    - [Overview:](#overview-1)
      - [Key Objectives:](#key-objectives)
  - [Test Criteria](#test-criteria)
    - [Overview:](#overview-2)
      - [Key Criteria:](#key-criteria)
  - [Allocated Resources](#allocated-resources)
    - [Overview:](#overview-3)
      - [Key Considerations:](#key-considerations)
    - [Time](#time)
    - [People](#people)
  - [Test Environment](#test-environment)
    - [X86](#x86)
      - [Overview](#overview-4)
      - [Code Example](#code-example)
  - [Test Schedule and Estimation](#test-schedule-and-estimation)
    - [Overview:](#overview-5)
    - [Code Testing](#code-testing)
      - [Key Steps:](#key-steps)
      - [Tasks Time Estimation:](#tasks-time-estimation)
      - [Schedule:](#schedule)
  - [Deliverables and Schedule](#deliverables-and-schedule)
    - [Deliverables and Estimation](#deliverables-and-estimation)
    - [Schedule](#schedule-1)
      - [Before Testing:](#before-testing)
      - [During Testing:](#during-testing)
      - [After Testing:](#after-testing)
  - [Glossary](#glossary)

</details>

---

## Product Analysis

### Overview

This project targets a diverse audience, from those well-acquainted with the original Pac-Man to individuals who may be discovering the game for the first time. With a dual purpose, the product aims to serve as an educational tool for learning assembly language coding and as an entertainment game.

We will illustrate the operational flow of the software and provide a visual representation through a diagram. For further details, refer to the [functional specifications](../functional/functional-specifications.md) document.

![](../pictures/diagramWalkthrough.png)

The software specifications encompass the DOSBox emulator, while the hardware requirements include an emulator with a 16-bit processor, X86 architecture, and 65,536 bytes of RAM.

## Strategy
### Test 
### Scope of Testing
<!-- The testing scope for the project encompasses a thorough examination of the game. This includes rigorous testing of the DOSBox emulator, ensuring compatibility with various hardware configurations, and evaluating the functionality of the assembly x86 code. Testing will focus on both core gameplay elements and peripheral features to guarantee a reliable end product. However, it's important to note that certain aspects, such as low-level technical details like the font of the text, the colors used for each item and the speed of the sprite will be excluded from testing as they are beyond the scope of the test.

- code
  - no big bug
  - main game mechanics
  - acceptable visual
- documents
  - Spelling
  - Typo
- exclude
  - font
  - colors of sprite
  - sprite speed -->

### Type of Testing

The testing process will employ different testing types to identify and rectify specific types of bugs. This includes the following:
1. **Smoke Testing:** This testing phase is designed to identify critical issues early in the development process.
2. **User Interface Testing:** Assessing the visual quality and smooth operation of visual elements, including character sprites, animations, and maze designs.
3. **Performance Testing:** Evaluating the responsiveness of player controls and the overall speed of the game, ensuring it meets the specified movement speed criteria.
4. **Functional Testing:** Ensuring that all gameplay features, including player controls, movement, interactions, and game rules, operate as intended.


### 1. Smoke Testing Strategy 

#### Objective
The primary goal of smoke testing is to quickly assess whether the essential functionalities of the project are working as expected after each build. This testing phase is designed to identify critical issues early in the development process, allowing for rapid feedback and swift resolution of potential show-stopping problems.

#### Scope
The smoke testing scope will focus on the fundamental aspects of the game. This includes:

1. **Game Launch:** Confirm that the game launches successfully without any critical errors or crashes.
2. **Player Controls:** Verify that basic player controls (up, down, left, right) respond as intended.
3. **Character Movement:** Ensure that Pac-Man moves through the maze at the specified speed without glitches or abnormalities.
4. **Collision Detection:** Validate that collision detection is functioning correctly, especially between Pac-Man and ghosts.
5. **Basic Interactions:** Confirm basic interactions, such as eating dots and encountering ghosts, occur without errors.


#### Execution
The smoke testing process will be executed systematically after each build or significant code change. It involves the following steps:

1. **Build Deployment:** Deploy the latest build of the project in the testing environment.
2. **Test Execution:** Execute a set of predefined test cases covering the critical functionalities.
3. **Results Analysis:** Analyze the test results to identify any critical issues or deviations from expected behavior.
4. **Issue Reporting:** If critical issues are identified, report them promptly to the development team for resolution.
5. **Decision Making:** Based on the results, decide whether the build is stable enough for further testing or if it requires immediate attention and fixing.

#### Benefits
1. **Early Issue Identification:** Smoke testing allows for the early identification of critical issues, preventing the propagation of major defects into subsequent development phases.
2. **Rapid Feedback:** The quick turnaround of smoke testing provides rapid feedback to the development team, enabling timely resolution of critical issues.
3. **Stability Assessment:** It helps assess the stability of each build, allowing for a more controlled and reliable development process.

#### Automation Consideration
While smoke testing is typically manual, consideration should be given to automating repetitive and critical smoke test cases to enhance efficiency and ensure consistent execution after each build. Automated smoke tests can be integrated into the continuous integration/continuous deployment (CI/CD) pipeline for faster feedback.

By implementing a robust smoke testing strategy, the Pac-Man project can maintain a stable and reliable codebase throughout its development lifecycle.


### 2. Unit Tests

Unit testing is an important part of the process. These tests are developed in X86 assembler and executed on DOSBox, to have an environment as close as possible to that of the final game.

These tests are developed throughout the project in parallel with game development, corresponding to an exploratory testing approach.

The main objectives of these tests are:
- Check that the game's essential functions are working properly.
- Check all other game functions as far as possible.
- Serve as non-regression tests between each game update.`


| Function | Expected Result | Severity |
| --- | --- | --- |
| Score when eating a dot | Score is incremented by 10 | Medium |
| Score when eating a big dot | Score is incremented by 50 | Medium |
| Score when eating a ghost | Score is incremented by 200 | Medium |
| Score when eating a cherry | Score is incremented by 100 | Medium | 
| Clyde behavior | Clyde is supposed to be near to pacMan and at less of 8 cases he becomes random | Medium |
| Wall collision (Pac-Man) | Pac-Man is supposed to be stopped by every e wall | High |
| Wall collision (Ghost) | Ghosts are supposed to be stopped by every wall | High |
| Ghosts collision (Ghost) | Ghosts are supposed to be stopped by every other ghosts | High |
| Increase lives | Add new life to the player when user get 10.000 points | Medium |
| Lives cap | Player can't have more than 5 lives | Medium |
| Ghost speed increase | Ghost speed increase when user change level | Medium |

#### Manual Tests

Manual testing is carried out by people playing the game during defined sessions. These tests last at least 1 hour every week, until the end of the project.

Each test session is filmed and saved, enabling us to see the exact cause of any error and to reproduce the bug conditions as closely as possible afterward.

In order not to forget any tests during verification sessions, a list is given to the tester. This test list is created and completed by all project members to ensure that it is as complete as possible.

The main objectives of these tests are to
- Check that the essential game mechanics are working properly.
- Check all other game functions as far as possible.
- To serve as a non-regression test between game updates.


### Monitoring tools

#### 3. Managing Test Cases with Excel


##### Step 1: Create an Excel Spreadsheet

Create a new Excel spreadsheet to document your test cases. Organize it with columns for test ID, test description, steps to reproduce, expected result, actual result, and status.

##### Step 2: Populate Test Cases

Based on the test plans provided, fill in the test cases with specific details, including expected outcomes and any additional notes.

#### GitHub Tests Automation

##### Unit Test Exploitation Script

#### GitHub issues

When you encounter a bug during testing, follow these steps to report it:

1. Go to your project's GitHub repository.
2. Click on the "Issues" tab.
3. Click "New Issue" to create a new bug report.
4. Provide a descriptive title and detailed description of the bug.
5. Include steps to reproduce the bug, expected behavior, and actual behavior.
6. Assign labels, milestones, and assignees if applicable.
7. Submit the issue.

### Documentation

#### GitHub Wiki

#### Template

## Objectives
### Overview:
Define the goals and expected results of test execution.

#### Key Objectives:
- Test all software features (functionality, GUI, performance standards).
- Set benchmark results for each aspect of the software.

## Test Criteria
### Overview:
Establish standards or rules governing all activities in the testing project.

#### Key Criteria:
- Suspension Criteria
- Exit Criteria

## Allocated Resources
### Overview:
Plan human resources, equipment, and infrastructure needed for testing.

#### Key Considerations:
- Determine required resources (testers, equipment).
- Calculate schedule and effort estimation.

### Time

### People

## Test Environment
### X86

**Install NASM**

Install an x86 assembler in DOSBox to write and compile assembly code. The technical team chose to pick NASM (Netwide Assembler) as the reference. 

snippet of unit test code 
#### Overview
#### Code Example

**Configure DOSBox for testing**

1. Launch DOSBox.
2. Mount a directory where you'll store your project files using the following command:
   ```
   mount C C:\path\to\your\pacmanProject
   ```
   Replace `C:\path\to\your\pacmanProject` with the actual path to your project directory.


## Test Schedule and Estimation

### Overview:

Testing tasks are divided into two parts: code testing and documentation testing. We chose to split the work into two parts because it would allow us to work in parallel and to have a better overview of the project.

### Code Testing 

To test the code of the wall project we chose to split the work into 4 key steps.

#### Key Steps:

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

#### Before Testing:
- Test Plan
- Test Design

#### During Testing:
- Test Scripts
- Simulators or Emulators (in early stages)
- Test Data
- Error and execution logs

#### After Testing:
- Test Results
- Defect Reports
- Release Notes

## Glossary

