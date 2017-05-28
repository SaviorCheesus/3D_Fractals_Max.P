class Points
{
  PVector _location;
  float timer = 1;
  
  Points(PVector location)
  {
    _location = location;
  }
  
  void display()
  {
    pushMatrix();
    translate(_location.x, _location.y, _location.z);
    rotateY(timer/(2*PI));
    box(10, 10, 2); 
    popMatrix();
    
    timer+= 1;
  }
}