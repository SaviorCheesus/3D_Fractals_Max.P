class Box
{
  float _x, _y, _z, _depth, _vertical, _horizontal;
  public boolean _colide;
  color _colour;
  
  Box(float x, float y, float z, 
  float depth, float vertical, float horizontal,
  color colour,
  boolean colide)
  {
    _x = x;
    _y = y;
    _z = z;
    
    _depth = depth;
    _vertical = vertical;
    _horizontal= horizontal;
    _colour = colour;
  
    _colide = colide;
  }
  
  
  void display()
  {
    fill(_colour);
    
    //oscilate();
    pushMatrix();
    translate(_x, _y, _z);
    box(_depth, _vertical, _horizontal);
    popMatrix();
    
    Collisions();
    
  }
  
  private void Collisions()
  {
    if(cam.position.x <= _x +(_depth/2) +10 && cam.position.x >= _x +(_depth/2) -10
    && cam.position.z <= _z +(_horizontal/2) && cam.position.z >= _z -(_horizontal/2)
    && cam.position.y <= _y +(_vertical/2) && cam.position.y >= _y -(_vertical/2))
    {
      cam.position.x = _x +(_depth/2) +11;
      _colide = false;
    }
    
    else if(cam.position.x <= _x -(_depth/2) +10 && cam.position.x >= _x -(_depth/2) -10
    && cam.position.z <= _z +(_horizontal/2) && cam.position.z >= _z -(_horizontal/2)
    && cam.position.y <= _y +(_vertical/2) && cam.position.y >= _y -(_vertical/2))
    {
      cam.position.x = _x -(_depth/2) -11;
      _colide = false;
    }

    else if(cam.position.x <= _x +(_depth/2) && cam.position.x >= _x -(_depth/2) 
    && cam.position.z <= _z -(_horizontal/2) +10 && cam.position.z >= _z -(_horizontal/2) -10
    && cam.position.y <= _y +(_vertical/2) && cam.position.y >= _y -(_vertical/2))
    {
      cam.position.z = _z -(_horizontal/2) -11;
      _colide = false;
    }
    
    else if(cam.position.x <= _x +(_depth/2) && cam.position.x >= _x -(_depth/2)
    && cam.position.z <= _z +(_horizontal/2) +10 && cam.position.z >= _z +(_horizontal/2) -10
    && cam.position.y <= _y +(_vertical/2) && cam.position.y >= _y -(_vertical/2))
    {
      cam.position.z = _z +(_horizontal/2) +11;
      _colide = false;
    }

    else if(cam.position.x <= _x +(_depth/2) && cam.position.x >= _x -(_depth/2)
    && cam.position.z <= _z +(_horizontal/2) && cam.position.z >= _z -(_horizontal/2)
    && cam.position.y <= _y -(_vertical/2) -50 && cam.position.y >= _y -(_vertical/2) -100)
    {
      acceleration.y = acceleration.y * 0;
      velocity.y = -1;
      _colide = true;
    }
    
    else if(cam.position.x <= _x +(_depth/2) && cam.position.x >= _x -(_depth/2)
    && cam.position.z <= _z +(_horizontal/2) && cam.position.z >= _z -(_horizontal/2)
    && cam.position.y >= _y +(_vertical/2) && cam.position.y <= _y +(_vertical/2) +20)
    {
      velocity.add(0,10,0);
      position.add(0,10,0);
       _colide = false;
    }
    else
    {
       _colide = false;
    }
  }
  
  void oscilate()
  {
    _x += random(-1,1);
    _y += random(-1,1);
    _z += random(-1,1);
  }
}