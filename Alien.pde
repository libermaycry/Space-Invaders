abstract class Alien
{
  float x;
  float y;
  static final float pSize = 2;
  float xSpeed;
  PImage img;
  
  float highHitbox, lowHitbox, rightHitbox, leftHitbox;
  
  Alien (float x, float y)
  {
    this.x = x;
    this.y = y;
    xSpeed = 0.5;
    
    highHitbox = y-8*pSize;
    lowHitbox = y+8*pSize;
    leftHitbox = x-11*pSize;
  }
  
  void move ()
  {
    x += xSpeed;
    rightHitbox += xSpeed;
    leftHitbox += xSpeed;
    
    if (rightHitbox >= width || leftHitbox <= 0)
      alienOnEdge = true; 
    
  }
  
  void shoot ()
  {
    aliensShots.add(new Shot(x, y+ySpace/2, shotsSpeed));
    
  }
  
  abstract void show ();
  
  @Override
  boolean equals (Object o)
  {
    Alien a = (Alien) o;
    
    if (a.x == this.x && a.y == this.y)
      return true;
      
    return false;
  }
 
   
}

/////////////////////////////////////////////////////////

class Alien1 extends Alien
{
  
  Alien1 (float x, float y)
  {
    super(x,y);
    img = alien1;
    rightHitbox = x+13*pSize;
  }
  
  @Override
  void show ()
  {
    float X = x - 12*pSize;
    float Y = y - 8*pSize;
    
    image(img, X, Y, 24*pSize, 16*pSize);    
  }
  
}

/////////////////////////////////////////////////////////

class Alien2 extends Alien
{
  
  Alien2 (float x, float y)
  {
    super(x,y);
    img = alien2;
    rightHitbox = x+11*pSize;
  }
  
  @Override
  void show ()
  {
    float X = x - 11*pSize;
    float Y = y - 8*pSize;
       
    image(img, X, Y, 22*pSize, 16*pSize);   
  }
  
}


/////////////////////////////////////////////////////////

class Alien3 extends Alien
{
  
  Alien3 (float x, float y)  
  {
    super(x,y);
    img = alien3;
    rightHitbox = x+5*pSize;
  }
  
  @Override
  void show ()
  {
    float X = x - 8*pSize;
    float Y = y - 8*pSize;
       
    image(img, X, Y, 16*pSize, 16*pSize);
  }
  
}