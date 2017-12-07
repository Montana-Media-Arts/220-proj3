// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Demonstration of the basics of motion with vector.
// A "Mover" object stores position, velocity, and acceleration as vectors
// The motion is controlled by affecting the acceleration (in this case towards the mouse)

import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

ArrayList<Face> faceList;

Rectangle[] faces;

int faceCount = 0;



int vidRez = 20;
float xScl;
float yScl;
int detectFrameFreq = 8;
boolean dataNew = false;
int drawFreq = 40;
Mover[] movers = new Mover[drawFreq*500];

void setup() {
    // size(640,360);
    fullScreen(1);
    video = new Capture(this, 16*vidRez, 9*vidRez, "FaceTime HD Camera");
    opencv = new OpenCV(this, 16*vidRez, 9*vidRez);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

    xScl = float(width) / float((16*vidRez));
    yScl = float(height) / float((9*vidRez));


    faceList = new ArrayList<Face>();

    video.start();


    for (int i = 0; i < movers.length; i++) {
        movers[i] = new Mover();
    }


    opencv.loadImage(video);
    detectFaces();


    background(0);
}

void draw() {

    println(frameRate);
    println(faceList.size());

    // if(frameCount%drawFreq == 0) {
    //     background(0, 0, 0);
    // } else {
        // background(0, 0, 0, 0);
        fill(0, 10);
        rect(0,0,width,height);
    // }
    noCursor();


    if( frameCount % detectFrameFreq == 0 ) {
        dataNew = true;
        opencv.loadImage(video);
        detectFaces();
    } else {
        dataNew = false;
    }


    // pushMatrix();
    // scale(xScl, yScl);
    // scale(-1, 1);
    // translate(-width/xScl, 0);
    // image(video, 0, 0 );
    // popMatrix();


    // Draw all the faces
    for (int i = 0; i < faces.length; i++) {
        noFill();
        strokeWeight(4);
        //rect(faces[i].x*scl,faces[i].y*scl,faces[i].width*scl,faces[i].height*scl);
        rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    }

    for (Face f : faceList) {
        strokeWeight(1);
        //comment out f.display to hide the face tracking box
        // f.display();
        f.updateForMovers();
    }


    int fnum = frameCount % drawFreq;
    for (int i = 0; i < movers.length; i++) {
        movers[i].update(faceList, dataNew);
        if(i%drawFreq == fnum) {
            movers[i].display();
        }
    }


}


void detectFaces() {

    // Faces detected in this frame
    faces = opencv.detect();

    // Check if the detected faces already exist are new or some has disappeared.

    // SCENARIO 1
    // faceList is empty
    if (faceList.isEmpty()) {
        // Just make a Face object for every face Rectangle
        for (int i = 0; i < faces.length; i++) {
            println("+++ New face detected with ID: " + faceCount);
            faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
            faceCount++;
        }

        // SCENARIO 2
        // We have fewer Face objects than face Rectangles found from OPENCV
    } else if (faceList.size() <= faces.length) {
        boolean[] used = new boolean[faces.length];
        // Match existing Face objects with a Rectangle
        for (Face f : faceList) {
            // Find faces[index] that is closest to face f
            // set used[index] to true so that it can't be used twice
            float record = 50000;
            int index = -1;
            for (int i = 0; i < faces.length; i++) {
                float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
                if (d < record && !used[i]) {
                    record = d;
                    index = i;
                }
            }
            // Update Face object location
            used[index] = true;
            f.update(faces[index]);
        }
        // Add any unused faces
        for (int i = 0; i < faces.length; i++) {
            if (!used[i]) {
                println("+++ New face detected with ID: " + faceCount);
                faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
                faceCount++;
            }
        }

        // SCENARIO 3
        // We have more Face objects than face Rectangles found
    } else {
        // All Face objects start out as available
        for (Face f : faceList) {
            f.available = true;
        }
        // Match Rectangle with a Face object
        for (int i = 0; i < faces.length; i++) {
            // Find face object closest to faces[i] Rectangle
            // set available to false
            float record = 50000;
            int index = -1;
            for (int j = 0; j < faceList.size(); j++) {
                Face f = faceList.get(j);
                float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
                if (d < record && f.available) {
                    record = d;
                    index = j;
                }
            }
            // Update Face object location
            Face f = faceList.get(index);
            f.available = false;
            f.update(faces[i]);
        }
        // Start to kill any left over Face objects
        for (Face f : faceList) {
            if (f.available) {
                f.countDown();
                if (f.dead()) {
                    f.delete = true;
                }
            }
        }
    }

    // Delete any that should be deleted
    for (int i = faceList.size()-1; i >= 0; i--) {
        Face f = faceList.get(i);
        if (f.delete) {
            faceList.remove(i);
        }
    }
}

void captureEvent(Capture c) {
    c.read();
}
