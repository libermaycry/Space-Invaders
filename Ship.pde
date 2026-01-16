class Ship
{
  float x;
  float y;
  
  float h;
  float w;
  
  float xSpeed;
  
  int shape;
  
  boolean fireEnabled;
  
  Ship (float x, float y)
  {
    this.x = x;
    this.y = y;
    h = 15; 
    w = 45;  
    xSpeed = 0;
    fireEnabled = true;
    shape = 1;
  }
  
  void move ()
  {
    x += xSpeed;
    
    if(x + w/2 >= width - 4)
    {
      shipOnRightEdge = true;
      xSpeed = 0;
    }
    
    else 
      shipOnRightEdge = false;
      
    if(x - w/2 <= 4)
    {
      shipOnLeftEdge = true;
      xSpeed = 0;
    }
    
    else 
      shipOnLeftEdge = false;
  }
  
  void shoot ()
  {
    if(fireEnabled)
    {
      if(shape == 1)
        oneCannonShoot();
        
      if(shape == 2)
        twoCannonsShoot();
    }
  }
  
  void oneCannonShoot()
  {
    if(shipShots.size() > 0) 
    {
      if(!powerUp3Active)
      {
        if(shipShots.get(shipShots.size()-1).y <= height/2)
          shipShots.add(new Shot(x, y-2.5*h, -shotsSpeed));
      }
      
      else 
        shipShots.add(new Shot(x, y-2.5*h, -shotsSpeed));
    }
        
    else 
      shipShots.add(new Shot(x, y-2.5*h, -shotsSpeed));
 
  }
  
  void twoCannonsShoot()
  {
    if(shipShots.size() > 0) 
    {
      if(shipShots.get(shipShots.size()-1).y <= height/2)
      {
        shipShots.add(new Shot(x+w/6, y-2.5*h, -shotsSpeed));
        shipShots.add(new Shot(x-w/6, y-2.5*h, -shotsSpeed));   
      }
        
    }
        
    else 
    {
      shipShots.add(new Shot(x+w/6, y-2.5*h, -shotsSpeed));
      shipShots.add(new Shot(x-w/6, y-2.5*h, -shotsSpeed));
    }
     
  }
  
  void show ()
  {
    fill(255);
    stroke(0);
    strokeWeight(2);
    
    if(shape == 1)
    {
      beginShape();
      vertex(x-w/2, y+h/2);
      vertex(x-w/2, y-h/2); //2
      vertex(x-w/6, y-h/2); //3
      vertex(x, y-5*h/4);   //4
      vertex(x+w/6, y-h/2);
      vertex(x+w/2, y-h/2); //6 
      vertex(x+w/2, y+h/2);
      endShape();
    }
    
    if(shape == 2)
    {
      beginShape();
      vertex(x-w/2, y+h/2); //1
      vertex(x-w/2, y-h/2); //2
      vertex(x-w/3, y-h/2); //3
      vertex(x-w/6, y-5*h/4); //4
      vertex(x, y-h/2); //5
      vertex(x+w/6, y-5*h/4); //6
      vertex(x+w/3, y-h/2); //7
      vertex(x+w/2, y-h/2); //8
      vertex(x+w/2, y+h/2); //9
      endShape();
    }
    
    if(powerUp2Active)
    {
      noFill();
      stroke(0, 128, 255);
      strokeWeight(2.5);
      
      ellipse(x, y, w + 20, w + 20);  
    }
    

  }
   
}