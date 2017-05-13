import queasycam.*;  

ArrayList<Box> boxes = new ArrayList<Box>();

color c[] = new color[3];

float pyramidSize = 1000, pyrMinimum = 20;
PVector acceleration, velocity, position;

QueasyCam cam;

void setup()
{
   c = new color[3];
   
   c[0] = color(0, 119, 129);
   c[1] = color(255, 143, 31);
   c[2] = color(33, 205, 144);
   c[2] = color(144,  255, 241);
  
  fullScreen(P3D);
  
  cam = new QueasyCam(this);  
  noCursor();
  cam.speed = 3;
  cam.sensitivity = 1;
  perspective(PI/3, (float)width/height, 0.01, 10000);
  stroke(255);
  
  boxes.add(new Box(0, 100, 0, 100, 10, 100, color(0,0,0,0)));
 
  fractal1(1000, 100, 100, 2000);
 
  acceleration = new PVector(0, 0.1, 0);
  velocity = new PVector(1,1,1);
  position = new PVector(1,1,1);
}

void draw()
{
  background(255);
  
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

void fractal1(float bassX, float bassY, float bassZ, float size)
{
  float scale = size;
   
  boxes.add(new Box(bassX, bassY, bassZ, size, size, size, c[int(random(-1,3))]));
  
  size /= 2;
  
  if (size > 200)
  {
    fractal1(bassX + (size*2), 
    bassY +(random(-size/2, size/2)), bassZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(bassX - (size*2), 
    bassY +(random(-size/2, size/2)), bassZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(bassX +(random(-size/2, size/2)),
    bassY + (size*2), bassZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(bassX +(random(-size/2, size/2)),
    bassY - (size*2), bassZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(bassX +(random(-size/2, size/2)),
    bassY +(random(-size/2, size/2)), bassZ + (size*2), 
    size);
    
    fractal1(bassX +(random(-size/2, size/2)),
    bassY  +(random(-size/2, size/2)), bassZ - (size*2),
    size);
  }
}