GameENV env;

void setup() {
  size(800, 800);
  env = new GameENV(); //<>//
}

void draw() {
  background(0);
  
  env.Draw();
}
