# Pac-Man recreation - Project charter

|                |                  |
| -------------- | ---------------- |
| Document name  | Project charter  |
| Document owner | Léo CHARTIER     |
| Issue date     | November 8, 2023 |

## Table of content
- [Pac-Man recreation - Project charter](#pac-man-recreation---project-charter)
  - [Table of content](#table-of-content)
  - [Project definition](#project-definition)
  - [Scope](#scope)
  - [Stakeholders](#stakeholders)
  - [Team members](#team-members)
  - [Responsabilities](#responsabilities)
  - [Project plan](#project-plan)
  - [Milestones](#milestones)
  - [Deliverables](#deliverables)
  - [Budget](#budget)
  - [Risks](#risks)


## Project definition

The project is a recreation of the classic Pac-Man.

The client is ALGOSUP, the programming school we are part of, and our contact point is Franck JEANNIN, the school director.

## Scope

The project should be done in Assembly using a 16-bit x86 architecture.
Additionally, it will run on the DOSBox emulator.

The recreation should implement the basic mechanics of the game. If not copyright infringement is broken, the original assets may also be re-used. <!-- to be confirmed with the client -->

## Stakeholders

| Role   | Representative           | Expectation   |
| ------ | ------------------------ | ------------- |
| Client | Franck JEANNIN (ALGOSUP) | Final project |

## Team members

| Role                     | Name             | Email                        | Github                                                          |
| ------------------------ | ---------------- | ---------------------------- | --------------------------------------------------------------- |
| Project Manager          | Léo CHARTIER     | leo.chartier@algosup.com     | [leo-chartier](https://github.com/leo-chartier)                 |
| Program Manager          | Antoine PREVOST  | antoine.prevost@algosup.com  | [TechXplorerFR](https://github.com/TechXplorerFR)               |
| Technical Leader         | Malo ARCHIMBAUD  | malo.archimbaud@algosup.com  | [Malo-Archimbaud](https://github.com/Malo-Archimbaud)           |
| Junior Software Engineer | Maxime THIZEAU   | maxime.thizeau@algosup.com   | [MaximeTAlgosup](https://github.com/MaximeTAlgosup)             |
| Junior Software Engineer | Benoît DE KEYN   | benoit.dekeyn@algosup.com    | [benoitdekeyn-algosup](https://github.com/benoitdekeyn-algosup) |
| Quality Assurance        | Maxime CARON     | maxime.caron@algosup.com     | [MaximeAlgosup](https://github.com/MaximeAlgosup)               |
| Quality Assurance        | Thomas PLANCHARD | thomas.planchard@algosup.com | [thomas-planchard](https://github.com/thomas-planchard)         |

## Responsabilities

| Role              | Responsabilities                                                                                                         | Performance criteria                                                       |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------- |
| Project Manager   | Report to stakeholders<br>Management (deadlines, budget, ...)<br>Task repartition                                        | Project delivered on time and budget<br>Good planning                      |
| Program Manager   | Design<br>Communication with client<br>Functional specifications                                                         | Functional specifications<br>Client satisfaction                           |
| Technical Leader  | Choose techincal tools<br>Define interactions within the code<br>Review code<br>Technical specifications                 | Techincal specifications                                                   |
| Software Engineer | Writing code<br>Fixing bugs<br>Document the code                                                                         | (Unit tests)<br>No bugs in the code                                        |
| Quality Assurance | Verify documents<br>Test the program<br>Confirm we match the client needs<br>Overall quality of the project<br>Test plan | All bugs identified<br>Good team cohesion<br>Deliver a qualitative project |

## Project plan

A meeting with the client was organized at the beginning of the first day. Further discussions will be made via emails/messages.

The project will mainly use the Waterfall method as shown by the deliverables, but will also use SCRUM ideas to improve the quality of development.
The program will be split into multiple steps which will be incrementally implemented. This will also allow for fast testing iterations, leading to fewer bugs.

The planning will be done by defining the objectives and tasks from the outset. They will be sorted by order of importance and distributed accordingly. To manage it, we will create a Github Project within our repository to keep things centralized and easy to access. We will also use tools such as a Gantt chart and KPIs to help us manage the project.

Finally, after the presentation to the client, we will make a post-mortem analysis to review what happened and make a report to the client.

## Milestones

| Date  | Time   | Milestone                         |
| ----- | ------ | --------------------------------- |
| 6/11  | 9am    | Project acknowledgment & start    |
| 13/11 | 1.30pm | Functional specification delivery |
| 27/11 | 1.30pm | Technical specification delivery  |
| 8/12  | 5pm    | Test plan delivery                |
| 11/12 | 5pm    | Working prototype delivery        |
| 21/12 | 5pm    | Final product delivery            |
| 22/12 | 9am    | Presentation pitch                |

## Deliverables

The main deliverable is the final code and executable file. We will hand over a prototype to ensure we are still on track.

Additionally, many documents will be provided to the client. Those include:
- Functional specifications
- Technical specifications
- Test plan
- Management planning & weekly reports

Finally, a presentation of our work will be done to the client in the form of a 15-minute presentation.

## Budget

Money: Free  
Workforce: 7 team members  
Worktime: 24 half days of 3h30

Estimated total human hours: 588h

## Risks

- Implementations difficulties
  - Our software engineers are juniors, and Assembly is not an easy language. They could have too many problems implementing the code, leading to delays.
  - Likelihood: High
  - Impact: High
  - Mitigation: Reschedule tasks of other members
- Copyright
  - The artworks of Pac-Man are copyrighted, and Pac-Man is also a registered trademark. Recreating the game could lead to heavy lawsuits if actual rights-owners hear of this project.
  - Likelihood: Low to medium
  - Impact: High
  - Mitigation: Acceptance <!-- to be discussed with the client -->
- New requirements
  - The client may change the requirements during the project, forcing us to change the specifications and planning.
  - Likelihood: Medium
  - Impact: Depend on the requested change
  - Mitigation: Avoidance