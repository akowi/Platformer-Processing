class Entity
{
  String entityType;
  PImage spritesheet;
  PImage[] spritesLeft,spritesRight;
  PImage currentSprite;
  SoundFile damageSound;
  SoundFile deathSound;
  String fileName;
  float x,y;
  int w,h;
  int hp;
  int currentFrame=0;
  float speed;
  boolean dead=false;
  boolean goLeft=false;
  boolean goRight=false;
  boolean lastRight=true;
  float maxLeft=10;
  float maxRight=env.worldLength;
  float maxUp=0;
  float maxDown=1000;
  
  Entity(float x,float y)
  {
    this.x=x;
    this.y=y;
  }
  
  PImage[] loadSprites(int spritesW,int spritesH,String sheetName)
  {
    spritesheet=loadImage(sheetName);
    w=spritesheet.width/spritesW;
    h=spritesheet.height/spritesH;
    PImage[] sprite=new PImage[spritesW*spritesH];
    for(int i=0;i<spritesH;i++)
    {
      for(int n=0;n<spritesW;n++)
      {
        sprite[n+i*spritesW]=spritesheet.get(w*n,h*i,w,h);
      }
    }
    return sprite;
  }
  
  void display(Entity e,int frames,int seconds)
  {
    if(!env.detectCollision("bottom",e) && lastRight)
    {
      currentSprite=spritesRight[7];
    }
    else if(!env.detectCollision("bottom",e) && !lastRight)
    {
      currentSprite=spritesLeft[7];
    }
    else if(goLeft)
    {
      currentSprite=spritesLeft[selectSprite(frames,seconds)];
    }
    else if(goRight)
    {
      currentSprite=spritesRight[selectSprite(frames,seconds)];
    }
    else if(lastRight)
    {
      currentSprite=spritesRight[frames-1];
    }
    else
    {
      currentSprite=spritesLeft[frames-1];
    }
    
    image(currentSprite,x,y);
  }
  
  int selectSprite(int frames,int seconds)
  {
    if(currentFrame==seconds*60/frames*frames || (!goRight && !goLeft))
    {
      currentFrame=0;
    }
    if(goRight || goLeft)
    {
      currentFrame++;
      for (int n=1; n<spritesRight.length+1; n++)
      {
        if (currentFrame<=seconds*60/frames*n)
        {
          return n-1;
        }
      }
    } 
    else
    {
      return frames-1;
    }
    return 0;
  }
  
  void move()
  {
    x=constrain(x+speed*(int(goRight)-int(goLeft)),maxLeft,maxRight);
    y=constrain(y,maxUp,maxDown);
  }
  
  void lastDirection()
  {
    if(goRight)
    {
      lastRight=true;
    }
    if(goLeft)
    {
      lastRight=false;
    }
  }
  
  boolean takeDamage()
  {
    if(entityType=="enemy")
    {
      boolean b;
      for(int n=0;n<player.bullets.size();n++)
      {
        if(player.bullets.get(n).wasFiredRight)
        {
          b=player.bullets.get(n).x+player.bullets.get(n).w>x-5 && player.bullets.get(n).x<x+5;
        }
        else
        {
          b=player.bullets.get(n).x>x-5 && player.bullets.get(n).x<x+w+5;
        }
        if(b && player.bullets.get(n).y>y-5 && player.bullets.get(n).y<y+h+5)
        {
             player.bullets.get(n).destroyed=true;
             return true;
        }
      }
    }
    else if(entityType=="player")
    {
      for(int n=0;n<env.enemies.size();n++)
      {
        if(player.x>env.enemies.get(n).x-5 && player.x<env.enemies.get(n).x+env.enemies.get(n).w+5 &&
           player.y>env.enemies.get(n).y-10 && player.y<env.enemies.get(n).y+env.enemies.get(n).h+5 &&
           player.invincibilityDuration==0)
         {
             return true;
         }
      }
    }
    return false;
  }
  
  void loseHp()
  {
    if(takeDamage())
    {
      hp--;
      if(hp!=0)
      {
        damageSound.play();
      }
    }
    if(hp==0)
    {
      deathSound.play();
      dead=true;
    }
  }
  
  void fallDeath()
  {
    if(y>height)
    {
      dead=true;
    }
  }
  
  void bottomCollision(Entity e)
  {
    if(env.detectCollision("bottom",e))
    {
      correctPos();
      maxDown=env.platforms.get(env.collisionID)[0].y-h;
      if(env.platforms.get(env.collisionID)[0].type==3)
      { 
        if(env.platforms.get(env.collisionID)[0].goRight)
        {
          x+=env.platforms.get(env.collisionID)[0].xSpeed;
        }
        else if(env.platforms.get(env.collisionID)[0].goLeft)
        {
          x-=env.platforms.get(env.collisionID)[0].xSpeed;
        }
      }
    }
    else
    {
      maxDown=10000;
    }
  }
  
    void topCollision(Entity e)
  {
    if(env.detectCollision("top",e))
    {
      constrain(player.y,env.platforms.get(env.collisionID)[0].y+env.platforms.get(env.collisionID)[0].h,1000);
    }
  }
  
  void leftCollision(Entity e)
  {
    if(env.detectCollision("left",e))
    {
      maxRight=env.platforms.get(env.collisionID)[0].x-w;
    }
    else
    {
      maxRight=10000;
    }
  }
  
  void rightCollision(Entity e)
  {
    if(env.detectCollision("right",e))
    {
      maxLeft=env.platforms.get(env.collisionID)[env.platforms.get(env.collisionID).length-1].x+env.platforms.get(env.collisionID)[0].w;

    }
    else
    {
      maxLeft=10;
    }
  }
  
  void correctPos()
  {
    y=env.platforms.get(env.collisionID)[0].y-h;
  }
}
