public class GameENV {
  private Agent[] agents;
  private int NumberOfAgents = 100;
  private int NumberOfSelectedAgents = 10;
  private int NumberOfGenerations = 1;
  private int MaxReachedScore = 0;
  
  private int timer = 0;
  private float maxTimer = 10000;
  private int timeSpent = 0;
  
  public GameENV() {
    agents = new Agent[NumberOfAgents]; //<>//
    
    for (int i = 0; i < agents.length; i++) {
      agents[i] = new Agent();
    }
    
    timer = millis();
  }
  
  public void Draw() {
    //Initial Game
    for (int i = 0; i < agents.length; i++) {
      if (!agents[i].isAgentGameOver) {
        agents[i].Draw();
      }
    }
    
    //Action
    for (int i = 0; i < agents.length; i++) {
      if (!agents[i].isAgentGameOver) {
        agents[i].Action();
      }
    }
    
    //Regenerate Population //<>//
    timeSpent = millis() - timer;
    
    if (CountAliveAgents() <= 0 || timeSpent > maxTimer) {
      NumberOfGenerations++;
      
      Agent[] bestAgents = FindBestAgents(NumberOfSelectedAgents);
      agents = new Agent[NumberOfAgents];
      
      for (int i = 0; i < NumberOfSelectedAgents / 2; i++) {
        Agent childAgent = new Agent();
        bestAgents[i].nn.combine(bestAgents[i + 1].nn);
        childAgent.nn = bestAgents[i].nn;
        agents[i] = childAgent;
      }
      
      for (int i = NumberOfSelectedAgents / 2; i < NumberOfAgents; i++) {
        agents[i] = new Agent();
      }
      
      timer = millis();
    }
    
    int bestAgentIndex = FindBestAgentIndex();
    
    // Display Game Information
    fill(50, 50, 50, 225);
    rect(10, 5, 265, 100);
    fill(255);
    textSize(15);
    text("Generation: " + NumberOfGenerations, 20, 20);
    text("Alive Agents: " + CountAliveAgents(), 20, 40);
    text("Best Agent Score: " + agents[bestAgentIndex].score, 20, 60);
    if (agents[bestAgentIndex].score > MaxReachedScore) {
      MaxReachedScore = agents[bestAgentIndex].score;
    }
    text("Max Reached Score: " + MaxReachedScore, 20, 80);
    text("Timer Spent: " + (maxTimer - timeSpent) + "ms / " + maxTimer + "ms", 20, 100);
    
    //END OF DRAW
  }
  
  public Agent[] RemoveElementAtIndex(Agent[] agents, int index) {
    if (index < 0 || index >= agents.length) { //<>//
      return agents;
    }
    
    Agent[] newAgents = new Agent[agents.length - 1];
    for (int i = 0, j = 0; i < agents.length; i++) {
      if (i != index) {
        newAgents[j] = agents[i];
        j++;
      }
    }
    
    return newAgents;
  }
  
  public int CountAliveAgents() {
    int counter = 0;
    for (int i = 0; i < agents.length; i++) {
      if (!agents[i].isAgentGameOver) {
        counter++;
      }
    }
    
    return counter;
  }
  
  public Agent[] FindBestAgents(int count) {
    Agent[] bestAgents = new Agent[count];
    for (int i = 0; i < bestAgents.length; i++) {
      bestAgents[i] = agents[0];
      for (int j = 0; j < agents.length; j++) {
        //Select Best Agent
        if (agents[i].score > bestAgents[i].score && agents[i].timeSpent < bestAgents[i].timeSpent) {
          bestAgents[i] = agents[i];
          agents = RemoveElementAtIndex(agents, i);
        }
      }
    }
    
    return bestAgents;
  }
  
  public int FindBestAgentIndex() {
    int bestAgentIndex = 0; //<>//
    Agent bestAgent = agents[0];
    
    for (int i = 0; i < agents.length; i++) {
      if (agents[i].score > bestAgent.score) {
        bestAgent = agents[i];
        bestAgentIndex = i;
      }
    }
    
    return bestAgentIndex;
  }
}
