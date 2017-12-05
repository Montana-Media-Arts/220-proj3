import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.sound.*;

SoundFile soundfile;

void setup() {
 size(300,200);
 background(0);
 
 soundfile = new SoundFile(this, "Stem3_bitbugs.aif");
 
 soundfile.loop();
 
}


void draw(){
    // Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback 
  // speed 2 is an octave up 0.5 is an octave down.
  soundfile.rate(map(mouseX, 0, width, 0.25, 4.0)); 
  
  // Map mouseY from 0.2 to 1.0 for amplitude  
  soundfile.amp(map(mouseY, 0, width, 0.2, 1.0)); 
 
  // Map mouseY from -1.0 to 1.0 for left to right 
 // soundfile.pan(map(mouseY, 0, width, -1.0, 1.0)); 
}