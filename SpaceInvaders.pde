Ship ship;
ArrayList <Shot> shipShots;
ArrayList <Shot> aliensShots;
ArrayList <Alien> aliens;
ArrayList <PowerUp> powerUps;

int aliensRows = 5;
int aliensPerRow = 10;
float xSpace = 60;
float ySpace;

int backgroundColor = 0;

float shipSpeed = 5;
float shotsSpeed = 5;

boolean shipOnRightEdge = false; 
boolean shipOnLeftEdge = false; 
boolean alienOnEdge = false;
boolean end = false;

boolean powerUp1Active = false, powerUp1Timing = true;
boolean powerUp2Active = false, powerUp2Timing = true;
boolean powerUp3Active = false, powerUp3Timing = true;
boolean powerUp4Active = false, powerUp4Timing = true;
boolean textTiming = true;

int s1, m1;
int s2, m2;
int s3, m3;
int s4, m4;
int st, mt;

boolean expired = true;
int S, M;

PImage alien1, alien2, alien3;


void setup () 
{
  size (800, 600);
  
  ship = new Ship(width/2, height - 20);
  shipShots = new ArrayList <Shot> ();
  aliensShots = new ArrayList <Shot> ();
  aliens = new ArrayList <Alien> ();
  powerUps = new ArrayList <PowerUp> ();
  ySpace = Alien.pSize*20;
  
  alien1 = loadImage("alien1.png");
  alien2 = loadImage("alien2.png");
  alien3 = loadImage("alien3.png");
  
  createAliens();
  
  frameRate(60); 
}


void draw () 
{
  background(backgroundColor);
  
  if (!end)
  {
    ship.show();
    showPowerUps();
    showAliens();
    showShipShots();
    showAliensShots();
        
    ship.move();
    moveAliens();
    moveShipShots();
    moveAliensShots();
    movePowerUps();
    
    spawnPowerUps();
        
    aliensShoot();
  
    checkCollisions();  
    checkPowerUps();
  }
   
  else
  {
    textSize(32);
    fill(255);
    textAlign(CENTER);
    
    if(aliens.size() > 0)
      text("You are dead!", width/2, height/2);
    
    else
      text("You saved the Earth!", width/2, height/2);
  }
  
}

/////////////////////////////////////////////// ALIENS SHOT

void aliensShoot ()
{
  for (Alien a : aliens)
  {
    if(hasOpenShot(a))
    {
      int rand = (int) random(500);
            
      if(rand == 10)
        a.shoot();
    }
  }
}

boolean hasOpenShot (Alien a)  //un alieno può sparare se non ha nessuno davanti
{
  for(int row = 1; row <= aliensRows; row++)
  {
     if (aliens.contains(new Alien1(a.x, a.y + row*ySpace)))
        return false;
     if (aliens.contains(new Alien2(a.x, a.y + row*ySpace)))
        return false;
     if (aliens.contains(new Alien3(a.x, a.y + row*ySpace)))
        return false;
  }
     
  return true;
}

/////////////////////////////////////////////// COLLISIONS

void checkCollisions()
{
  for(int i=0; i < shipShots.size(); i++)
  {
    Shot currentShot = shipShots.get(i);
    
    for(int j=0; j < aliens.size(); j++)
    {
      Alien currentAlien = aliens.get(j);
      
      if(currentShot.hits(currentAlien))
      {
        aliens.remove(j);
        shipShots.remove(i);
        break;
      } 
    }
  }
  
  if (aliens.size() == 0)
    end = true;
  
  for(int i=0; i < aliensShots.size(); i++)
  {
    Shot currentShot = aliensShots.get(i);
    
    if(currentShot.hits(ship))
    {
      if(powerUp2Active)
      {
        powerUp2Active = false;
        powerUp2Timing = true;
        aliensShots.remove(i);
      }
      
      else   
        end = true;  
    }
      
  }
  
  for(int i=0; i < powerUps.size(); i++)
  {
    PowerUp p = powerUps.get(i);
    
    if (p.y + p.r >= ship.y - ship.h/2 && p.y + p.r <= ship.y + ship.h/2)
      if (p.x + p.r >= ship.x - ship.w/2 && p.x + p.r <= ship.x + ship.w/2
           || p.x - p.r >= ship.x - ship.w/2 && p.x - p.r <= ship.x + ship.w/2)
      {
        p.active();
        powerUps.remove(i);
      }

    
  }

}

////////////////////////////////////////////////// POWER UPS

void spawnPowerUps ()
{
  int s = second();
  int m = minute();
  int spawnTime = 10;
    
  if (expired)
  {
    S = s;
    M = m;
    expired = false;
  }
  
  if (s == S + spawnTime || (m == M+1 && s+(60-S) == spawnTime) )
  {
    int x = (int) random(10, width-10);
    int t = (int) random(1,4);
    powerUps.add(new PowerUp(x,t));
    expired = true;
  }
  
}

void checkPowerUps ()
{
  if (powerUp1Active)
    checkPowerUp1(); 
  
  if (powerUp2Active)
    checkPowerUp2(); 
    
  if (powerUp3Active)
    checkPowerUp3(); 
 
}

////////////////////////////////// POWER UP 1 (double cannon)

