/*
This is a sound file player. 
 */


import processing.sound.*;

SoundFile soundfile;
Stem[] stems = new Stem[2];

boolean[] isPlaying = new boolean[stems.length];

void setup() {
  size(640, 360);
  background(255);

  //Load a soundfile
  soundfile = new SoundFile(this, "vibraphon.aiff");
  stems[0] = new Stem( soundfile );

  soundfile = new SoundFile(this, "michael_musick.wav");
  stems[1] = new Stem( soundfile );  


  
}      


void draw() {
  for( int d=0; d<stems.length; d++ ) {
    stems[d].update();
  }
  
  //for( int d=0; d<isPlaying.length; d++ ) {
  //  isPlaying[d] = false;
  //}
  //for( Face f in faceList ) {
  // int idx = f.idx % stems.length;
  //  isPlaying[idx] = true; 
  //}
  
  //for( int d=0; d<isPlaying.length; d++ ) {
  //  if( isPlaying[d] ){
  //    stems[d].play();
  //  } else {
  //    stems[d].stop();
  //  }
  //}
 
}


void keyPressed() {
 if(key=='z'){
   stems[1].play();
 }
 if(key=='x'){
   stems[1].stop();
 }
 
 if(key=='a'){
   stems[0].play();
 }
 if(key=='s'){
   stems[0].stop();
 }
}