Population test;
Goal goal;

void setup(){
  size(800, 800);
  goal = new Goal(400, 10);
  test = new Population(100, goal);
}

void draw(){
  background(255);
  if(test.allDead()){
    test.calculateFitnesses();
    test.naturalSelection();
  }
  else{
    test.moveAll();
    goal.display(); // display goal below dots
    test.displayAll();
    
    
    fill(0, 0, 0);
    textSize(20);
    text("Generation " + test.generation, 10, height - 30); 
  }
}
