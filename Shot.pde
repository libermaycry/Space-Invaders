class Shot 
{
  float x;
  float y;
  float l;
  float w;
  float speed;
  
  Shot (float x, float y, float s)
  {
    this.x = x;
    this.y = y;
    l = 15;
    w = 4;
    speed = s;
  }
  
  void show (char c)
  {
    if(c == 's')
    {
      noStroke();
      fill(0, 128, 255);
      rect(x-w/2, y, w, l); 
    }
    
    if(c == 'a')
    {
      noStroke();
      fill(#A50F0F);
      rect(x-w/2, y, w, l); 
    }

  }
  
  void move ()
  {
    y += speed;
  }
  
  boolean hits (Alien alien)
  {
    if(y <= alien.lowHitbox && y >= alien.highHitbox)
      if(x >= alien.leftHitbox && x <= alien.rightHitbox)
        return true;
        
    return false;
  }
  
  boolean hits (Ship ship)
  {
    float Y = y + l;
    
    if(Y > ship.y - ship.h/2 && Y < ship.y + ship.h/2)
      if(x > ship.x - ship.w/2 && x < ship.x + ship.w/2)
        return true;
        
    return false;
    
  }
  
}