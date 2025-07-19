; Author: Chelsea Gemza
; Date: November 20, 2022
; Title: Lab10: Advanced Ecosystem
; Course Number: CSCI 1108
; Course Title: CS for All: Introduction to Computer Modeling

globals
[
  starting_energy   ;Energy for fish
  starting_energyShark   ;Energy for shark
]


breed
[
  fishes fish  ; Create a new breed where the plural is fishes and the singular is fish
]
breed
[
  sharks shark  ; Create a new breed for the shark
]

fishes-own
[
  energy ; creates variable for fish energy
  fishAge
]

sharks-own
[
  sharkEnergy  ;creates variable for shark energy
  sharkAge
]

to setup   ; sets up the interface, fish, and initial plankton
  clear-all
  reset-ticks
  ask patches
  [
    set pcolor 107 ;background color is a shade of blue
  ]
  repeat 100 ;repeats the below 100 times to make 100 green patches
  [
    ask patch random-pxcor random-pycor   ;asks random patch
    [
      set pcolor green   ;to set to the color green, represents plankton
    ]
  ]

  set starting_energy 150 ;initializes this global value

  set-default-shape fishes "fish" ;set here so when breeds,the baby will hatch as a fish

  create-fishes Number_Of_Fish ;this is set by the slider on the interface
  [
    setxy random-xcor random-ycor
    set color orange
    set size 1
    set energy starting_energy
  ]

  set starting_energyShark 200  ;establishes shark starting energy higher than the fish

  set-default-shape sharks "fish"

  create-sharks Number_Of_Shark   ;creates sharks based on the number on the slider
  [
    set size 3
    set color grey
    set sharkEnergy starting_energyShark
  ]
end

to go  ;the go procedure calls all of the sub procedures listed below

 ask fishes
  [
  move
  eat
  reproduce
  checkDie
  fishAging
  ]


  ask sharks
  [
  sharkMove
  sharkEat
  sharkReproduce
  sharkCheckDie
  sharkAging
  ]

  growPlankton

  tick
end

to move ;asks the fish to move
  ask fishes
  [
    if (energy > 0)   ;fish energy is greater than zero
    [
    left random 91    ;wiggle walk
    right random 91
    forward 10
    set energy energy - 10  ;every tick, a fish looses energy
    ]
  ]
end

to eat ;the procedure for the fish to eat and gain energy
    ask fishes
  [
    if ([pcolor] of patch-ahead 0 = green)  ;the fish eats plankton and gains energy
      [
        set energy energy + 10  ;adds energy from eating
        set pcolor 107 ;the patch is set back to blue
      ]
  ]

end

to reproduce ;the procedure to hatch a new fish if energy level is high enough
  ask fishes
  [
    if energy > 50
    [
      set energy energy - 90
      hatch 1
      [
        set energy starting_energy
        forward 15
      ]
    ]
  ]
end

to checkDie ;the procedure to check if fish has no energy and will die
  ask fishes
  [
    if energy <= 0
    [die]
  ]
end

to fishAging   ;the fish grow in size as they age
  ask fishes
  [
    if (size < 4)
    [set size size + .5]
  ]
end


to growPlankton ;the procedure to grow additional plankton as green patches
 ask patches
  [
  if (random 1000 < 1) ;a probability of 1 in 1000 at each tick
  [
 ask patch random-pxcor random-pycor   ;asks random patches
    [
      set pcolor green   ;to set to the color green, represents plankton
    ]
  ]
  ]
end

to sharkMove  ;the procedure that makes the sharks move
    ask sharks
  [
    if (sharkEnergy > 0)   ;shark energy is greater than zero
    [
    left random 91    ;wiggle walk
    right random 91
    forward 10
    set sharkEnergy sharkEnergy - 20  ;every tick, a shark looses energy
    ]
  ]
end

to sharkReproduce  ;the procedure where sharks reproduce
    ask sharks
  [
    if sharkEnergy > 50
    [
      set sharkEnergy sharkEnergy - 138
      hatch 1
      [
        set sharkEnergy starting_energyShark
        forward 15
      ]
    ]
  ]
