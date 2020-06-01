#include <iostream>
#include <bitset>
#include <fstream>
#include <ostream>
#include <string>
using namespace std;

//immediate value is always on the second 16 bit
//Effective address has part of it in the rest of part1 and the rest in part2

bitset<16> getRange(bitset<32> set, int begin, int end) {
	bitset<16> subset;
	int indx = 0;
	for (int i = begin; i < end; i++) {
		subset[indx] = set[i];
		indx++;
	}
	return subset;
}

string toUpper(string s) {
	for (int i = 0; i < s.size(); i++) {
		s[i] = toupper(s[i]);
	}
	return s;
}

string deleteComment(string s) {
	for (int i = 0; i < s.size(); i++) {
		if (s[i] != ' ') {
			s = s.substr(i, s.size() - i);
			break;
		}
	}

	for (int i = 0; i < s.size(); i++) {
		if (s[i] == '#')
			return s.substr(0, i);
	}
	return s;
}

string cleanBefore(string s) {
	for (int i = 0; i < s.size(); i++) {
		if (s[i] != ' ' && s[i] != ',') {
			s = s.substr(i, s.size() - i);
			break;
		}
	}
	return s;
}

string getOpcode(string s) {
	string opcode = "";
	for (int i = 0; i < s.size(); i++) {
		if (s[i] != ' ') {
			opcode.push_back(s[i]);
		}
		else
			return opcode;
	}
	return s;
}

string getOperand(string s) {
	string firstOperand = "";
	for (int i = 0; i < s.size(); i++) {
		if (s[i] == ' ' || s[i] == ',' || s[i] == '\t') {
			return firstOperand;
		}
		else
			firstOperand.push_back(s[i]);
	}
	return s;
}

int main()
{
	string name;
	cout << "please enter the filename that you need to assemble with .txt extension and type it with the name" << endl;
	cin >> name;
	ifstream inFile;
	inFile.open(name);
	if (!inFile) {
		cerr << "Unable to open file datafile.txt";
		exit(1);   // call system to stop
	}
	ofstream instruction("instruction.txt");
	ofstream data("data.txt");


	string line;
	bool p2;
	int imm, EA, l = 0;
	bitset<16> part1, part2;
		
	//inFile >> s;
	while (getline(inFile, line)) {
		line = toUpper(line);
		line = deleteComment(line);
		if (line == "")
			continue;
		string s = getOpcode(line);
		line = line.substr(s.size(), line.size() - (s.size()));

		part1 = 0000000000000000;
		part2 = 0000000000000000;
		p2 = false;
		if (s == "NOT") {
			part1[15] = 0; part1[14] = 0; part1[13] = 0; part1[12] = 0; part1[11] = 1;
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
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

			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			imm = stoi(s, 0, 16);
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "SUB") {
			part1[15] = 0; part1[14] = 1; part1[13] = 0; part1[12] = 1; part1[11] = 1;
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			imm = stoi(getOperand(line), 0, 16);
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "SHR") {
			p2 = true;
			part1[15] = 0; part1[14] = 1; part1[13] = 1; part1[12] = 1; part1[11] = 1;
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			imm = stoi(getOperand(line), 0, 16);
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "PUSH") {
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 0; part1[11] = 0;
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
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

			line = cleanBefore(line);
			imm = stoi(getOperand(line), 0, 16);
			bitset<16> bImm(imm);
			part2 = bImm;
		}
		else if (s == "LDD") {
			p2 = true;
			part1[15] = 1; part1[14] = 0; part1[13] = 0; part1[12] = 1; part1[11] = 1;
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			EA = stoi(getOperand(line), 0, 16);
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
			line = cleanBefore(line);
			s = getOperand(line);
			line = line.substr(s.size(), line.size() - (s.size()));
			if (s == "R0,") {
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

			line = cleanBefore(line);
			EA = stoi(getOperand(line), 0, 16);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			s = getOperand(line);
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
			line = cleanBefore(line);
			EA = stoi(getOperand(line), 0, 16);
			if (EA == 0 || EA == 2) {
				getline(inFile, line);
				imm = stoi(deleteComment(line), 0, 16);
				bitset<32> bImm(imm);
				part1 = getRange(bImm, 16, 32);
				part2 = getRange(bImm, 0, 16);
				data << part1 << endl << part2 << endl;
			}
			else {
				while (l < EA) {
					instruction << part1 << endl;
					l++;
				}
			}
		}

		if (s != ".ORG") {
			instruction << part1 << endl;
			l++;
			if (p2) {
				l++;
				instruction << part2 << endl;
			}
		}
	}

	inFile.close();
	instruction.close();
	data.close();

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
