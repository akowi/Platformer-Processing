class Enemy extends Entity
{
  String type;
  String firstDirection;
  int reverseDirectionCooldown=0;
  
  Enemy(float x,float y,String type,String firstDirection)
  {
    super(x,y);
    entityType="enemy";
    this.firstDirection=firstDirection;
    this.type=type;
    if(type=="zombie")
    {
      hp=4;
      speed=0.1;
      damageSound=new SoundFile(Game.this,"Enemies/Zombie/Sounds/hurt.wav");
      deathSound=new SoundFile(Game.this,"Enemies/Zombie/Sounds/death.wav");
    }
  }
  
  void calculateDirectionCooldown()
  {
    if(reverseDirectionCooldown>0)
    {
      reverseDirectionCooldown--;
    }
  }
  
  void reverseDirection()
  {
    if(reverseDirectionCooldown==0)
    {
      if(goRight)
      {
        goRight=false;
        goLeft=true;
      }
      else
      {
        goRight=true;
        goLeft=false;
      }
      reverseDirectionCooldown=60;
    }
  }
  
  void moveAI(Enemy e)
  {
    if(firstDirection=="right")
    {
      goRight=true;
    }
    else if(firstDirection=="left")
    {
      goLeft=true;
    }
    firstDirection="";
    
    if(env.detectCollision("right",e) || env.detectCollision("left",e) ||
       env.detectCollision("leftborder",e)|| env.detectCollision("rightborder",e))
    {
        reverseDirection();  
    }
    move();  
  }
  
}
