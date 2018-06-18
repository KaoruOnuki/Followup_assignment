# Group Rock-Paper-Scissors (tournament style)  
Rock–Paper–Scissors is a hand game usually played between two people, in which each player simultaneously forms one of three shapes with their hands such as rock, paper or scissors.
This program is a tournament game of scissors-paper-rock. You will have a freedom to choose the number of players you wish to play with and the number of games in the tournament.
In each game, there is only one time the players choose their hands, and that result will be recorded. (There will be no win, loose or tie to be judged until all the games you have identified are played.)
The summary of all the games will show you how many wins, ties or loses each person had in the tournament.

## Requirements  
Group Rock-Paper-Scissors requires the following to run:
- ruby 2.3.1

## Usage  
Group Rock-Paper-Scissors is composed of four files of definitions of the methods and a single file to execute the game.

After downloading the ZIP, execute:
```
$ ruby play_group_rps.rb
```

## Description  
The number of games and players need to be chosen by you with any numbers.
You will then be asked to choose a number out of 0 - 2 to decide your hand for each game. Each number will represent a hand. (i.e. 0 for rock, 1 for scissors and 2 for paper)
The hands of other players will randomly be chosen for each game.
For the clarity of the game, the hands you have chosen and the computers’ hands will be displayed on the console.
The result of the games will automatically be calculated by the program, and the result of each game will be shown on the console.
Lastly, the summary of all the games will be announced as a result of the Rock_Paper_Scissors tournament.
It will be put together for each person to compare the number of wins, looses and ties.
