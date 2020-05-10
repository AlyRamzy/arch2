#include <iostream>inFile >> s;
#include <bitset>
#include <fstream>
#include <ostream>
using namespace std;

//immediate value is always on the second 16 bit
//Effective address has part of it in the rest of part1 and the rest in part2

int main()
{
	ifstream inFile;
	inFile.open("test2.txt");
	if (!inFile) {
		cerr << "Unable to open file datafile.txt";
		exit(1);   // call system to stop
	}
	ofstream outFile("output.txt");


	string s;
	bool p2;
	int imm, EA, line = 0;
	bitset<16> part1, part2;
	//inFile >> s;
	while (inFile >> s) {
		part1 = 0000000000000000;
		part2 = 0000000000000000;
		p2 = false;
		if (s == "NOT") {
			part1[15] = 0; part1[14] = 0; part1[13] = 0; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "INC") {
			part1[15] = 0; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 0;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "DEC") {
			part1[15] = 0; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 1;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "OUT") {
			part1[15] = 0; part1[14] = 0; part1[13] = 1; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "IN") {
			part1[15] = 0; part1[14] = 0; part1[13] = 1; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "SWAP") {
			part1[15] = 0; part1[14] = 1; part1[13] = 0; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}
		}
		else if (s == "ADD") {
			part1[15] = 0; part1[14] = 1; part1[13] = 0; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}

			inFile >> s;
			if (s == "R0") {
				part1[4] = 0; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R1") {
				part1[4] = 0; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R2") {
				part1[4] = 0; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R3") {
				part1[4] = 0; part1[3] = 1; part1[2] = 1;
			}
			else if (s == "R4") {
				part1[4] = 1; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R5") {
				part1[4] = 1; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R6") {
				part1[4] = 1; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R7") {
				part1[4] = 1; part1[3] = 1; part1[2] = 1;
			}
		}
		else if (s == "IADD") {
			p2 = true;
			part1[15] = 0; part1[14] = 1; part1[13] = 0; part1[12] = 1; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}

			inFile >> imm;
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "SUB") {
			part1[15] = 0; part1[14] = 1; part1[13] = 0; part1[12] = 1; part1[11] = 1;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}

			inFile >> s;
			if (s == "R0") {
				part1[4] = 0; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R1") {
				part1[4] = 0; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R2") {
				part1[4] = 0; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R3") {
				part1[4] = 0; part1[3] = 1; part1[2] = 1;
			}
			else if (s == "R4") {
				part1[4] = 1; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R5") {
				part1[4] = 1; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R6") {
				part1[4] = 1; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R7") {
				part1[4] = 1; part1[3] = 1; part1[2] = 1;
			}
		}
		else if (s == "AND") {
			part1[15] = 0; part1[14] = 1; part1[13] = 1; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}

			inFile >> s;
			if (s == "R0") {
				part1[4] = 0; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R1") {
				part1[4] = 0; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R2") {
				part1[4] = 0; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R3") {
				part1[4] = 0; part1[3] = 1; part1[2] = 1;
			}
			else if (s == "R4") {
				part1[4] = 1; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R5") {
				part1[4] = 1; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R6") {
				part1[4] = 1; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R7") {
				part1[4] = 1; part1[3] = 1; part1[2] = 1;
			}
		}
		else if (s == "OR") {
			part1[15] = 0; part1[14] = 1; part1[13] = 1; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> s;
			if (s == "R0,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R1,") {
				part1[7] = 0; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R2,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R3,") {
				part1[7] = 0; part1[6] = 1; part1[5] = 1;
			}
			else if (s == "R4,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 0;
			}
			else if (s == "R5,") {
				part1[7] = 1; part1[6] = 0; part1[5] = 1;
			}
			else if (s == "R6,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 0;
			}
			else if (s == "R7,") {
				part1[7] = 1; part1[6] = 1; part1[5] = 1;
			}

			inFile >> s;
			if (s == "R0") {
				part1[4] = 0; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R1") {
				part1[4] = 0; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R2") {
				part1[4] = 0; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R3") {
				part1[4] = 0; part1[3] = 1; part1[2] = 1;
			}
			else if (s == "R4") {
				part1[4] = 1; part1[3] = 0; part1[2] = 0;
			}
			else if (s == "R5") {
				part1[4] = 1; part1[3] = 0; part1[2] = 1;
			}
			else if (s == "R6") {
				part1[4] = 1; part1[3] = 1; part1[2] = 0;
			}
			else if (s == "R7") {
				part1[4] = 1; part1[3] = 1; part1[2] = 1;
			}
		}
		else if (s == "SHL") {
			p2 = true;
			part1[15] = 0; part1[14] = 1; part1[13] = 1; part1[12] = 1; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> imm;
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "SHR") {
			p2 = true;
			part1[15] = 0; part1[14] = 1; part1[13] = 1; part1[12] = 1; part1[11] = 1;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> imm;
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "PUSH") {
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "POP") {
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "LDM") {
			p2 = true;
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> imm;
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "LDD") {
			p2 = true;
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 1;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> EA;
			bitset<20> BinaryEA(EA);
			for (int i = 7, j = 19; i >= 0; i--, j--) {
				part1[i] = BinaryEA[j];
			}
			for (int i = 15, j = 11; j >= 0; i--, j--) {
				part2[i] = BinaryEA[j];
			}
		}
		else if (s == "STD") {
			p2 = true;
			part1[15] = 1; part1[14] = 0; part1[13] = 1; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1,") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3,") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5,") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7,") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}

			inFile >> EA;
			bitset<20> BinaryEA(EA);
			for (int i = 7, j = 19; i >= 0; i--, j--) {
				part1[i] = BinaryEA[j];
			}
			for (int i = 15, j = 11; j >= 0; i--, j--) {
				part2[i] = BinaryEA[j];
			}
		}
		else if (s == "JZ") {
			part1[15] = 1; part1[14] = 1; part1[13] = 0; part1[12] = 0; part1[11] = 0;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "JMP") {
			part1[15] = 1; part1[14] = 1; part1[13] = 0; part1[12] = 0; part1[11] = 1;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "CALL") {
			part1[15] = 1; part1[14] = 1; part1[13] = 0; part1[12] = 1; part1[11] = 0;
			inFile >> s;
			if (s == "R0") {
				part1[10] = 0; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R1") {
				part1[10] = 0; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R2") {
				part1[10] = 0; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R3") {
				part1[10] = 0; part1[9] = 1; part1[8] = 1;
			}
			else if (s == "R4") {
				part1[10] = 1; part1[9] = 0; part1[8] = 0;
			}
			else if (s == "R5") {
				part1[10] = 1; part1[9] = 0; part1[8] = 1;
			}
			else if (s == "R6") {
				part1[10] = 1; part1[9] = 1; part1[8] = 0;
			}
			else if (s == "R7") {
				part1[10] = 1; part1[9] = 1; part1[8] = 1;
			}
		}
		else if (s == "RET") {
			part1[15] = 1; part1[14] = 1; part1[13] = 0; part1[12] = 1; part1[11] = 1;
		}
		else if (s == "RTI") {
			part1[15] = 1; part1[14] = 1; part1[13] = 1; part1[12] = 0; part1[11] = 0;
		}
		else if (s == ".ORG") {
			inFile >> EA;
			if (EA == 0 || EA == 2) {
				inFile >> imm;
				part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 0; part1[10] = 0; part1[9] = 0; part1[8] = 0; //LDM R0
				bitset<16> bImm(imm);
				part2 = bImm;
				outFile << part1 << endl << part2 << endl;
				line += 2;

				part1 = 0000000000000000;
				part2 = 0000000000000000;

				part1[15] = 1; part1[14] = 0; part1[13] = 1; part1[12] = 0; part1[11] = 0; part1[10] = 0; part1[9] = 0; part1[8] = 0; //STD R0
				bitset<20> BinaryEA(EA);
				for (int i = 7, j = 19; i >= 0; i--, j--) {
					part1[i] = BinaryEA[j];
				}
				for (int i = 15, j = 11; j >= 0; i--, j--) {
					part2[i] = BinaryEA[j];
				}
				outFile << part1 << endl << part2 << endl;
				line += 2;
			}
			else {
				while (line < EA) {
					outFile << part1 << endl;
					line++;
				}
			}
		}

		if (s != ".ORG") {
			outFile << part1 << endl;
			line++;
			if (p2) {
				line++;
				outFile << part2 << endl;
			}
		}

	}

	inFile.close();
	outFile.close();

}



// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
