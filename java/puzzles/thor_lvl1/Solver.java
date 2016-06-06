package thor;

import java.util.*;

public class Solver {

	public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        int lightX = in.nextInt(); // the X position of the light of power
        int lightY = in.nextInt(); // the Y position of the light of power
        int initialTX = in.nextInt(); // Thor's starting X position
        int initialTY = in.nextInt(); // Thor's starting Y position
        String dir = new String();
        boolean onTarget = false ;
        
        while (!onTarget) {
            int remainingTurns = in.nextInt(); // The remaining amount of turns Thor can move. Do not remove this line.
        	dir = "";

        	if  ( 0 <= initialTY && initialTY < lightY ) 	{ dir += "S" ; initialTY += 1 ;  } 
        	if  ( lightY < initialTY && initialTY < 18 ) 	{ dir += "N" ; initialTY -= 1 ;  }
        	
        	if  ( 0 <= initialTX && initialTX < lightX ) 	{ dir += "E" ; initialTX += 1 ;  }
        	if  ( lightX < initialTX && initialTX < 40 ) 	{ dir += "W" ; initialTX -= 1 ;  }
        	
        	onTarget = (lightX == initialTX && lightY == initialTY) ;
            // A single line providing the move to be made: N NE E SE S SW W or NW
            System.out.println(dir);
        }
        
        in.close() ;
	}
	
	

}
