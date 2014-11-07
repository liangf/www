#include <iostream>

using namespace std;


class Solution {
public:
    void merge(int A[], int m, int B[], int n) {
        int i = m-1;
        int j = n-1;
        int k = m+n-1;
        
        for (; i>=0 && j>=0; k--) {
            if (B[j] > A[i]) {
                A[k] = B[j];
                j--;
            }
            else {
                //cout << "<=" << endl;
                A[k] = A[i];
                i--;
            }
        }
        while (j >= 0) {
            A[k] = B[j];
            k--;
            j--;
        }
		//cout << m << ", " << n << endl;		
		//for (int z=0; z<m+n; z++) cout << A[z] << endl;
    } 
};

int main()
{

    int A[] = {1,1,2,2,3,3};
    int B[] = {1,1,2,2,3};
    const int m = 6;    
    const int n = 5;
    
    Solution s;
    s.merge(A, m, B, n);
    cout << m << " " << n << endl;
    for (int z=0; z<m+n; z++) cout << A[z] << endl;

	return 0;
}