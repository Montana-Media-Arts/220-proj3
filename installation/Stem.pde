class Stem {
    SoundFile soundfile;
    int amp = 0;
    int desiredAmp = 0;
    int ampDelta = 1;
    boolean isPlaying = false;

    Stem( SoundFile sf ) {
        soundfile = sf;

        soundfile.loop();
        soundfile.amp(amp/100);
    }

    void play() {
        //soundfile.amp(1.0);
        desiredAmp = 100;
        isPlaying = true;

    }

    void stop() {
        //soundfile.amp(0.0);
        desiredAmp = 0;
        isPlaying = false;
    }

    void update() {
        if( desiredAmp != amp ) {
            if( amp < desiredAmp ) {
                amp = amp + ampDelta;
            } else if ( amp > desiredAmp ) {
                amp = amp - ampDelta;
            }
        }

        // println(amp);
        soundfile.amp(float(amp)/100.0);
    }
}




// POSSIBLE THINGS
// Map mouseX from 0.25 to 4.0 for playback rate. 1 equals original playback
// speed 2 is an octave up 0.5 is an octave down.
//soundfile.rate(map(mouseX, 0, width, 0.25, 4.0));

//// Map mouseY from 0.2 to 1.0 for amplitude
//soundfile.amp(map(mouseY, 0, width, 0.2, 1.0));

//// Map mouseY from -1.0 to 1.0 for left to right
//soundfile.pan(map(mouseY, 0, width, -1.0, 1.0));
