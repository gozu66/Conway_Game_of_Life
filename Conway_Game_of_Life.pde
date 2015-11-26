boolean[][] board;
boolean[][] boardBuffer;
boolean isPaused = true;
int boardWidth = 50, boardHeight = 50;
int cellWidth = 10, cellHeight = 10;
color alive, dead, grid;

void setup()
{
  alive = color(0f, 200f, 50f);
  grid = color(50);
  dead = color(0);

  size(boardWidth * cellWidth, boardHeight * cellHeight);
  stroke(grid);

  board = new boolean[boardHeight][boardWidth];
  boardBuffer = new boolean[boardHeight][boardWidth];
//  cellWidth = width / boardWidth;
//  cellHeight = height / boardHeight;  
}

void draw()
{ 
  background(dead);
  iterate();
  drawCells();
  
  if(mousePressed)
  {
    board[mouseX/cellHeight][mouseY/cellWidth] = !board[mouseX/cellHeight][mouseY/cellWidth]; 
  }

//  println(frameRate);  
  
//  if(frameCount % 10 == 0)
//  {
//    saveFrame("life-#####");
//  }
}

void iterate()
{
  if(!isPaused && frameCount % 5 == 0)
  {
   println("Generation : " + frameCount);
   for(int r = 0 ; r < board.length ; r++)
   {
     for(int c = 0 ; c < board.length ; c++)
     {
       boardBuffer[r][c] = board[r][c];
     }
   }
   
  for(int r = 0 ; r < board.length ; r++)
  {
    for(int c = 0 ; c < board.length ; c++)
    {
      if(boardBuffer[r][c] == true)
      {
        if(countCells(r,c) < 2 || countCells(r,c) > 3)
        {
          board[r][c] = false; 
        } 
      } 
      else 
      {
      if(countCells(r,c) == 3)
      {
        board[r][c] = true;
      }
     }
    }
   }
  }
}

void drawCells()
{ 
  for(int r = 0 ; r < board.length ; r++)
  {
    for(int c = 0 ; c < board.length ; c++)
    {
      if(board[r][c] == true)
      {
        fill(alive);
        rect(r * cellHeight, c * cellWidth, cellWidth, cellHeight);
      }
    }
  }
}

int countCells(int row, int col)
{  
  int count = 0;
  for(int _row = row -1; _row <= row +1; _row++)
  {
    for(int _col = col - 1; _col <= col + 1; _col++)
    {
      if(_row >= 0 && _col >= 0 && _row < board.length && _col < board.length)
      {
        if(!(_row == row && _col == col))
        {
          if(boardBuffer[_row][_col] == true)
          {
            count++;
          }
        }
      }
    }
  }
  return count;
}

//void mouseDragged()
//{
//  board[mouseX/cellHeight][mouseY/cellWidth] = !board[mouseX/cellHeight][mouseY/cellWidth];
//}

void keyPressed()
{
  if(key == 'r')
  {
    randomiseCells();
  }
  else if(key == ' ')
  {
    pause();
  }
  else if(key == 'e')
  {
    erase();
  }else if(key == '1')
  {
    createPattern(1);
  }
  
}

void erase()
{
  for(int r = 0 ; r < board.length ; r++)
  {
    for(int c = 0 ; c < board.length ; c++)
    {
      board[r][c] = false;
    }
  }
}

void pause()
{
  isPaused = !isPaused;
}

void randomiseCells()
{
  frameCount = 0;
  float probability = 20;
  
  for(int r = 0; r < board.length ; r++)
  {
    for(int c = 0 ; c < board.length ; c++)
    {
      float rnd = random(100);
      if(rnd < probability)
      {
        board[r][c] = true;
      }
    }
  }
}

void createPattern(int index)
{
  if(index == 1)
  {
    int x = mouseX/cellHeight;
    int y = mouseY/cellWidth;
    for(int row = x; row < x+5; row++)
    {
      for(int col = y; col < y+4; col++)
      {
        if(row > 0 && col > 0 && row < board.length && col < board.length)
        {
          if(col == y && row != x)
          {
              board[row][col] = true;
          }else if (col == y + 1 && (row == x || row == x + 4))
          {
              board[row][col] = true;
          }else if(col == y + 2 && row == x + 4)
          {
              board[row][col] = true;
          }else if(col == y + 3 && (row == x || row == x + 3))
          {
              board[row][col] = true;
          }
        }
      }
    }

  }
}
