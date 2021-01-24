class Player extends Entity
{
  ArrayList<Projectile> bullets;
  PImage[] HealthBarSprite;
  float jumpHeight=150;
  float jumpSpeed=15;
  float jumpProgress=0;
  boolean hasJumped=false;
  boolean canShoot=true;
  int maxCooldown=20;
  int cooldown=20;
  int invincibilityDuration=0;
  float flyHeight=200;

  Player(float x, float y)
  {
    super(x, y);
    bullets=new ArrayList<Projectile>();
    entityType="player";
    hp=6;
    speed=2.5;
  }
    
  void invincibility()
  {
    if(takeDamage())
    {
      invincibilityDuration=30;
    }
    
    if(invincibilityDuration>0)
    {
      invincibilityDuration--;     
    }
    
  }
  
  void die()
  {
    if(dead)
    {
      env.reset();
      dead=false;
    }
  }
  void displayHealthBar()
  {
    float healthX;
    if(checkPlayerPosition())
    {
      healthX=10;
    }
    else
    {
      healthX=x-width/2+10;
    }
    image(HealthBarSprite[hp-1],healthX,10);
  }
  
  boolean checkPlayerPosition()
  {
    if(x<width/2)
    {
      return true;
    }
    return false;
  }
  
  boolean withinPlayerRange(float x)
  {
    if(x>=player.x-width && x<=player.x+width)
    {
      return true;
    }
    return false;
  }
  void detectKey(boolean b)
  {
    if (keyCode==RIGHT)
    {
      goRight=b;
    }

    if (keyCode==LEFT)
    {
      goLeft=b;
    }

    if (keyCode==UP  && env.detectCollision("bottom", player))
    {
      hasJumped=b;
    }
    
  }

  void jump()
  {
    if (env.detectCollision("top", player))
    {
      hasJumped=false;
      jumpProgress=0;
    }
    if (hasJumped)
    {
      y-=jumpSpeed;
     jumpProgress+=jumpSpeed;
    }

    if (jumpProgress>=jumpHeight)
    {
      hasJumped=false;
      jumpProgress=0;
    }
  }
  
  void shotCooldown()
  {
    if(!canShoot)
    {
      if(cooldown==0)
      {
        cooldown=maxCooldown;
        canShoot=true;
      }
      else
      {
        cooldown--;
      }
    }
  }
  void shoot()
  {  
    if(canShoot)
    {
      if(key=='x' && lastRight)
      {
        bullets.add(new Projectile(x+w,y+h/2));
        canShoot=false;
      }
      else if(key=='x')
      {
        bullets.add(new Projectile(x-20,y+h/2));
        canShoot=false;
      }
    }
  }
  void sprint(boolean b)
  {
    if(keyCode==SHIFT && b)
    {
      speed=5;
    }
    else if(keyCode==SHIFT && !b)
    {
      speed=3.5;
    }
  }
  void playerCollision()
  {
    player.bottomCollision(player);
    player.topCollision(player);
    player.rightCollision(player);
    player.leftCollision(player);
  }
}
