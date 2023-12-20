This document contains the main management artifacts:
- [Tasks \& schedules](#tasks--schedules)
- [RACI matrix](#raci-matrix)
- [Risks and Assumptions](#risks-and-assumptions)
- [Key Performance Indicators](#key-performance-indicators)


# Tasks & schedules

The breakdown of the tasks, their assignment, as well as the planned and actual schedule of those tasks can be found here:
[Link](https://docs.google.com/spreadsheets/d/1_L6bDIeBvKiXOIi3NsIrYikzUCE2CW5MjeKNuF0ZZDU/edit#gid=0)

Half of the team is composed of new students who are beginners.
Originally, a GitHub project should have been used to deal with those tasks, but the way it works did not sit right with me. They were moved to a Google Spreadsheet. Since I did not know the capabilities of the new students at the time, but everyone knows how to use a spreadsheet, we decided to stick with it (albeit it not being the best for management).


# RACI matrix

The RACI matrix is as follows:

| Name                      | Project Manager | Program Manager | Technical Leader | Software Engineer | Quality Assurance | Client | Stakeholders |
| ------------------------- | --------------- | --------------- | ---------------- | ----------------- | ----------------- | ------ | ------------ |
| Project brief             | I               | I               | I                | I                 | I                 | A / R  | C            |
| Project charter           | A / R           | C / I           | C / I            | C / I             | C / I             | C      | C / I        |
| Schedule / Gantt chart    | A / R           | C / I           | C / I            | C / I             | C / I             |        | I            |
| Functional specifications | C               | A / R           | C                |                   | C / I             | C      | I            |
| Technical specifications  | C               | C               | A / R            | C                 | C / I             | C      | I            |
| Code                      |                 |                 | R                | A / R             |                   |        |              |
| Code review               | I               |                 | A / R            | R                 | R                 |        |              |
| Code documentation        |                 | I               | C                | A / R             | C / I             | I      |              |
| Usage instructions        |                 | I               | C                | A / R             | C / I             | I      |              |
| Testing plan              | I               | C               | C                | C                 | A / R             | I      |              |

Key:
| Letter | Name        | Description                                               |
| ------ | ----------- | --------------------------------------------------------- |
| R      | Responsible | Works on the task.                                        |
| A      | Accountable | Delegates and signs off. The one to be praised or blamed. |
| C      | Consulted   | Knowledgable and asked about the task.                    |
| I      | Informed    | Told about the progress and changes.                      |
|        | -           | Not involved                                              |


# Risks and Assumptions

| ID  | Description                                                                   | Impact                                                                                     | Impact | Likelihood | Strategy   | Solution                                                                                                          |
| --- | ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------ | ------ | ---------- | ---------- | ----------------------------------------------------------------------------------------------------------------- |
| 1   | Assembly is a low level language which is new to us all                       | This will slow the code creation down a lot                                                | High   | High       | Sharing    | Have other members of the group help when necessary                                                               |
| 2   | Although it is a simple game, there is still a lot to do.                     | We may not finish on time, especially with scope creep.                                    | High   | Medium     | Reduction  | Start with the most simple and fundamental tasks and go to more detailed ones.                                    |
| 3   | Pac-Man is copyrighted and trademarked.                                       | The right-owners may sue us if they find our project.                                      | High   | Low        | Acceptance | The client asked us to accept the risk as it has a very low likelihood.                                           |
| 4   | New students are not used to the conventions.                                 | The communication might suffer from this by having different styles.                       | Medium | Medium     | Reduction  | We will define precise specifications to ensure this does not happen.                                             |
| 5   | Compatibility between different hardware is hardly possible.                  | If the client decides to use physical hardware, our program may not work.                  | Medium | Low        | Avoidance  | We will try to stick to the basic 16-bit x86 instructions.                                                        |
| 6   | The client may decide to change the requirements of the project.              | We would have to reasses a new path to take, possibly delaying us if we were already done. | Medium | Medium     | Reduction  | We will communicate often with the client to ensure that the specifications are correctly defined from the start. |
| 7   | With winter arriving, health and transport issues are more likely to come up. | Team members may be late or even missing, possibly for multiple days.                      | Medium | High       | Sharing    | The work of missing member will either be shared to other, done later, or done remotely.                          |


# Key Performance Indicators

The spreadsheet for the KPI's data and graphs can be found here: [Link](https://docs.google.com/spreadsheets/d/1RYkqnD_rz8yrWJvCnmFTPFPuRaUDdRS211xFWdnWMaA/edit#gid=0)