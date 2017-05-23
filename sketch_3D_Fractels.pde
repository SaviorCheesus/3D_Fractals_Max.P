import queasycam.*;  

ArrayList<Box> boxes = new ArrayList<Box>();
color c[] = new color[4];

float FOV;
PVector acceleration, velocity, position;

QueasyCam cam;

void setup()
{
  c[0] = color(255, 34, 0);
  c[1] = color(255, 0, 98);
  c[2] = color(0);
  c[2] = color(185, 67, 113);
  c[3] = color(142,  53, 79);
  
  acceleration = new PVector(0, 0.1, 0);
  velocity = new PVector(1,1,1);
  position = new PVector(1,1,1);
    
  fullScreen(P3D);
  noCursor();
  noStroke();
  
  FOV = PI;
  
  cam = new QueasyCam(this);  
  cam.speed = 3;
  cam.sensitivity = 1;
  perspective(FOV/3, (float)width/height, 0.01, 10000);  
  
  boxes.add(new Box(0, -10000, 0, 100, 10, 100, color(0,0,0,0)));
 
 
  //cantorSet(1,1,1,1000, 100);
  //tree(1,1,1,100);
  mengerSponge(1,1,1,1000);
}

void draw()
{
  background(255,205,0);
  
  view();
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

void fractal1(float baseX, float baseY, float baseZ, float size)
{
  boxes.add(new Box(baseX, baseY, baseZ, size, size, size, c[int(random(-1,4))]));
  
  size /= 2;
  
  if (size > 200)
  {
    fractal1(baseX + (size*2), 
    baseY +(random(-size/2, size/2)), baseZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(baseX - (size*2), 
    baseY +(random(-size/2, size/2)), baseZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(baseX +(random(-size/2, size/2)),
    baseY + (size*2), baseZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(baseX +(random(-size/2, size/2)),
    baseY - (size*2), baseZ +(random(-size/2, size/2)), 
    size);
    
    fractal1(baseX +(random(-size/2, size/2)),
    baseY +(random(-size/2, size/2)), baseZ + (size*2), 
    size);
    
    fractal1(baseX +(random(-size/2, size/2)),
    baseY  +(random(-size/2, size/2)), baseZ - (size*2),
    size);
  }
}


void fractal2(float baseX, float baseY, float baseZ, float size)
{
  boxes.add(new Box(baseX, baseY, baseZ, size, size, size, c[int(random(-1,4))]));
  
  size /= 2;
  
  if (size > 50)
  {
    fractal2(baseX + (size), 
    baseY + (size), baseZ -(size), 
    size);
    
    fractal2(baseX + (size), 
    baseY - (size), baseZ -(size), 
    size);
    
    fractal2(baseX + (size), 
    baseY + (size), baseZ +(size), 
    size);
    
    fractal2(baseX + (size), 
    baseY - (size), baseZ +(size), 
    size);
  }
}

void fractal3(float baseX, float baseY, float baseZ, float stanSize, float varSize, int dir)
{   
  color p = c[int(random(-1,4))];
  
  boxes.add(new Box(baseX, baseY, baseZ +varSize*10, varSize*20, stanSize*4, stanSize, p));
  boxes.add(new Box(baseX, baseY, baseZ -varSize*10, varSize*20, stanSize*4, stanSize, p));
  boxes.add(new Box(baseX +varSize*10, baseY, baseZ, stanSize, stanSize*4, varSize*20, p));
  boxes.add(new Box(baseX -varSize*10, baseY, baseZ, stanSize, stanSize*4, varSize*20, p));
  
  varSize /= 1.1;
  
  if (varSize > 20)
  {
    fractal3(baseX, baseY + stanSize*4*dir, baseZ, stanSize, varSize, dir);
  }
}

void cantorSet(float baseX, float baseY, float baseZ, float varSize, float stanSize)
{
  color p = c[int(random(-1,4))];
  
  boxes.add(new Box(baseX, -baseY, baseZ, varSize/10, varSize/10, varSize*2, p));
  
  varSize /= 3;
  
  if (varSize > 1)
  {
  cantorSet(baseX + varSize, baseY, baseZ -varSize*2, varSize, stanSize);  
  cantorSet(baseX + varSize, baseY, baseZ +varSize*2, varSize, stanSize);
  }
}

void tree(float baseX, float baseY, float baseZ, float size)
{
  color p = c[int(random(-1,4))];
  
  boxes.add(new Box(baseX, baseY, baseZ, size, size*10, size, p));
  boxes.add(new Box(baseX -size*4, baseY -size*6, baseZ, size*6, size, size, p));
  boxes.add(new Box(baseX +size*4, baseY -size*6, baseZ, size*6, size, size, p));
  boxes.add(new Box(baseX, baseY -size*6, baseZ -size*4, size, size, size*6, p));
  boxes.add(new Box(baseX, baseY -size*6, baseZ +size*4, size, size, size*6, p));
  
  if(size > 50)
  {
    tree(baseX - size*6, baseY -size*11, baseZ, size*random(0.5, 0.9));
    tree(baseX + size*6, baseY -size*11, baseZ, size*random(0.5, 0.9));
    tree(baseX, baseY -size*11, baseZ - size*6, size*random(0.5, 0.9));
    tree(baseX, baseY -size*11, baseZ + size*6, size*random(0.5, 0.9));
  }
}

void mengerSponge(float baseX, float baseY, float baseZ, float size)
{
  color p = c[int(random(-1,4))];
  
  
  if (size < 300)
  {
    for(int x = -1; x < 2; x++)
    {
      for (int y = -1; y < 2; y++)
      {
        for (int z = -1; z < 2; z++)
        {
           if((x == 0 && y == 0) || (y == 0 && z == 0) || (z == 0 && x == 0))
           {
           
           }
           else
           {
             boxes.add(new Box(baseX +(size*x), baseY +(size*y), baseZ+(size*z),
                             size, size, size, p));
           }
        }
      }
    }
  }
  else
  {
    size /= 3;

    mengerSponge(baseX +(size*3), baseY -(size*3), baseZ -(size*3), size);
    mengerSponge(baseX, baseY -(size*3), baseZ -(size*3), size);
    mengerSponge(baseX -(size*3), baseY -(size*3), baseZ -(size*3), size);
    
    mengerSponge(baseX +(size*3), baseY -(size*3), baseZ, size);
    mengerSponge(baseX -(size*3), baseY -(size*3), baseZ, size);
    
    mengerSponge(baseX +(size*3), baseY -(size*3), baseZ +(size*3), size);
    mengerSponge(baseX, baseY -(size*3), baseZ +(size*3), size);
    mengerSponge(baseX -(size*3), baseY -(size*3), baseZ +(size*3), size);
    
    
    
    mengerSponge(baseX +(size*3), baseY, baseZ +(size*3), size);
    mengerSponge(baseX -(size*3), baseY, baseZ +(size*3), size);
    
    mengerSponge(baseX +(size*3), baseY, baseZ -(size*3), size);
    mengerSponge(baseX -(size*3), baseY, baseZ -(size*3), size);
    
    
    mengerSponge(baseX +(size*3), baseY +(size*3), baseZ -(size*3), size);
    mengerSponge(baseX, baseY +(size*3), baseZ -(size*3), size);
    mengerSponge(baseX -(size*3), baseY +(size*3), baseZ -(size*3), size);
    
    mengerSponge(baseX +(size*3), baseY +(size*3), baseZ, size);
    mengerSponge(baseX -(size*3), baseY +(size*3), baseZ, size);
    
    mengerSponge(baseX +(size*3), baseY +(size*3), baseZ +(size*3), size);
    mengerSponge(baseX, baseY +(size*3), baseZ +(size*3), size);
    mengerSponge(baseX -(size*3), baseY +(size*3), baseZ +(size*3), size);
  }
}

void view()
{
  if (keyPressed == true && key == 'w')
  {
    if (FOV < 1.1*PI) FOV += 0.05;
  }
  else
  {
    if (FOV > PI) FOV -= 0.05;
  }

  perspective(FOV/3, (float)width/height, 0.01, 10000);  
}