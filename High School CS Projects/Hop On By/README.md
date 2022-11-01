# Hop On By
#### Video Demo:  https://youtu.be/lUELBoKsCLc <br><br>
<div align="center"> <h3>Description:</h3></div>
My project is a game created using the Lua language and Love2D framework. It features a little dino runner (velociraptor) that seeks to jump over tons of cacti to reach a defined endpoint.

The game is mostly coded in an object oriented approach and divides the Map, Dino, Animations and (a) Util (function).

**Main.lua** <br>
The purpose of main.lua is primarily to run the functions made available by the Map and Dino objects. In addition to this, the file is responsible for resetting the game on loss, keeping track of counters like score, managaing a simple victory sound and drawing/printing info to the screen.

Additionally, it also keeps track of simple collision detection with any cactus (the enemy).

**Util.lua**<br>
This file mainly exists to facilitate the retrieval of individual sections of the multiple spritesheets that were used to draw entities into the game.

**Map.lua**<br>
Map.lua is the brains behind the map generation. The map is broken up into individual tiles with defined length and width to allow for a list (in a table) to account for each tile in 2D space. The file consists of callable functions for the process of updating and rendering the Map through the main.lua file as well as keeping track of the necessary movement of the camera so that the sprite remains visible.

Various tiles from the Amiga Amiga 32 spritesheet were used to procedurally generate the map. Cacti and even the stars were generated randomly through vertical scanlines. I have also set a value for gravity and walled the dinosaur so that the edge of the map is invisible and immersion is better preserved.

**Dino.lua**<br>
Dino.lua houses the Dino object, which controls aspects related to the player and the velociraptor's movement. It takes the input of the user and redraws the position of the dino sprite accordingly (which the camera follows).

The file also hosts the flag, which appears at the victory x-coordinate each time and allows for victory to be marked upon contact.

In fact, this file also stores the behaviours of the of the dinosaur, which include idling, movement and jumping.
This is coupled with a simple state machine that contains the same and facilitates the responsive animations of the dino in each behaviour.

**Animations.lua**<br>
Animations.lua is also a majorly supportive file for the rotation of animations based on the state and behaviour in Dino.lua. It takes a list of quads and rotates through all of them with a defined interval so that movement is generated.

**General**<br>
The dino is controlled through the arrow keys (all but down) and the spacebar can optionally be used to jump much higher.

This game also keeps track of the best score (shortest time) and has a short victory roar. THere are also three messages marking passage in the level and a 2.5 second cooldown period to reset after victory that felt perfectly long enough to mark completion and provide a moment's respite.

The difficulty is arguably rather high and can be adjusted very easily by changing the boundaries of the math.random function in the Map.lua file. Keybinds have been attached to 'e' (easy), 'n' (normal) and 'h' (hard) for the same.
<br><br><br>
*Credits:* <br>
- Zapsplat for the dinosaur audio
- Spritesheet creators from The Spriters' Resource