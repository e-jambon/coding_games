#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;



int main()
{
    int road; // the length of the road before the gap.
    cin >> road; cin.ignore();
    int gap; // the length of the gap.
    cin >> gap; cin.ignore();
    int platform; // the length of the landing platform.
    cin >> platform; cin.ignore();

    string action = "" ;

    while (1) {
        int speed; // the motorbike's speed.
        cin >> speed; cin.ignore();
        int coordX; // the position on the road of the motorbike.
        cin >> coordX; cin.ignore();

        action = "WAIT" ;
  		if ( speed < gap+1) {action = "SPEED";}
  		if (coordX+speed == road+gap) {action = "JUMP";}
  		if ((speed>gap+1)||(coordX >= road+gap)) {action = "SLOW";}



        cout << action << endl;
    }
}
