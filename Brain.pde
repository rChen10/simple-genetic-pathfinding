/**
Controller of a Dot's path.
*/
class Brain{
  PVector[] directions;
  int step;
  
  public Brain(int size){
    directions = new PVector[size]; 
    randomize();
    step = 0;
  }
  
  /**
  Fill directions with random PVectors.
  */
  public void randomize(){
    for(int i = 0; i < directions.length; i++){
      float angle = random(2 * PI); // bound 0 to 2pi
      directions[i] = PVector.fromAngle(angle);
    }
  }
 
 
  public PVector getCurrentDirection(){
    if(step == directions.length)
      return null;
    step++;
    return directions[step-1];
  }
  
  public Brain cloneAndMutate(float mutationRate){
   Brain clone = new Brain(directions.length);
   
   for(int i = 0; i < directions.length; i++){
     if( random(1) > mutationRate) // new Brain already has new dirs, so not overwriting is mutating
      clone.directions[i] = directions[i]; 
   }
   return clone;
  }
}
