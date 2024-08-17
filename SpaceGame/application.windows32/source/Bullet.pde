public class Bullet
{
  private float toX;
  private float toY;
  private float toZ;
  private float z;
  private float xAngle;
  private float yAngle;
  private float zAngle;
  private float size;
  private PVector location;
  private PVector velocity;
  private PVector newLocation;
  private PVector slope;
  private boolean canRemove;
  public Bullet(float toX, float toY)
  {
    this.toX=toX;
    this.toY=toY;
    newLocation= new PVector(toX,toY);
    location= new PVector(width/2,2*height/3,500);
    velocity= new PVector(0,0,10);
    slope= new PVector(0,0);
    toZ=-1200;
    z=abs(toZ);
    calculate();
    size=20;
  }
  public void display()
  {
    shapeMode(CENTER);
    pushMatrix();
    fill(255,0,0);
    noStroke();
    translate(location.x,location.y,location.z);
    sphere(size);
    popMatrix();
  } 
  void movement()
  {
    location.add(slope);
    if(location.z<-1300)
    {
      canRemove=true;
    }
  }
  void calculate()
  {
    /*println(z+" "+toY);
    float test=z/toY;
    xAngle=acos(test);
    zAngle=acos(z/toX);
    println(xAngle+" "+zAngle);*/
    slope.x=(newLocation.x-location.x)/55;
    slope.y=(newLocation.y-location.y)/45;
    slope.z=-11;
  }
  public float getX(){return location.x;}
  public float getY(){return location.y;}
  public float getZ(){return location.z;}
  public float getSize(){return size;}
  public boolean canRemove(){return canRemove;}
  public void shouldRemove(){canRemove=true;}
}
