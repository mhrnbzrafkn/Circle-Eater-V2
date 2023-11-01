public class GameENV {
  private Agent agent;
  private Food food;
  private int max_score = 0;
  private int timer = 0;
  private float max_timer = 5000;
  private int number_of_game_overs = 0;
  
  public GameENV() {
    this.food = new Food();
    this.agent = new Agent();
  }
  
  public void Draw() {
    //Initial Game
    agent.Draw();
    food.Draw();
    
    //Action
    agent.Action(food.x, food.y);
    
    //Start Timer
    var timeSpent = millis() - timer;
    
    //Check Max Score
    if (agent.score > max_score) {
      max_score = agent.score;
    }
    
    // Reset game If Max Time Runs Out
    if (timeSpent > max_timer) {
      //DoTheGameOver();
      number_of_game_overs++;
      food.Respown();
      agent.Respown();
      agent.score = 0;
      timer = millis();
    }
    
    // Check for collision with food
    if (agent.CheckCollision(food.x, food.y, food.size)) {
      food.Respown();
      agent.score++;
      timer = millis();
    }
    
    // Update player position based on speed
    agent.Draw();
    
    // Display Game Information
    fill(255);
    textSize(15);
    text("Game Overs: " + number_of_game_overs, 20, 20);
    text("Max score: " + max_score, 20, 40);
    text("Score: " + agent.score, 20, 60);
    text("Time Left: " + (max_timer - timeSpent) + "ms / " + max_timer +"ms", 20, 80);
    
    //END OF DRAW
  }
}
