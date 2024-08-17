ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
PImage target;
Star[] stars;
Bullet test;
PVector targetPos;
void setup()
{
  size(1000,1000, P3D);
  asteroids= new ArrayList<Asteroid>();
  bullets=new ArrayList<Bullet>();
  targetPos= new PVector(width/2,height/2);
  for(int i=0; i<5; i++)
  {
    newAsteroids();
  }
  stars= new Star[300];
  for(int i=0; i<stars.length; i++)
  {
    stars[i]= new Star(random(-(width/1.7),width*2),random(-(height/1.7),height*2),random(10));
  }
  target= loadImage("Target.png");
}
void draw()
{
  background(0);
  for(int i=0; i<stars.length; i++)
  {
    stars[i].display();
  }
  for(int i=0; i<asteroids.size(); i++)
  {
    asteroids.get(i).display();
    asteroids.get(i).movement();
    //asteroids.get(i).sphereTest();
    for(Bullet b: bullets)
    {
      if(asteroids.get(i).isShot(b.getX(),b.getY(),b.getZ(),b.getSize())==true)
      {
        b.shouldRemove();
        asteroids.get(i).shouldRemove();
      }
    }
    if(asteroids.get(i).canRemove()==true)
    {
      asteroids.remove(i);
      newAsteroids();
    }
  }
  for(int i=0; i<bullets.size(); i++)
  {
    bullets.get(i).display();
    bullets.get(i).movement();
    if(bullets.get(i).canRemove()==true)
    {
      bullets.remove(i);
    }
  }
  target();
  //println(frameRate);
}
void mouseReleased()
{
  if(mouseButton==LEFT)
  {
    bullets.add(new Bullet(targetPos.x,targetPos.y));
  }
}
void newAsteroids()
{
  //x,y,scale,rX,rY,rZ
  asteroids.add(new Asteroid(random(width),random(height),random(-1200,-700),random(30,100),random(10),random(10),random(10)));
}
void target()
{
  imageMode(CENTER); 
  image(target,targetPos.x,targetPos.y);
  targetPos.x=mouseX;
  targetPos.y=mouseY;
}
