public class allClasses extends PApplet
{
  //star class
  public class Star
  {
    float x;
    float y;
    float radius;
    public Star(float x, float y, float radius)
    {
      this.x=x;
      this.y=y;
      this.radius=radius;
    }
    void display()
    {
      pushMatrix();
      fill(255);
      translate(x, y, -1300);
      circle(0, 0, radius);
      popMatrix();
    }
    public float getX() {
      return x;
    }
    public float getY() {
      return y;
    }
    public float getRadius() {
      return radius;
    }
  }
  //bullet class
  public class Bullet
  {
    private float size;
    private PVector location;
    private PVector newLocation;
    private PVector slope;
    private boolean canRemove;
    public Bullet(float toX, float toY)
    {
      newLocation= new PVector(toX, toY);
      location= new PVector(width/2, 2*height/3, 500);
      slope= new PVector(0, 0);
      calculate();
      size=10;
    }
    public void display()
    {
      shapeMode(CENTER);
      pushMatrix();
      fill(255, 0, 0);
      noStroke();
      lights();
      translate(location.x, location.y, location.z);
      sphere(size);
      popMatrix();
    } 
    void movement()
    {
      location.add(slope);
      if (location.z<-1300)
      {
        canRemove=true;
      }
    }
    void calculate()
    {
      slope.x=(newLocation.x-location.x)/50;
      slope.y=(newLocation.y-location.y)/45;
      slope.z=-10;
    }
    public float getX() {
      return location.x;
    }
    public float getY() {
      return location.y;
    }
    public float getZ() {
      return location.z;
    }
    public float getSize() {
      return size;
    }
    public boolean canRemove() {
      return canRemove;
    }
    public void shouldRemove() {
      canRemove=true;
    }
  }
  //asteroid class
  public class Asteroid
  {
    private PShape Asteroid;
    private float x;
    private float y;
    private float scale;
    private float rotateY;
    private float rotateZ;
    private float rotateX;
    private float z;
    private boolean remove;
    public Asteroid(float x, float y, float z, float scale, float rotateX, float rotateY, float rotateZ)
    {
      Asteroid=loadShape("C:/Users/scott/Documents/Processing/SpaceGame_VR/data/AsteroidV2.obj");
      this.x=x;
      this.y=y;
      this.scale=scale;
      Asteroid.scale(scale);
      Asteroid.setTextureMode(NORMAL);
      this.rotateY=rotateY;
      this.rotateZ=rotateZ;
      this.rotateX=rotateX;
      this.z=z;
      this.remove=false;
    }
    void display()
    {
      pushMatrix();
      lights();
      shapeMode(CENTER);
      translate(x, y, z);
      rotateX(rotateX);
      shape(Asteroid);
      popMatrix();
    if(z>=700){remove=true;}
    }
    void movement()
    {
      //move foward
      z+=3;
      //rotate
      rotateX-=0.02;
    }
    public boolean isShot(float bX, float bY, float bZ, float bSize)
    {
      if (dist(bX, bY, bZ, x-scale, y, z)<bSize+(scale*1.2))
      {
        return true;
      }
      return false;
    }
    public void sphereTest()
    {
      pushMatrix();
      shapeMode(CENTER);
      translate(x-scale, y, z);
      rotateX(rotateX);
      sphere(scale*1.2);
      popMatrix();
    }
    public boolean canRemove() {
      return remove;
    }
    public void shouldRemove() {
      remove=true;
    }
    public float getZ(){return z;}
  }
  Star[] stars= new Star[400];
  void starSetup()
  {
    for (int i=0; i<stars.length; i++)
    {
      stars[i]= new Star(random(-w1Width*1.7, w1Width*2), random(-w1Height*1.7, w1Height*2.4 ), random(10));
    }
  }
  public void settings()
  {
    size(600, 600, P3D);
  }
}
