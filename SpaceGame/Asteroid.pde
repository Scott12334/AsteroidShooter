public class Asteroid
{
  PShape Asteroid;
  float x;
  float y;
  float scale;
  float rotateY;
  float rotateZ;
  float rotateX;
  float z;
  boolean remove;
  public Asteroid(float x, float y, float z,float scale,float rotateX,float rotateY, float rotateZ)
  {
    Asteroid=loadShape("AsteroidV2.obj");
    this.x=x;
    this.y=y;
    this.scale=scale;
    Asteroid.scale(scale);
    Asteroid.setTextureMode(NORMAL);
    this.rotateY=rotateY;
    this.rotateZ=rotateZ;
    this.rotateX=rotateX;
    this.z=z;
  }
  void display()
  {
    pushMatrix();
    lights();
    shapeMode(CENTER);
    translate(x,y,z);
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
  public boolean isShot(float bX,float bY,float bZ,float bSize)
  {
    if(dist(bX,bY,bZ,x-scale,y,z)<bSize+(scale*1.2))
    {
      return true;
    }
    return false;
  }
  public void sphereTest()
  {
    pushMatrix();
    shapeMode(CENTER);
    translate(x-scale,y,z);
    rotateX(rotateX);
    sphere(scale*1.2);
    popMatrix();
  }
  public boolean canRemove(){return remove;}
  public void shouldRemove(){remove=true;}
}
