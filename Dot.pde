/**
Display representation of Dot with the objective of reaching the goal(s).
*/
class Dot{
 PVector pos;
 PVector vel;
 PVector acc;
 
 Brain brain;
 final int MAX_STEPS = 400;
 float fitness;
 
 Boolean dead;
 Boolean victory;
 
 /**
 Default Constructor: Spawns a Dot in the middle of the area with no vel and acc.
 */
 public Dot(){
  pos = new PVector(width/2, height-10);
  vel = new PVector(0,0);
  acc = new PVector(0,0);
  brain = new Brain(MAX_STEPS);
  dead = false;
  victory = false;
 }
 
 /**
 Moves the dot on every game tick if not dead.
 Kills the d.
 */
 public void move(Goal g){
   acc = brain.getCurrentDirection();
   if(acc == null)
     kill();
      
   if( !dead ){
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
   }
   
   if(pos.x < 2 || pos.x > width-2 || pos.y < 2 || pos.y > height-2)
     kill();
   if(dist(pos.x, pos.y, g.pos.x, g.pos.y) < 5){
     victory = true;
     kill();
   }
 }
 
 /**
 Kills the Dot.
 */
 public void kill(){
   dead = true;
 }
 
 /**
 Display the Dot to the screen.
 */
 public void display(){
  fill(0);
  ellipse(pos.x, pos.y, 4, 4);
 }
 
 public void calculateFitness(Goal g){
   if(victory){
     fitness = 1.0/16.0 +  10000.0/ (float) (brain.step * brain.step); // Higher fitness when less steps
   }
   else{
    float distance = dist(pos.x, pos.y, g.pos.x, g.pos.y); 
    fitness = 1.0/(distance * distance); // Higher fitness when less distance from goal
   }
 }
 
 public Dot cloneAndMutate(float mutationRate){
   Dot child = new Dot();
   child.brain = brain.cloneAndMutate(mutationRate);
   return child;
 }
 
}