end

to sharkCheckDie ;the procedure to check if shark has no energy and will die
  ask sharks
  [
    if sharkEnergy <= 0
    [
      die
    ]
  ]
end

to sharkAging  ;the sharks get bigger as they age
     ask sharks
  [
    if (size < 6)
    [set size size + .5]
  ]
end

to sharkEat  ;the procedure for a shark to eat a fish and gain energy
  ask sharks
  [
  if (any? fishes-on patch-here)
  [
  set sharkEnergy sharkEnergy + 20
  ]
  ask fishes-here
  [
    die
  ]
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
821
622
-1
-1
3.0
1
10
1
1
1
0
1
1
1
-100
100
-100
100
0
0
1
ticks
30.0

BUTTON
21
35
85
68
NIL
Setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
113
36
176
69
NIL
Go\n
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
32
109
204
142
Number_Of_Fish
Number_Of_Fish
0
100
97.0
1
1
NIL
HORIZONTAL

MONITOR
63
421
141
466
Fishes Alive
count fishes
17
1
11

PLOT
6
258
206
408
Ecosystem
Time
Totals
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"fishes" 1.0 0 -955883 true "" "plot count fishes"
"planktons" 1.0 0 -14439633 true "" "plot count patches with [pcolor = green]"
"sharks" 1.0 0 -7500403 true "" "plot count sharks"

SLIDER
32
165
204
198
Number_Of_Shark
Number_Of_Shark
0
100
10.0
1
1
NIL
HORIZONTAL

MONITOR
62
473
142
518
Sharks Alive
count sharks
17
1
11

MONITOR
146
443
206
488
Plankton
count patches with [pcolor = green]
17
1
11

@#$#@#$#@
## WHAT IS IT?

This model shows an ecosystem of fish, sharks, and plankton over time.

## HOW IT WORKS

The set-up button will generate fish. The background is set to blue and any green patches represent plankton. As the fish eat plankton, they gain energy. As they move, they lose energy. When they reproduce they hatch one additional fish that inherits the same traits as the parent. The parent then loses energy. The sharks eat the fish and gain energy. They also move and reproduce, which causes them to lose energy. Both fishes and sharks die when they do not have enough energy.

Setting the Number_Of_Fish slider to 97 amd the Number_Of_Shark slider to 10 results in a stable population that contains plankton, sharks, and fish alive after 5,000 ticks.

## HOW TO USE IT
The user can use the slider on the interface to set the starting amount of fish. Clicking the set-up button will generate the fish and sharks randomly on the screen as well as the random location of 100 patches of green that represent plankton. Pressing go, the fish and sharks will wiggle walk forward. Fish will gain energy if they come across a green patch, which will then turn back to blue. Sharks will gain energy if they come across a fish, then the fish dies. As long as they both have enough energy, they will reproduce. Once then no longer have enough energy, they die. The shark slider on the interface sets the amount of starting sharks.

## THINGS TO NOTICE
The slider changes the amount of starting fish andsharks. The graph shows the relationship between the number of fish, sharks, and the plankton at any given time.

## THINGS TO TRY
Changing the values of the cost to reproduce, amount of energy a fish or shark gets when eating, and starting number, for example, will yield different results. Too many fish or sharks and not enough plankton will lead to fish or sharks dying off. Too much plankton will result in a green screen but the fish population does not produce enough to grow the population at a higher rate, despite the additional food.

## EXTENDING THE MODEL
To expand the model the fish and sharks could have a variable that tracks their age after a number of ticks. Once they reach "old age", they would die.

## NETLOGO FEATURES

This interface includes monitors and a plot that graphs the relationship over time.

## RELATED MODELS

https://ccl.northwestern.edu/netlogo/models/WolfSheepPredation

## CREDITS AND REFERENCES
https://ccl.northwestern.edu/netlogo/docs/tutorial3.html
http://ccl.northwestern.edu/netlogo/docs/dict/turtles-on.html
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
