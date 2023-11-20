# Pac-Man Project Test Plan

<details>
<summary>Table of Contents</summary>

- [Pac-Man Project Test Plan](#pac-man-project-test-plan)
  - [Product Analysis](#product-analysis)
    - [Overview](#overview)
  - [Strategy](#strategy)
    - [Scope of Testing](#scope-of-testing)
    - [Unit Tests](#unit-tests)
    - [Game-testing sessions](#game-testing-sessions)
      - [Overview](#overview-1)
      - [Smoke Testing](#smoke-testing)
      - [Group Game-Testing](#group-game-testing)
    - [Monitoring and tools](#monitoring-and-tools)
      - [GitHub](#github)
      - [Bug Data Report Spreadsheet](#bug-data-report-spreadsheet)
    - [Documentation](#documentation)
      - [GitHub Wiki](#github-wiki)
      - [Template](#template)
  - [Objectives](#objectives)
    - [Overview:](#overview-2)
      - [Key Objectives:](#key-objectives)
  - [Test Criteria](#test-criteria)
    - [Overview:](#overview-3)
      - [Key Criteria:](#key-criteria)
  - [Allocated Resources](#allocated-resources)
    - [Overview:](#overview-4)
      - [Key Considerations:](#key-considerations)
    - [Time](#time)
    - [People](#people)
  - [Test Environment](#test-environment)
    - [X86](#x86)
      - [Overview](#overview-5)
      - [Code Example](#code-example)
  - [Test Schedule and Estimation](#test-schedule-and-estimation)
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
Our testing strategy employs a multifaceted approach to ensure the robustness and reliability of the project. **[Unit Tests](#unit-tests)** form the bedrock, scrutinizing individual components for functionality. **[Game-testing sessions](#game-testing-sessions)** take center stage, offering a holistic evaluation of gameplay, user interactions, and overall user experience. Augmenting our strategy are sophisticated **[monitoring tools](#monitoring-and-tools)**, enabling real-time analysis of system performance, identifying potential bugs, and ensuring optimal execution. 

### Scope of Testing
Testing will focus on both core gameplay elements and peripheral features to guarantee a reliable end product. However, it's important to note that certain aspects, such as low-level technical details will be excluded from testing as they are beyond the scope of the test.

**In-scope for Testing:**
- Code
  - Absence of significant bugs     
  - Main game mechanics functionality
  - Acceptable visual quality
- Documents
  - Spelling accuracy
  - Typographical errors

**Out of Scope for Testing:**
- Font details
- Colors of sprites
- Sprite speed


### Unit Tests

Unit testing is an important part of the process. These tests are developed in X86 assembler and executed on DOSBox, to have an environment as close as possible to the final game.

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

### Game-testing sessions
---
#### Overview


Due to the difficulty of creating a test bot for an assembler game running on an emulator and the time allocated to this project. One of the chosen testing solutions was to test the code manually. To do this, a tester has to play the game and perform several specific actions to find bugs and errors. All the tests are defined in this [document](https://docs.google.com/spreadsheets/d/1Wm9y6b1pe2TSEv-pNZyj7Igid2MQinLGrvEB3opBlmk/edit?usp=sharing). To identify errors as accurately as possible, the tester must record his or her screen throughout the test session, using the "Snipping tool" on Windows computers and "QuickTime Player" on Apple computers.

---
#### Smoke Testing

Game testing sessions will take place after each project release. These sessions will serve as smoke tests. The primary goal of smoke testing is to quickly assess whether the essential functionalities of the project are working as expected after each build. This testing phase is designed to identify critical issues early in the development process, allowing for rapid feedback and swift resolution of potential show-stopping problems.

**Smoke Testing Scope:**

The smoke testing scope will focus on the fundamental aspects of the game. This includes:

1. **Game Launch:** Confirm that the game launches successfully without any critical errors or crashes.
2. **Player Controls:** Verify that basic player controls (up, down, left, right) respond as intended.
3. **Character Movement:** Ensure that Pac-Man moves through the maze at the specified speed without glitches or abnormalities.
4. **Collision Detection:** Validate that collision detection is functioning correctly, especially between Pac-Man and ghosts.
5. **Basic Interactions:** Confirm basic interactions, such as eating dots and encountering ghosts, occur without errors.

**Sequence of Smoke Testing:**

During each smoke testing session, the following steps will be executed:

1. **Build Deployment:** Deploy the latest build of the project in the testing environment.
2. **Test Execution:** Execute a set of [predefined test cases](https://docs.google.com/spreadsheets/d/1Wm9y6b1pe2TSEv-pNZyj7Igid2MQinLGrvEB3opBlmk/edit?usp=sharing) covering the critical functionalities.
3. **Archiving results:** Archive the test results [here](https://docs.google.com/spreadsheets/d/1Wm9y6b1pe2TSEv-pNZyj7Igid2MQinLGrvEB3opBlmk/edit?usp=sharing) for future reference.
4. **Issue Reporting:** If critical issues are identified, report them promptly to the development team for resolution.

---
#### Group Game-Testing

To gain a better overview of the project, a collaboration with the [3rd](Collaboration-QA.md) team's quality assurance team was set up. This collaboration enables the 2 teams to have an external view of the game and simply identify errors and bugs. The main advantage of this collaboration is to have several points of view on the same situation and to see or share new working methods. 

**Group Game-Testing Scope:**

Group sessions are designed primarily to:
1. **Verify that the game is working as expected:** Check that all the game's basic and additional game mechanics are working properly.
2. **Sharing tests:** Share tests between the 2 teams to have a better overview of the game and to find more bugs and errors.
3. **Identify bugs and errors:** Find bugs and errors in the game to improve it.
4. **Identify improvements and missing features:** Find improvements and missing features in the game to bring it closer to the original.
5. **Identify spelling and grammar errors:** Find spelling and grammar errors in the game and report them.

**A Sequence of a Group Game-Testing:**

A group testing session will take place once a week during one of the hours allocated to the project.
Each session will follow the following steps:
1. **Game quick overview:** A quick overview of the game is done to see the progress of the project.
2. **Testing points:** The testing points are defined and shared between the 2 teams, testing points will be adapted to each project's progression.
3. **Testing session:** The test session is carried out by the 2 teams on the 2 games, and the tests are carried out according to this [list](todo).
4. **Test results:** The test results are shared between the 2 teams and the bugs and errors are reported on the [Bug Data Report](https://docs.google.com/spreadsheets/d/1Wm9y6b1pe2TSEv-pNZyj7Igid2MQinLGrvEB3opBlmk/edit?usp=sharing).

For the sake of simplicity, during test sessions, the game will be launched on the computer of the team developing it. This allows our team to record each test session and avoid sending the recorded files afterward.


### Monitoring and tools

---
#### GitHub

**Overview**  

For this project, GitHub is imposed to store our code, GitHub is a web-based version control and collaboration platform for software developers. It provides a centralized repository for storing and managing source code, facilitating collaboration between developers.

But more than just a code storage system, it's a powerful tool for many other tasks. Here, it will be used for project monitoring to help each team member with his various tasks. The GitHub add-ons used in this project are **GitHub Actions**](#github-actions)** and **[GitHub Issues](#github-issues)**.

---
**GitHub Actions**

GitHub Actions is a CI/CD tool that allows us to run tests automatically after various actions on the repository and avoid errors on the dev or main branch. This will also permit to have an integrated overview of the failure of the code directly in GitHub.

**GitHub Actions Scope:**  

The GitHub Actions will be activated on pull requests on the dev and main branch and their scope is to:
1. **Build game:** Build the game and ensure there is no assembling error.
2. **Run unit tests:** Run unit tests to ensure that the main functions of the game are working properly.
3. **Ensure that the code on the references branches is working** Ensure that the code on the main and dev branches is working properly and avoid creating new branches from code that doesn't work.

**Workflow:**  

The workflow defines the different steps to be executed by GitHub Actions. The workflow is defined in the file [pacman.yml](../.github/workflows/pacman.yml) and is executed on each pull request on the main or dev branch.

The workflow we will use to improve project quality is defined in the following diagrams:

![](../pictures/GitWorkflow.png)

**Configuration:**

Actions such as assembling and execution of unit tests are performed on a computer or server. These actions are enabled and synchronized with GitHub thanks to a runner provided by GitHub. To install the runner, there is GitHub [documentation](https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners) explaining the various steps involved. Once the runner has been installed and activated on a computer, it can be selected to execute the various workflow actions.

As our team does not have a server to host the runner, the decision was made to install the runners on the computers of the project's quality assurance staff:
- Thomas Planchard
- Maxime Caron

Next, the various actions and workflow steps are defined in the [pacman.yml](/pacman.yml) file, which is saved at the root of the repository.

---
**GitHub Issues**

To manage bugs, errors, deadlines, documentation, and task allocation, this project uses GitHub Issues. GitHub Issues serves as a comprehensive and centralized platform for tracking and addressing various aspects of our project development lifecycle. 

We define:
- **Bugs:** Unexpected problems such as screen flashing or code errors.
- **Errors:** Includes all errors that do not originate in the code.
- **Deadlines:** Specific deadlines for project stages to ensure timely delivery.
- **Documentation:** Request for documentation on a specific function or group of functions in the code.
- **Task allocation:** Assignment and tracking of specific responsibilities.
 
By leveraging GitHub Issues, our project benefits from a structured and efficient approach to project management, bolstering communication and fostering an organized and collaborative development environment.

**GitHub Issues Scope:**

The use of GitHub Issues encompasses a broad range of functionalities aimed at enhancing collaboration, communication, and project management within a software development environment. Here are key aspects of its scope:

1. **Bug Tracking:** GitHub Issues provides a systematic approach to identifying, documenting, and managing software bugs. Team members can report bugs, discuss potential solutions, and track the resolution process.

2. **Error Management:** Beyond bugs, GitHub Issues can be utilized to track and resolve general errors. This includes addressing issues related to document, and logic errors.

3. **Task Management:** GitHub Issues serves as a comprehensive task management tool, allowing teams to create, assign, and track tasks. It provides visibility into individual responsibilities, ensuring a clear understanding of who is working on what.

4. **Project Planning:** The platform supports project planning by enabling the creation and tracking of milestones and deadlines. Teams can set targets, monitor progress, and adjust timelines as needed.

5. **Documentation:** GitHub Issues acts as a documentation hub, capturing discussions, decisions, and context around code changes. This documentation is valuable for onboarding new team members, maintaining a historical record, and ensuring knowledge continuity.

In essence, GitHub Issues provides a versatile and collaborative framework for managing the entire game development lifecycle, from identifying and resolving issues to planning and releasing software updates.


#### Bug Data Report Spreadsheet

**Overview:**

The [Bug Data Report](https://docs.google.com/spreadsheets/d/1Wm9y6b1pe2TSEv-pNZyj7Igid2MQinLGrvEB3opBlmk/edit?usp=sharing) serves as a comprehensive tool for documenting and tracking test cases, their results, and overall testing progress. It adopts a standardized pattern for each test case, ensuring clarity and consistency in reporting.

**Spreadsheet Structure:**

1. **Test Case Pattern:**
   - **ID:** Unique identifier for each test case.
   - **Function:** The function or feature being tested.
   - **Priority:** The priority level of the test case (e.g., High, Medium, Low).
   - **Description:** A concise description of the test case.
   - **Inputs:** Input values or conditions applied during testing.
   - **Expected Result:** The expected outcome or behavior.


2. **Testing Sessions:**
   - For each test case, there is a dedicated section to record results obtained during testing sessions.
   - Testers can input whether the test passed, failed, is in progress, or not implemented during a specific testing session.
   - The date of the testing session is also recorded.
   

3. **Graphics:**
   - **Test Percentage Representation:**
     - A pie chart representing the percentage distribution of test cases based on their status (Passed, Failed, In Progress, Not Implemented).
     - Provides a visual snapshot of the overall testing status.

   - **Test Execution Progress:**
     - A line chart depicting the progress of test execution over time.
     - Enables monitoring of testing efforts and helps identify trends in the resolution of test cases.

**Benefits:**
- **Standardization:** The standardized pattern ensures consistency and clarity in documenting test cases.
- **Real-Time Tracking:** Testing sessions allow for immediate recording of test results and tracking of ongoing efforts.
- **Visual Representation:** Graphics provide a quick and visual overview of testing status and progress.


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

Install an x86 assembler in DOSBox to write and compile assembly code. The technical team chose to pick NASM (Netwide Assembler) as the reference. a snippet of unit test code 
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
<!-- 
### Overview:

Testing tasks are divided into two parts: code testing and documentation testing. We chose to split the work into two parts because it would allow us to work in parallel and to have a better overview of the project.

### Code Testing 

To test the code of the wall project we chose to split the work into 4 key steps.

#### Key Steps:

1. Create a unit test template and give it to all developers. Each developer will then write their unit tests for their functions.
2. Write unit tests for each project function; it will help us to find bugs and errors in the code. This part will be done in parallel with the development of the project.
3. Automate tests with GitHub Actions, this will allow us to run tests automatically after each commit and avoid errors on the main branch. This will also permit to have an integrated overview of failure and coverage of the code directly in GitHub.
4. Organize regular test sessions to hand-test the game. Each test session will be filmed to better visualize problem cases and identify errors more quickly. This will allow us to have a visual overview of the game and to see if the game is working as expected. -->

#### Tasks Time Estimation:
| Task | Time | Comment |
| --- | --- | --- |
| Create and give template for documentation | 1-2 days | |
| Organize a meeting with all developers | 1 hour | Meeting are planned every week. |
| Review the documentation | 1-2 days | Review are planned every week. |
| Unit tests | 1-2 days | Unit test will be done in parallel with the development of the project. |
| Test session | 1 hour | Test session will be done every week. |
| GitHub Actions | 1 week | |
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