void checkPowerUp1 ()
{
  int s = second();
  int m = minute();
  int t = 10;
  
  displayPowerUpText();
  
  if (powerUp1Timing)
  {
    s1 = s;
    m1 = m;
    powerUp1Timing = false;
    ship.shape = 2;
  }
  
  if (s == s1 + t || (m == m1+1 && s + (60-s1) == t) )
  {
    ship.shape = 1;
    powerUp1Active = false;
    powerUp1Timing = true;
    textTiming = true;
  }    
  
}

////////////////////////////////// POWER UP 2 (shield)

void checkPowerUp2 ()
{
  int s = second();
  int m = minute();
  int t = 10;
  
  displayPowerUpText();
  
  if (powerUp2Timing)
  {
    s2 = s;
    m2 = m;
    powerUp2Timing = false;
  
  }
  
  if (s == s2 + t || (m == m2+1 && s + (60-s2) == t) )
  {
    powerUp2Active = false;
    powerUp2Timing = true;
    textTiming = true;
  }
  
}

////////////////////////////////// POWER UP 3 (fast shooting)

void checkPowerUp3 ()
{
  int s = second();
  int m = minute();
  int t = 4;
  
  displayPowerUpText();
  
  if (powerUp3Timing)
  {
    s3 = s;
    m3 = m;
    powerUp3Timing = false;
  
  }
  
  if (s == s3 + t || (m == m3+1 && s + (60-s3) == t) )
  {
    powerUp3Active = false;
    powerUp3Timing = true;
    textTiming = true;
  }
  
}

void displayPowerUpText ()
{
  int s = second();
  int m = minute();
  int t = 2;
  
  textSize(26);
  fill(255);
  textAlign(CENTER);
  
  if (textTiming)
  {
    st = s;
    mt = m;
    textTiming = false;
  }
  
  if (s < st + t && (m < mt+1 || s + (60-st) < t) )
  {
    if(powerUp1Active)
      text("Double cannon!", width/2, height - 100);
    if(powerUp2Active)
      text("Shield activated!", width/2, height - 100);
    if(powerUp3Active)
      text("Fast shooting!", width/2, height - 100);
    if(powerUp4Active)
      text("Fast movement!", width/2, height - 100);
  }
 
}

/////////////////////////////////////////////// CREATE

void createAliens()
{
  float y = 30;
 
  for(int i=0; i < aliensRows; i++)
  {
      float x = xSpace;
          
      if (i==3 || i==4)
        for(int j=0; j < aliensPerRow; j++)
        {
          aliens.add(new Alien1(x,y));
          x += xSpace;
        } 
           
      if (i==2 || i==1)
        for(int j=0; j < aliensPerRow; j++)
        {
          aliens.add(new Alien2(x,y));
          x += xSpace; 
        }
      
      if (i==0)
        for(int j=0; j < aliensPerRow; j++)
        {
          aliens.add(new Alien3(x,y));
          x += xSpace;
        }
      
      y += ySpace;    
  }
  
}

//////////////////////////////////////////////// SHOW

void showAliens()
{
  for(Alien a : aliens)
    a.show();
}

void showAliensShots()
{
  for(Shot s : aliensShots)
    s.show('a');
}

void showShipShots ()
{
  for(Shot s : shipShots)
    s.show('s');
}

void showPowerUps ()
{
  for(PowerUp p : powerUps)
    p.show();
}

////////////////////////////////////////////////// MOVE

void moveAliens ()
{
  for (Alien a : aliens)
    a.move();
    
  if (alienOnEdge)
  {
    for(Alien a : aliens)
    {
      a.xSpeed *= -1;
      a.y += ySpace;
      a.highHitbox += ySpace;
      a.lowHitbox += ySpace;     
    }
    
    alienOnEdge = false;   
  }
}

void moveShipShots ()
{
  for (int i = 0; i < shipShots.size(); i++)
  {
    Shot currentShot = shipShots.get(i);
    
    currentShot.move();
    
    if (currentShot.y + currentShot.l <= 0)
       shipShots.remove(i);
  }
}

void moveAliensShots()
{
  for (int i = 0; i < aliensShots.size(); i++)
  {
    Shot currentShot = aliensShots.get(i);
    
    currentShot.move();
    
    if (currentShot.y >= height)
       aliensShots.remove(i);
  }  
}

void movePowerUps ()
{
  for(int i=0; i < powerUps.size(); i++)
  {
    PowerUp currentP = powerUps.get(i);
    
    currentP.move();
    
    if (currentP.y - currentP.r > height)
      powerUps.remove(i);  
  }
}

//////////////////////////////////////////////

void keyReleased ()
{
  if (keyCode == RIGHT && ship.xSpeed >= 0)
    ship.xSpeed = 0;
  if (keyCode == LEFT && ship.xSpeed < 0)
    ship.xSpeed = 0;
  if (key == ' ')
    ship.fireEnabled = true;
}

void keyPressed ()
{
  if (keyCode == RIGHT && !shipOnRightEdge)
    ship.xSpeed = shipSpeed;
    
  if (keyCode == LEFT && !shipOnLeftEdge)
    ship.xSpeed = -shipSpeed;
    
  if (key == ' ')
  {
    ship.shoot();
    ship.fireEnabled = false;
  }

}