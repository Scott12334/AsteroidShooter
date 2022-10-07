int w1Width;
int w1Height;
SecondApplet sa;
FirstApplet fa;
void setup()
{
  surface.setResizable(true);
  w1Width=600;
  w1Height=600;
  surface.setLocation(0,0);
  String[] args = {"YourSketchNameHere"};
  sa = new SecondApplet();
  fa= new FirstApplet();
  PApplet.runSketch(args, sa);
  PApplet.runSketch(args, fa);
}
