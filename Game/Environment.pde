public class Environment
{
  ArrayList<Block[]> platforms;
  ArrayList<Enemy> enemies;
  SoundFile backgroundMusic;
  SoundFile winSound;
  float screenCenter;
  boolean noGravity=false;
  int collisionID;
  int worldLength=9000;
  float[][] starsX,starsY;
  int xStarNum,yStarNum;
  PImage pauseMenu;
  PImage winScreen;
  PImage star;
  
  void loadSounds()
  {
    backgroundMusic=new SoundFile(Game.this,"Environment/Sounds/backgroundMusic.mp3");
    winSound=new SoundFile(Game.this,"Environment/Sounds/win.wav");
    player.damageSound=new SoundFile(Game.this,"Player/Sounds/hurt.wav");
    player.deathSound=new SoundFile(Game.this,"Player/Sounds/death.wav");
  }
  
  void moveScreen()
  {
    translate(constrain(-player.x+width/2,-env.worldLength,0),0);
  }
  
  void setScreenCenter()
  {
    if(player.checkPlayerPosition())
        {
          screenCenter=width/2-pauseMenu.width/2;
        }
        else
        {
          screenCenter=player.x-pauseMenu.width/2;
        }
  }
  
  void pause()
  {
    if(key==TAB)
    {
      if(looping)
      {
        noLoop();
        fill(0,0,0,50);
        image(pauseMenu,screenCenter,height/2-pauseMenu.height);
        rect(0,0,env.worldLength,720);
      }
      else
      {
        loop();
      }     

    }
  }
  
  void createStuff()
  {
    platforms=new ArrayList();  
    platforms.add(createPlatform(0,650,6,0));
    platforms.add(createPlatform(700,600,1,0));
    platforms.add(createPlatform(900,550,1,1));
    platforms.add(createPlatform(1100,500,1,1));
    platforms.add(createPlatform(1300,550,4,0));
    platforms.add(createPlatform(1800,550,1,2));
    platforms.add(createPlatform(2100,600,1,1));
    platforms.add(createPlatform(2300,550,1,1));
    platforms.add(createPlatform(2500,600,2,0));
    platforms.add(createPlatform(2800,600,1,3));
    platforms.add(createPlatform(3200,550,1,1));
    platforms.add(createPlatform(3350,450,1,1));
    platforms.add(createPlatform(3600,550,1,2));
    platforms.add(createPlatform(3900,400,1,1));
    platforms.add(createPlatform(4200,600,3,0));
    platforms.add(createPlatform(4600,550,1,1));
    platforms.add(createPlatform(4700,650,1,3));
    platforms.add(createPlatform(5000,700,1,2));
    platforms.add(createPlatform(5200,450,1,1));
    platforms.add(createPlatform(5400,600,3,0));
    platforms.add(createPlatform(5800,550,1,1));
    platforms.add(createPlatform(6000,500,1,1));
    platforms.add(createPlatform(6100,400,1,3));
    platforms.add(createPlatform(6450,300,1,1));
    platforms.add(createPlatform(6800,600,4,0));
    platforms.add(createPlatform(7300,650,1,2));
    platforms.add(createPlatform(7500,550,1,2));
    platforms.add(createPlatform(7700,550,1,3));
    platforms.add(createPlatform(8000,650,15,0));
       
    enemies=new ArrayList();
    enemies.add(new Enemy(450,550,"zombie","left"));
    enemies.add(new Enemy(550,550,"zombie","left"));
    enemies.add(new Enemy(1400,400,"zombie","left"));
    enemies.add(new Enemy(1450,400,"zombie","left"));
    enemies.add(new Enemy(1500,400,"zombie","right"));
    enemies.add(new Enemy(2150,500,"zombie","left"));
    enemies.add(new Enemy(2350,450,"zombie","right"));
    enemies.add(new Enemy(3250,450,"zombie","left"));
    enemies.add(new Enemy(3400,350,"zombie","left"));
    enemies.add(new Enemy(3950,300,"zombie","left"));
    enemies.add(new Enemy(4300,500,"zombie","left"));
    enemies.add(new Enemy(4400,500,"zombie","right"));
    enemies.add(new Enemy(5200,350,"zombie","left"));
    enemies.add(new Enemy(5550,500,"zombie","left"));
    enemies.add(new Enemy(5600,500,"zombie","left"));
    enemies.add(new Enemy(5650,500,"zombie","left"));
    enemies.add(new Enemy(6050,400,"zombie","right"));
    enemies.add(new Enemy(6900,400,"zombie","right"));
    enemies.add(new Enemy(8100,550,"zombie","right"));
    enemies.add(new Enemy(8150,550,"zombie","right"));
    enemies.add(new Enemy(8200,550,"zombie","right"));
    enemies.add(new Enemy(8250,550,"zombie","right"));
    enemies.add(new Enemy(8300,550,"zombie","right"));
  }
  
  void reset()
  {
    enemies.clear();
    platforms.clear();
    player.x=300;   
    player.y=530;
    player.hp=6;
    backgroundMusic.stop();
    setup();
  }
  
  void loadAllSprites()
  {
    pauseMenu=loadImage("Environment/Sprites/Pause.png");
    winScreen=loadImage("Environment/Sprites/Win.png");
    star=loadImage("Environment/Sprites/Star.png");
    player.HealthBarSprite=player.loadSprites(3,2,"Player/Sprites/Health bar.png");
    for(int n=0;n<player.HealthBarSprite.length/2;n++)
    {
      PImage temp=player.HealthBarSprite[n];
      player.HealthBarSprite[n]=player.HealthBarSprite[player.HealthBarSprite.length-n-1];
      player.HealthBarSprite[player.HealthBarSprite.length-n-1]=temp;
    }
    player.spritesRight=player.loadSprites(4,2,"Player/Sprites/Player (walk_right).png");
    player.spritesLeft=player.loadSprites(4,2,"Player/sprites/Player (walk_left).png");
    for(int n=0;n<enemies.size();n++)
    {
      if(enemies.get(n).type=="zombie")
      {
         enemies.get(n).spritesRight=enemies.get(n).loadSprites(4,2,"Enemies/Zombie/Sprites/Zombie (walk_right).png");
         enemies.get(n).spritesLeft=enemies.get(n).loadSprites(4,2,"Enemies/Zombie/Sprites/Zombie (walk_left).png");
      }
    }
   
  }
  
  void win()
  {
    if(player.x>=worldLength-500)
    {
      noLoop();
      backgroundMusic.stop();
      fill(0,0,0,50);
      rect(0,0,worldLength+500,720);
      image(winScreen,screenCenter-100,height/2-winScreen.height);
      winSound.play();
    }
  }
  
  Block[] createPlatform(float x,float y,int length,int type)
  {
    Block[] platform=new Block[length];
    for(int n=0;n<length;n++)
    {
      platform[n]=new Block(x+100*n,y,type);
    }
    return platform;
  }
  
  void manageBlocks()
  {
    for(int n=0;n<platforms.size();n++)
    {
      for(int i=0;i<platforms.get(n).length;i++)
      {
        platforms.get(n)[i].move();
        if(player.withinPlayerRange(platforms.get(n)[i].x))
        {
          platforms.get(n)[i].display();
        }     
      }
    }
  }
  
  void manageBullets()
  {
    for(int n=0;n<player.bullets.size();n++)
    {
      player.bullets.get(n).display();
      player.bullets.get(n).move();
      player.bullets.get(n).explode(tempEntity(player.bullets.get(n).x,player.bullets.get(n).y,
                                    player.bullets.get(n).w,player.bullets.get(n).h));
      
      if(player.bullets.get(n).destroyed)
      {
        player.bullets.remove(n);
      }
    }
  }
  
  void manageEnemies()
  {
    for(int n=0;n<enemies.size();n++)
    {
      enemies.get(n).bottomCollision(enemies.get(n));
      enemies.get(n).topCollision(enemies.get(n));
      enemies.get(n).leftCollision(enemies.get(n));
      enemies.get(n).rightCollision(enemies.get(n));
     
      enemies.get(n).lastDirection();
      enemies.get(n).display(enemies.get(n),8,2);
      enemies.get(n).calculateDirectionCooldown();
      enemies.get(n).moveAI(enemies.get(n));
      enemies.get(n).loseHp();
      enemies.get(n).fallDeath();
      
      if(enemies.get(n).dead)
      {
        enemies.remove(n);
        for(int i=0;i<enemies.size();i++)
        {
           enemies.get(i).y-=5;
        }
      }
    }
  }
  
  void setBackground()
  {
    int xDistance=250;
    int yDistance=250;
    xStarNum=10000/xDistance;
    yStarNum=height/yDistance+1;
    starsX=new float[xStarNum][yStarNum];
    starsY=new float[xStarNum][yStarNum];

    for(int x=0;x<xStarNum;x++)
    {
      for(int y=0;y<yStarNum;y++)
      {
        starsX[x][y]=random(xDistance*x,xDistance+xDistance*x);
        starsY[x][y]=random(yDistance*y,yDistance+yDistance*y);
      }
    }
  }
  
  void manageBackground()
  {
    background(15,2,47);
    for(int x=0;x<xStarNum;x++)
    {
      for(int y=0;y<yStarNum;y++)
      {
        if(player.withinPlayerRange(starsX[x][y]))
        {
          image(star,starsX[x][y],starsY[x][y]);
        }        
      }
    }
    
    if(!backgroundMusic.isPlaying())
    {
      backgroundMusic.play();
    }
  }
  
  Entity tempEntity(float x,float y,int w,int h)
  {
    Entity tempE=new Entity(x,y);
    tempE.w=w;
    tempE.h=h;
    return tempE;
  }
  boolean detectCollision(String type,Entity e)
  {    
    for(int n=0;n<platforms.size();n++)
    {
      for(int i=0;i<platforms.get(n).length;i++)
      {
        if(type=="rightborder")
        {
          i=platforms.get(n).length-1;
        }
        if(platforms.get(n)[i].collision(type,e))
        {
          collisionID=n;
          return true;
        }
        if(type=="leftborder")
        {
          break;
        }
      }
    }
    return false;     
   }
  
  void activateGravity()
  {
    float force=5;
    player.y+=force;
    for(int n=0;n<enemies.size();n++)
    {
      enemies.get(n).y+=force;
    }        
  }
  
  
}
