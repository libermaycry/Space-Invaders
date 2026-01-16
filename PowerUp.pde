class PowerUp 
{
  float x;
  float y;
  float r;
  int type;
  float ySpeed;
  
  //type 1 aggiunge un cannone
  //type 2 aggiunge lo scudo
  //type 3 sparare piu veloce
  //type 4 bomba
  
  PowerUp (float x, int type)
  {
    this.x = x;
    this.r = 10;
    this.type = type;
    ySpeed = 5;
    y = -r;
  }
  
  void show ()
  {
    noStroke();
    
    if(type == 1)
      fill(#A50F0F);
    if(type == 2)
      fill(0, 128, 255);
    if(type == 3)
      fill(#FF5100);

    ellipse(x, y, r*2, r*2);
  }
  
  void move ()
  {
    y += ySpeed;
  }
  
  void active ()
  {
    if (type == 1)
      powerUp1Active = true;
    
    if (type == 2)
      powerUp2Active = true;
      
    if (type == 3)
      powerUp3Active = true;
    
    
    
  }
  
  
  
  
  
  
  
}