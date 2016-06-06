#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

/**
 * Auto-generated code below aims at helping you parse
 * the standard input according to the problem statement.
 **/
int main()
{
	int currentMax = -1, maxLoss = 0;

    int n;
    cin >> n; cin.ignore();
    for (int i = 0; i < n; i++) {
        int v, loss ;
        cin >> v; cin.ignore();
        currentMax < v ?  currentMax = v : NULL ;
        loss = currentMax - v ;
        loss > maxLoss ? maxLoss = loss : NULL ;
    }

    // Write an action using cout. DON'T FORGET THE "<< endl"
    // To debug: cerr << "Debug messages..." << endl;

    cout << -maxLoss << endl;
}
