public class FirstApplet extends allClasses implements Runnable
{
  public boolean firstTime=true;
  public PImage target;
  PVector targetPos;
  ArrayList<Bullet> bullets;
  ArrayList<Asteroid> asteroids;
  int waveNum;
  int amountLeft;
  public void setup()
  {
    surface.setResizable(true);
    surface.setLocation(displayWidth/3-(w1Width/2), displayHeight/2-(w1Height/2));
    String path= "C:/Users/scott/Documents/Processing/SpaceGame_VR/data/";
    targetPos= new PVector(width/2, height/2);
    target= loadImage(path+"Target.png");
    bullets=new ArrayList<Bullet>();
    asteroids= new ArrayList<Asteroid>();
    waveNum=5;
    amountLeft=waveNum;
    for (int i=0; i<waveNum; i++)
    {
      newAsteroids();
    }
  }
  public void draw() {
    background(0);
    if (firstTime==true)
    {
      firstTime();
    } else
    {
      surface.setSize(w1Width, w1Height);
      for (int y=0; y<stars.length; y++)
      {
        stars[y].display();
      }
      contuinousData();
      asteroids();
      bullet();
      displayTarget();
      if (amountLeft==0)
      {
        thread("run");
      }
    }
  }
  //this is first time init of data
  public void sendData()
  {
    sa.recieveData(stars); //sets up the stars
  }
  public void firstTime()
  {
    starSetup();
    sendData();
    firstTime=false;
  }
  public void contuinousData()
  {
    sa.recieveData(targetPos.x, targetPos.y);
  }
  public void displayTarget()
  {
    imageMode(CENTER); 
    image(target, targetPos.x, targetPos.y);
    targetPos.x=mouseX;
    targetPos.y=mouseY;
  }
  public void bullet()
  {
    //bullet is sent to other window
    //bullet display
    for (int i=0; i<bullets.size(); i++)
    {
      bullets.get(i).display();
      bullets.get(i).movement();
      if (bullets.get(i).canRemove()==true)
      {
        bullets.remove(i);
        sa.removeBullet(i);
      }
    }
    //bullet move
    //bullet remove
  }
  void newAsteroids()
  {
    //x,y,scale,rX,rY,rZ
    float x=random(width);
    float y=random(height);
    float z=random(-1200, -700);
    float scale=random(30, 100);
    float rX=random(10);
    float rY=random(10);
    float rZ=random(10);
    asteroids.add(new Asteroid(x, y, z, scale, rX, rY, rZ));
    sa.addAsteroid(x, y, z, scale, rX, rY, rZ);
  }
  void asteroids()
  {
    for (int i=0; i<asteroids.size(); i++)
    {
      asteroids.get(i).display();
      asteroids.get(i).movement();
      for (Bullet b : bullets)
      {
        if (asteroids.get(i).isShot(b.getX(), b.getY(), b.getZ(), b.getSize())==true)
        {
          b.shouldRemove();
          asteroids.get(i).shouldRemove();
        }
      }
      if (asteroids.get(i).canRemove()==true)
      {
        asteroids.remove(i);
        sa.removeAsteroid(i);
        amountLeft-=1;
      }
    }
  }
  void mouseReleased()
  {
    if (mouseButton==LEFT)
    {
      bullets.add(new Bullet(targetPos.x, targetPos.y));
      sa.addBullet(targetPos.x, targetPos.y);
    }
  }
  public void run()
  {
    waveNum+=5;
    amountLeft=waveNum;
    for (int i=0; i<waveNum; i++)
    {
      newAsteroids();
    }
  }
}
