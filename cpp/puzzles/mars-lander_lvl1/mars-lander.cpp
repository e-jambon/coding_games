#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <stdlib.h>  


using namespace std;




int main()
{
    int surfaceN; // the number of points used to draw the surface of Mars.
    cin >> surfaceN; cin.ignore();
    for (int i = 0; i < surfaceN; i++) {
        int landX; // X coordinate of a surface point. (0 to 6999)
        int landY; // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
        cin >> landX >> landY; cin.ignore();
    }


	int maxLandingSpeed = 40;

    // game loop
    while (true) {
        int X;
        int Y;
        int hSpeed; // the horizontal speed (in m/s), can be negative.
        int vSpeed; // the vertical speed (in m/s), can be negative.
        int fuel; // the quantity of remaining fuel in liters.
        int rotate; // the rotation angle in degrees (-90 to 90).
        int power; // the thrust power (0 to 4).
        cin >> X >> Y >> hSpeed >> vSpeed >> fuel >> rotate >> power; cin.ignore();


    if (vSpeed != 0) {
    	int timeToImpact = ( vSpeed + sqrt( pow(vSpeed,2) + 2 * (Y - 100 ) ) ) / 3.711 ;
    	int timeToSlow = ( (abs(vSpeed) - maxLandingSpeed) / 0.289 );
    	if (timeToImpact <= timeToSlow) {
    		power = 4;
    	}
    }
    cout << "0 " ;
    cout << power << endl ;
    }
}
