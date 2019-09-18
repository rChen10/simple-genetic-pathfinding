class Goal{
 PVector pos;
 
 public Goal(int x, int y){
  pos = new PVector(x,y);
 }
 
 public void display(){
  fill(0, 255, 0);
  ellipse(pos.x, pos.y, 8, 8);
 }
}
