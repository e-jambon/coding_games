#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

#define MAX(a, b) ((a > b) ? a : b)

using namespace std;

int main()
{
    unsigned short int mountain  ;
    unsigned short int maxHeight ;
    // 1 is always
    while (1) {
         maxHeight = 0;
         mountain = 0;
        for (unsigned short int i = 0; i < 8; i++) {
            unsigned short int mountainH ;
            cin >> mountainH;  cin.ignore();
            if ( maxHeight <  mountainH )  {
                maxHeight = mountainH ;
                mountain = i ;
            }

        }
        cout << mountain << endl;
    }
}
