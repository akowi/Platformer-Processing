class Projectile 
{
  float x,y;
  int w,h;
  PImage sprite=loadImage("Player/Sprites/Bullet.png");
  float speed=10;
  float travelledDistance=0;
  float maxDistance=300;
  boolean wasFiredRight=false;
  boolean wasFiredLeft=false;
  boolean destroyed=false;
  
  Projectile(float x,float y)
  {
    this.x=x;
    this.y=y;
    w=sprite.width;
    h=sprite.height;
  }
  
  void display()
  {
    image(sprite,x,y);
  }
  
  void move()
  {
    if((player.lastRight || wasFiredRight) && !wasFiredLeft)
    {
      wasFiredRight=true;
      x+=speed;
    }
    else if(!wasFiredRight)
    {
      wasFiredLeft=true;
      x-=speed;
    }
    travelledDistance+=speed;
  }
  
  void explode(Entity e)
  {
    if(env.detectCollision("left",e) || env.detectCollision("right",e) ||
       travelledDistance>=maxDistance)
    {
      destroyed=true;
    }
  }
}
