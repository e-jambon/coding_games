#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;
int main()
{
    int lightX; // the X position of the light of power
    int lightY; // the Y position of the light of power
    int initialTX; // Thor's starting X position
    int initialTY; // Thor's starting Y position
    cin >> lightX >> lightY >> initialTX >> initialTY; cin.ignore();
    string direction = "";

    if ( 3 < 4 < 5) { cout << "TRUE" << endl ;} else { cout<< "false" << endl ; }

    // game loop
    while (1) {
        int remainingTurns; // The remaining amount of turns Thor can move. Do not remove this line.
        cin >> remainingTurns; cin.ignore();
        direction = "";
        if ( 0 <= initialTY <= lightY-1 ){
            direction += "S" ;
            ++initialTY ;
        }
        else if ( lightY+1 <= initialTY <= 17 ) {
            direction += "N";
            --initialTX ;
        }

        if ( 0 <= initialTX <= lightX-1 ) {
            direction += "E";
            ++initialTX;
        } else if ( lightX+1 <= initialTX <=39 ) {
            direction += "W";
            --initialTX ;
        }

        cout << direction << endl;
    }
}
