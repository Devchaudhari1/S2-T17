# S2-T17 </br>Digital dart board game with speed controller and scoreboard
<!-- First Section -->
## Team Details
S2 T17
<details>
  <summary>Detail</summary>

  > Semester: 3rd Sem B. Tech. CSE

  > Section: S2

  > Member-1:Dev Chaudhari , 231CS221 ,devchaudhari.231cs221@nitk.edu.in

  > member-2:Himanshu Bande, 231CS225 ,himanshubande.231cs225@nitk.edu.in

  > Member-3:Aryan         , 231CS213 ,aryan.231cs213@nitk.edu.in
</details>

<!-- Second Section -->
## Abstract
<details>
  <summary>Detail</summary>
 1. Motivation: A dart board game is not only a fun way to pass the time but also serves
as an engaging tool to develop various skills in individuals. The implementation of a Finite
State Machine (FSM)1 in the digital dart game serves as a robust framework to manage the
various states of gameplay efficiently. This game emphasizes precision and timing, making
it an excellent way to enhance focus and hand-eye coordination2. Through this project, we
aim to create a digital version of the classic dart game using innovative digital circuits. By
incorporating features like speed control and a dynamic scoreboard, players can easily track
their scores while experiencing a customizable level of challenge as the game progresses. This
adaptability adds an exciting layer of suspense and engagement to each round!</br>
2. Problem Statement:</br>
• The system must accept input signals that accurately represent dart throws on a virtual
dartboard.</br>
• The dartboard must feature a sufficiently large number of distinct target regions, with
the bullseye being the most challenging to hit.</br>
• Additionally, the game should introduce variations to increase difficulty, ensuring a stim-
ulating experience for players.</br>
• The scoreboard must effectively record game points over a wide range, avoiding overflow
to accommodate prolonged game play .</br>
• The overall objective is to develop a digital dart game that is both entertaining and
capable of accommodating multiple players while providing an intuitive and responsive
game play experience.</br>
3. Features:</br>• The dartboard utilizes an input signal from a dart throw, represented as a time-varying
pointer that periodically navigates among four concentric target regions, illuminated by
LEDs to indicate the pointer’s position.</br>
• The scoreboard can accurately record at least 20 throws without risk of overflow, ensuring
comprehensive tracking of player performance.</br>
• The dartboard includes a variable speed controller, allowing players to adjust the speed
at which the pointer changes position, enhancing the challenge.</br>
• The game is designed for up to three players, promoting friendly competition and social
interaction.</br>
• Penalty will be imposed on the player if the throw time limit is exceeded.</br>
</details>

<!-- Third Section -->
## Working
<details>
  <summary>Detail</summary>

  > ![image](https://github.com/Devchaudhari1/S2-T17/blob/main/Digital%20dartboard%20game%20modularized.drawio.png)
</details>

<!-- Fourth Section -->
## Logisim Circuit Diagram
<details>
  <summary>Detail</summary>


  >![S2_T17](https://github.com/user-attachments/assets/907e8224-7826-4289-886b-4003ec9c9218)
  >![S2_T17mainModule](https://github.com/user-attachments/assets/b9357933-9df0-4d41-a17d-bcc7260730eb)


</details>

<!-- Fifth Section -->
## Verilog Code
<details>
  <summary>Detail</summary>

  > Neatly update the Verilog code in code style only.
</details>


<!--Sixth Section-->
## References
<details>
 <summary>Detail</summary>

1. [Digital anti-windup PI controllers for variable-speed motor drives using FPGA and stochastic theory](https://ieeexplore.ieee.org/document/1640711) by Zhang, Dai; Li, Hui; Collins, Emmanuel G. Published in *IEEE Transactions on Power Electronics*, Volume 21, Issue 5, Pages 1496–1501, Year 2006.

2. [Real-time digital hardware simulation of power electronics and drives](https://ieeexplore.ieee.org/document/4130508) by Parma, Gustavo G; Dinavahi, Venkata. Published in *IEEE Transactions on Power Delivery*, Volume 22, Issue 2, Pages 1235–1246, Year 2007.
</details>
