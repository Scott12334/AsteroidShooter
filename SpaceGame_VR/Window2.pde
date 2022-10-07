public class SecondApplet extends allClasses 
{
  private Star[] stars1;
  private boolean canRun=false;
  private PVector targetPos;
  private PImage target;
  private ArrayList<Bullet> bullets;
  private ArrayList<Asteroid> asteroids;
  public void setup()
  {
    println(sketchRenderer());
    surface.setResizable(true);
    surface.setLocation((displayWidth/3-(w1Width/2))+w1Width, displayHeight/2-(w1Height/2));
    stars1= new Star[400];
    String path= "C:/Users/scott/Documents/Processing/SpaceGame_VR/data/Target.png";
    targetPos= new PVector(width/2, height/2);
    target= loadImage(path);
    bullets=new ArrayList<Bullet>();
    asteroids= new ArrayList<Asteroid>();
  }
  public void draw() {
    background(0);
    surface.setSize(w1Width, w1Height);
    if (canRun==true)
    {
      for (int i=0; i<stars1.length; i++)
      {
        stars1[i].display();
      }
    }
    asteroids();
    bullet();
    displayTarget();
  }
  public void recieveData(Star[] newStars)
  {
    for (int i=0; i<newStars.length; i++)
    {
      float x= newStars[i].getX();
      float y= newStars[i].getY();
      float radius= newStars[i].getRadius();
      stars1[i]=new Star(x, y, radius);
    }
    canRun=true;
  }
  //all recieve stuff
  public void recieveData(float x, float y)
  {
    targetPos.x=x;
    targetPos.y=y;
  }
  public void addBullet(float x, float y)
  {
    bullets.add(new Bullet(x, y));
  }
  public void addAsteroid(float x, float y, float z, float scale, float rX, float rY, float rZ)
  {
    asteroids.add(new Asteroid(x, y, z, scale, rX, rY, rZ));
  }

  public void displayTarget()
  {
    imageMode(CENTER); 
    image(target, targetPos.x, targetPos.y);
  }

  //bullet stuff
  public void bullet()
  {
    for (int i=0; i<bullets.size(); i++)
    {
      bullets.get(i).display();
      bullets.get(i).movement();
      if (bullets.get(i).canRemove()==true)
      {
        bullets.remove(i);
      }
    }
  }
  public void removeBullet(int i)
  {
    if(i<bullets.size()){bullets.get(i).shouldRemove();}
  }

  //asteroid stuff
  void asteroids()
  {
    for (int i=0; i<asteroids.size(); i++)
    {
      asteroids.get(i).display();
      asteroids.get(i).movement();
      if (asteroids.get(i).canRemove()==true)
      {
        asteroids.remove(i);
      }
    }
  }
  public void removeAsteroid(int i)
  {
    if(i<asteroids.size()){asteroids.get(i).shouldRemove();}
  }
}
