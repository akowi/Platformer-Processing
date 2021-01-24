import processing.sound.*;

void setup()
{
  size(1280,720);
  frameRate(60);
  env.createStuff();
  env.loadAllSprites();
  env.loadSounds();
  env.setBackground();
}

Environment env=new Environment();
Player player=new Player(100,550);

void draw()
{
  env.setScreenCenter();
  env.moveScreen();
  env.manageBackground();
  env.manageBlocks();
  env.manageEnemies();
  player.playerCollision();
  player.display(player,8,1);
  player.lastDirection();
  env.activateGravity();
  player.move();
  player.jump();
  player.loseHp();
  player.invincibility();
  player.fallDeath();
  player.die();
  env.manageBullets();
  player.shotCooldown();
  player.displayHealthBar();
  env.win();
}

void keyPressed()
{
  env.pause();
  player.detectKey(true);
  player.shoot();
  player.sprint(true);
  if(key=='p')
  {
    player.x+=250;
    player.y=200;
  }
}

void keyReleased()
{
  player.detectKey(false);
  player.sprint(false);
} 
