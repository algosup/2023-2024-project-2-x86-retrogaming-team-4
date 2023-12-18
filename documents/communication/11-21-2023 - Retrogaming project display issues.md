# Team 4 - Retrogaming project display issues

## Communication through: mails

Date: `11/21/2023 3:42 PM`

From: `Antoine PREVOST (Program Manager)`

To: `Franck JEANNIN (Client)`

---

Hello Franck, I hope this message finds you well.

You requested a recreation of the Pac-Man game but on limited hardware. This requirement raises an issue relating to the size of the screen and the colors we can display on it.

Although we believe we can have the original colors and screen size simultaneously, we need a backup option in case we cannot implement it or lack the time to do so.

Here are the different choices:

- Keeping the same screen size but using different colors
- Having the same colors and sprite/image size as the original game but with a smaller maze
- Having the same colors and the same maze but decreasing the size of the sprites

I included as an attachment a comparison of the expected colors and modified colors for the first choice with the corresponding list of sprites.
The sprites for the third option would be reduced from 16 pixels to 10 pixels (almost a reduction of 50% size). We have not yet made any POC for those, but we can make one if you think it is necessary to make your decision.

Do not hesitate to reach out to me if you have any questions.
Have a nice day.

Yours sincerely.
Antoine PREVOST

## Attachments

![Spritesheet](../pictures/spritesheet.png)

![Selected colors](../pictures/selected_colors.png)

---

Date: `11/21/2023 5:00 PM`

From: `Franck JEANNIN (Client)`

To: `Antoine PREVOST (Program Manager)`

---

Hello Antoine,

I think you are confusing size with resolution. The size of the screen will be whatever monitor we connect to the PC. If we do it in the amphitheater, the “screen” might be 5 meters wide.

The only relevant questions are:

1) What is the actual resolution of the original arcade game
2) What are the resolutions available to you on a PC running DOS (VGA, SVGA, XGA, etc.)

Then you (or I) could pick the correct video mode to operate in.

Franck

---

Date: `11/21/2023 5:48 PM`

From: `Franck JEANNIN (Client)`

To: `Antoine PREVOST (Program Manager)`

---

Simple answer (I checked with Garry) is: go for MCGA.
You may have to make decisions about portrait versus landscape orientation once you run it on real hardware.

Franck

---

Date: `11/25/2023 2:49 PM`

From: `Antoine PREVOST (Program Manager)`

To: `Franck JEANNIN (Client)`

---

Hello Franck,

Thank you again for your answer. However, as you mentioned into the project channel on Slack, we can use the 32 bits registers which are, thanks to the tech lead information and research we have done, solving our problem of only one quarter of the screen displaying something because of an overflow. So we can stay in VGA, but we keep in mind a potential switch to MGCA is case of issues.

Have a nice weekend.

Yours sincerely.
Antoine PREVOST

---
