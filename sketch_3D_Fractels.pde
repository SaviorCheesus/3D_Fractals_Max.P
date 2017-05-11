import queasycam.*;

ArrayList<Box> boxes = new ArrayList<Box>();

color bass = color(255,255,255), pop = color(255,0,0,0);
float pyramidSize = 1000, pyrMinimum = 20;
PVector acceleration, velocity, position;

QueasyCam cam;

void setup()
{
  fullScreen(P3D);
  
  cam = new QueasyCam(this);  
  noCursor();
  cam.speed = 3;
  cam.sensitivity = 1;
  perspective(PI/3, (float)width/height, 0.01, 10000);
  stroke(255);
  
  boxes.add(new Box(1000, 0, 0, 10, 10, 10, bass));
  boxes.add(new Box(0, 100, 0, 100, 10, 100, pop));
 
  sirpinskisPyramid(100,100,100,100);
 
  acceleration = new PVector(0, 0.1, 0);
  velocity = new PVector(1,1,1);
  position = new PVector(1,1,1);
}

void draw()
{
  background(0);
  
  physics();
  
  for (int i = 0; i < boxes.size(); i++)
  {
    Box object = boxes.get(i);
    
    object.Display();
  }
}

void physics()
{
  if(keyPressed == true && key == ' ')
  {
    acceleration.y = acceleration.y * 0;
    velocity.y = velocity.y * 0;
    acceleration.y = -10;
  }
  else
  {
    acceleration.y = 1;
  }
   
  velocity.add(acceleration);
  position.add(velocity);
  cam.position.y = position.y; 
}

void sirpinskisPyramid(float bassX, float bassY, float bassZ, float size)
{
  float scale = size;
  
  boxes.add(new Box(bassX, bassY, bassZ, 100, 100, 100, pop));
  boxes.add(new Box(bassX + (scale*2), bassY, bassZ, 100, 100, 100, pop));
  boxes.add(new Box(bassX + scale, bassY -scale, bassZ, 100, 100, 100, pop));
  
  size *= 2;
  if (scale < 200)
  {
    sirpinskisPyramid(bassX + (scale*4), bassY, bassZ, scale);
  }
}