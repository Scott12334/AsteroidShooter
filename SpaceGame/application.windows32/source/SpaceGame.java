import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SpaceGame extends PApplet {

ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
PImage target;
Star[] stars;
Bullet test;
PVector targetPos;
public void setup()
{
  
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
    stars[i]= new Star(random(-(width/1.7f),width*2),random(-(height/1.7f),height*2),random(10));
  }
  target= loadImage("Target.png");
}
public void draw()
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
public void mouseReleased()
{
  if(mouseButton==LEFT)
  {
    bullets.add(new Bullet(targetPos.x,targetPos.y));
  }
}
public void newAsteroids()
{
  //x,y,scale,rX,rY,rZ
  asteroids.add(new Asteroid(random(width),random(height),random(-1200,-700),random(30,100),random(10),random(10),random(10)));
}
public void target()
{
  imageMode(CENTER); 
  image(target,targetPos.x,targetPos.y);
  targetPos.x=mouseX;
  targetPos.y=mouseY;
}
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
  public void display()
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
  public void movement()
  {
    //move foward
    z+=3;
    //rotate
    rotateX-=0.02f;
  }
  public boolean isShot(float bX,float bY,float bZ,float bSize)
  {
    if(dist(bX,bY,bZ,x-scale,y,z)<bSize+(scale*1.2f))
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
    sphere(scale*1.2f);
    popMatrix();
  }
  public boolean canRemove(){return remove;}
  public void shouldRemove(){remove=true;}
}
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
  public void movement()
  {
    location.add(slope);
    if(location.z<-1300)
    {
      canRemove=true;
    }
  }
  public void calculate()
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
  public void display()
  {
    pushMatrix();
    fill(255);
    translate(x,y,-1300);
    circle(0,0,radius);
    popMatrix();
  }
}
  public void settings() {  size(1000,1000, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SpaceGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
