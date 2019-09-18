class Population{
  Dot[] pop;
  Goal goal;
  int best;
  int generation = 1;
  int minStep = 400;
  
  public Population(int size, Goal g){
   pop = new Dot[size]; 
   populate();
   goal = g;
  }
  
  
  /**
  Populates the population with Dots.
  */
  public void populate(){
    for(int i = 0; i < pop.length; i++){
     pop[i] = new Dot(); 
    }
  }
  
  /**
  Displays each Dot in the population.
  */
  public void displayAll(){
   for(int i = 0; i < pop.length; i++){
    pop[i].display(); 
   }
   // Display the best dot as blue
   fill(0, 0, 255);
   ellipse(pop[best].pos.x, pop[best].pos.y, 8, 8);
  }
  
  /**
  Moves each Dot in the population.
  */
  public void moveAll(){
   for(int i = 0; i < pop.length; i++){
    pop[i].move(goal); 
   }
  }
  
  public void calculateFitnesses(){
    for(int i = 0; i < pop.length; i++){
      pop[i].calculateFitness(goal); 
   }
  }
  
  public Boolean allDead(){
    for(int i = 0; i < pop.length; i++){
      if (pop[i].dead == false)
        return false;
   }
   return true;
  }
  
  public void naturalSelection(){
    Dot[] children = new Dot[pop.length];
    float fitnessSum = calculateFitnessSum(); // To be used to select a parent and find best dot
    children[0] = new Dot(); // Force pass the best dot
    children[0].brain = pop[best].brain;
    if(children[0].victory)
      minStep = children[0].brain.step; // Minimize steps taken
    children[0].brain.step = 0;
    for(int i = 1; i < pop.length; i++){
      // Select a fit parent
      Dot parent = selectParent(fitnessSum);
      children[i] = parent.cloneAndMutate(.04);
    }
    pop = children;
    generation++;
  }
  
  public float calculateFitnessSum(){
    float sum = 0;
    float highestFitness = 0;
    for(int i = 0; i < pop.length; i++){
      sum += pop[i].fitness;
      if(pop[i].fitness > highestFitness){
       best = i;
       highestFitness = pop[i].fitness;
      }
   }
   return sum;
  }
  
  public Dot selectParent(float fitnessSum){
    // Generate a number that has to be passed; a bar to be passed
    float bar = random(fitnessSum);
    
    // Build the bar gradually; larger contributions have a higher chance to be picked without shunning
    // the smaller contributions.
    float currentSum = 0;
    for(int i = 0; i < pop.length; i++){
     currentSum += pop[i].fitness;
     if(currentSum >= bar)
       return pop[i];
    }
    
    return null; // Should not reach this point
  }
  
}
