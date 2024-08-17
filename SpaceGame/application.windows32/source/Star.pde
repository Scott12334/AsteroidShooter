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
    translate(x,y,-1300);
    circle(0,0,radius);
    popMatrix();
  }
}
