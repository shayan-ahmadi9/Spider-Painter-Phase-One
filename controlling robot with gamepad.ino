/*
 * Code to control two stepper motors simultaneously using the stepper library function calls
 * This code has functions which make calls to initiate one step from each of the two motors at a time
 * therefore each motor takes it in turn to step with the end result of them both running together
 * the variable 'lastCall' allows for a continuous input to keep the steppers running if there is no serial input
 * Written by Seven Vinton - March 2016 - available and free to use and distribute in the public domaidn.
 */
#include <Stepper.h>
#include <AFMotor.h>
#include <Servo.h>


Servo servo1;
int servoWritingPos = 120;
int servoPassingPos = 80;
#define  COMMAND_WRITING  'z'
#define  COMMAND_PASSING  'o'


//definitions for each command to be recieved via serial port
#define COMMAND_LEFT 'a'
#define COMMAND_RIGHT 'd'
#define COMMAND_UP 'w'
#define COMMAND_DOWN 's'
#define COMMAND_STOP 'q'

#define COMMAND_NORTHWEST '7'
#define COMMAND_NORTHEAST '9'
#define COMMAND_SOUTHWEST '1'
#define COMMAND_SOUTHEAST '3'

//enter the steps per rev for your motors here
int stepsPerRevolution = 200;
int delayTime = 10;

//this sets the value for the for loops and therefore sets the amount of steps in each call
int num_of_steps = 1;
// connect motor to port #1 (M1 and M2)
// connect motor to port #2 (M3 and M4)
AF_Stepper myStepper1(stepsPerRevolution, 1);
AF_Stepper myStepper2(stepsPerRevolution, 2);
// variable to store the last call to the serial port
char lastCall = 'q';


//to move the motors up
void moveUp(int steps){
  Serial.println("up");
  // step one step each up
  myStepper1.step(1, FORWARD, DOUBLE);
  myStepper2.step(1, FORWARD, DOUBLE);
  delay(delayTime);
}

// to move the motors back
void moveDown(int steps){
  Serial.println("down");
  // step one step each down
  myStepper1.step(1, BACKWARD, DOUBLE);
  myStepper2.step(1, BACKWARD, DOUBLE);
  delay(delayTime);
}
 

// to move the motors in opposite directions (left)
void moveLeft(int steps){
  Serial.println("left");
 // step one step each left
  myStepper1.step(1, FORWARD, DOUBLE);
  myStepper2.step(1, BACKWARD, DOUBLE);
  delay(delayTime);
}


// to move the motors in opposite directions (right)
void moveRight(int steps){
  Serial.println("right");
  // step one step each right
  myStepper1.step(1, BACKWARD, DOUBLE);
  myStepper2.step(1, FORWARD, DOUBLE);
  delay(delayTime); 
}


void moveNorthEast(int steps){
  Serial.println("NorthEast");
  // step one step each right
  myStepper1.step(1, BACKWARD, DOUBLE);
  //myStepper2.step(1, FORWARD, DOUBLE);
  delay(delayTime); 
}


void moveSouthEast(int steps){
  Serial.println("SouthEast");
  // step one step each right
  //myStepper1.step(1, BACKWARD, DOUBLE);
  myStepper2.step(1, FORWARD, DOUBLE);
  delay(delayTime); 
}

void moveNorthWest(int steps){
  Serial.println("NorthWest");
 // step one step each left
  //myStepper1.step(1, FORWARD, DOUBLE);
  myStepper2.step(1, BACKWARD, DOUBLE);
  delay(delayTime);
}

void moveSouthWest(int steps){
  Serial.println("SouthWest");
 // step one step each left
  myStepper1.step(1, FORWARD, DOUBLE);
  //myStepper2.step(1, BACKWARD, DOUBLE);
  delay(delayTime);
}


// to power down the motor drivers and stop the motors
void allStop(){
  Serial.println("stop");
  // steppers stop
  //PORTD = B00000000; //sets all of the pins 0 to 7 as LOW to power off stepper1
  //PORTB = B00000000; //sets all of the pins 8 to 13 as LOW to power off stepper2

  myStepper1.step(0, BACKWARD, DOUBLE);
  myStepper2.step(0, FORWARD, DOUBLE);

}

void passing(){
  
    //for(int i = servoWritingPos; i >= servoPassingPos; i--){
      servo1.write(servoPassingPos);
      delay(25);
    //}
}

void writing(){
  
    //for(int i = servoPassingPos; i <= servoWritingPos; i++){
      servo1.write(servoWritingPos);
      delay(25);
    //}
}


void setup() {
  Serial.begin(9600);//start the bluetooth serial port - send and recieve at 9600 baud
  // set the speed at 60 rpm:
  myStepper1.setSpeed(120);
  myStepper2.setSpeed(120);

  servo1.attach(10);
}

void loop() {
//check to see if there is serial communication and if so read the data
if(Serial.available()) {
char data = (char)Serial.read();
// switch to set the char via serial to a command
switch(data) {
  case COMMAND_DOWN:
    moveUp(num_of_steps);
    break; 
  case COMMAND_UP:
    moveDown(num_of_steps);
    break;
  case COMMAND_LEFT:
    moveLeft(num_of_steps);
    break;
  case COMMAND_RIGHT:
    moveRight(num_of_steps);
    break;
  case COMMAND_NORTHWEST:
    moveNorthWest(num_of_steps);
    break;
  case COMMAND_NORTHEAST:
    moveNorthEast(num_of_steps);
    break;
  case COMMAND_SOUTHWEST:
    moveSouthWest(num_of_steps);
    break;
  case COMMAND_SOUTHEAST:
    moveSouthEast(num_of_steps);
    break;   
  case COMMAND_STOP:
    allStop();
    break;
  case COMMAND_WRITING:
    writing();
    break;
  case COMMAND_PASSING:
    passing();
    break;  

}
// set the 'lastCall' variable to the last call from the serial
lastCall = data;
}
else{
char data = lastCall;
switch(data) {
  case COMMAND_DOWN:
    moveUp(num_of_steps);
    break; 
  case COMMAND_UP:
    moveDown(num_of_steps);
    break;
  case COMMAND_LEFT:
    moveLeft(num_of_steps);
    break;
  case COMMAND_RIGHT:
    moveRight(num_of_steps);
    break;
  case COMMAND_NORTHWEST:
    moveNorthWest(num_of_steps);
    break;
  case COMMAND_NORTHEAST:
    moveNorthEast(num_of_steps);
    break;
  case COMMAND_SOUTHWEST:
    moveSouthWest(num_of_steps);
    break;
  case COMMAND_SOUTHEAST:
    moveSouthEast(num_of_steps);
    break;
  case COMMAND_STOP:
    allStop();
    break;
  case COMMAND_WRITING:
    //writing();
    break;
  case COMMAND_PASSING:
    //passing();
    break;
}
lastCall = data;
}
}
