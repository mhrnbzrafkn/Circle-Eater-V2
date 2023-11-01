GameENV env; //<>//

void setup() {
  size(400, 400);
  env = new GameENV();
}

void draw() {
  background(0);
  
  env.Draw();
}

void keyPressed() {
  if (keyCode == LEFT) {
    env.agent.StepToLeft();
  } else if (keyCode == RIGHT) {
    env.agent.StepToRight();
  } else if (keyCode == UP) {
    env.agent.StepToUp();
  } else if (keyCode == DOWN) {
    env.agent.StepToDown();
  }
}

void keyReleased() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    env.agent.HorizontalRelease();
  }
  if (keyCode == UP || keyCode == DOWN) {
    env.agent.VerticalRelease();
  }
}
