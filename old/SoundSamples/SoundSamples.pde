/*
This is a sound file player. 
 */


import processing.sound.*;

SoundFile soundfile;
Stem[] stems = new Stem[4];

boolean[] isPlaying = new boolean[stems.length];

void setup() {
  size(640, 360);
  background(255);

  //Load a soundfile
  soundfile = new SoundFile(this, "Stem3_bitbugs.aif");
  stems[0] = new Stem( soundfile );

  soundfile = new SoundFile(this, "Stem4_Icefield.aif");
  stems[1] = new Stem( soundfile );  
  
  soundfile = new SoundFile(this, "Stem5_bells.aif");
  stems[2] = new Stem( soundfile ); 
 
  soundfile = new SoundFile(this, "Stem6_arp.aif");
  stems[3] = new Stem( soundfile ); 

  
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
 if(key=='1'){
   stems[0].play();
 }
 if(key=='2'){
   stems[0].stop();
 }
 
 if(key=='q'){
   stems[1].play();
 }
 if(key=='w'){
   stems[1].stop();
 }
  if(key=='a'){
   stems[2].play();
 }
 if(key=='s'){
   stems[2].stop();
 }
 
 if(key=='z'){
   stems[3].play();
 }
 if(key=='x'){
   stems[3].stop();
 }
}