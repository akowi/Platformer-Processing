public class Block
{
  float x,y;
  int w,h;
  int type;
  PImage texture;
  float upProgress,downProgress,leftProgress,rightProgress=0;
  float xSpeed=2.5;
  float ySpeed=2.5;
  boolean goRight,goLeft;
  
  Block(float x,float y,int type)
  {
    this.x=x;
    this.y=y;
    this.type=type; 
    switch(type)
    {
      case 0:
        texture=loadImage("Environment/Sprites/Floor.png");
        break;
      case 1:
      case 2:
      case 3:
        texture=loadImage("Environment/Sprites/Platform.png");
        break;
    }    
    w=texture.width;
    h=texture.height;    
  }
 
  void display()
  {
    image(texture,x,y);
  }
  
  void move()
  {
    if(type==2)
    {
      int maxUp=200;
      int maxDown=200;
      
      if(upProgress<maxUp)
      {
        y-=ySpeed;
        upProgress+=ySpeed;    
      }
      else if(downProgress<maxDown)
      {
        y+=ySpeed;
        downProgress+=ySpeed;
      }
      else
      {
        upProgress=0;
        downProgress=0;
      }
    }
    
    if(type==3)
    {
      int maxLeft=200;
      int maxRight=200;
      if(rightProgress<maxRight)
      {
        x+=xSpeed;
        rightProgress+=xSpeed;
        goRight=true;
        goLeft=false;
      }
      else if(leftProgress<maxLeft)
      {
        x-=xSpeed;
        leftProgress+=xSpeed;
        goLeft=true;
        goRight=false;
      }
      else
      {
        rightProgress=0;
        leftProgress=0;
      }
    }
  }
  
  boolean collision(String type,Entity e)
  {
    switch(type)
    {
      case "bottom":        
        if(e.x>=x-e.w && e.x<=x+w &&
           e.y+e.h<=y+5 && e.y+e.h>=y-5)
        {    
           return true;
        }
        return false; 
         
      case "top":
        if(e.x>=x-e.w+1 && e.x<=x+w-1 &&
           e.y<=y+h+10 && e.y>=y+h-10)
        {
          return true;
        }
        return false;
        
      case "left":
        if(e.x<=x+5 && e.x>=x-e.w-5 &&
           e.y>=y-e.h+5 && e.y<=y+h-5)
        {
          return true;
        }
        return false;
        
      case "right":
        if(e.x<=x+w+5 && e.x>=x+w-5 &&
           e.y>=y-e.h+5 && e.y<=y+h-5)
        {
          return true;
        }
        return false;
        
      case "leftborder":        
        if(e.x>=x-5 && e.x<=x+5 &&
           e.y+e.h<=y+5 && e.y+e.h>=y-5)
        {    
           return true;
        }
        return false;
        
      case "rightborder":        
        if(e.x>=x+w-e.w    && e.x<=x+w &&
           e.y+e.h<=y+5 && e.y+e.h>=y-5)
        {    
           return true;
        }
        return false;
        
       default:
         return false;       
    }  
  }
}
