#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>

int MAX_RED = 12;
int MAX_GREEN = 13;
int MAX_BLUE = 14;
int GAME_ID = 1;
int SUM = 0;

bool parseLine(std::string line) {
    std::stringstream ss(line);
    std::vector<std::string> words;
    std::string word;
    int wordCounter = 0;

    while (std::getline(ss, word, ' ')) {
        words.push_back(word);
        wordCounter++;
    }

    for (int i = 2; i < wordCounter; i += 2) {
        std::string numWord = words.at(i);
        std::string color = words.at(i + 1);

        int num = std::stoi(numWord);
        if (num < MAX_RED) {
            continue;
        } 

        if (color.substr(0, 3) == "red" && num > MAX_RED) {
            return false;
        }

        if (color.substr(0, 4) == "blue" && num > MAX_BLUE) {
            return false;
        }

        if (color.substr(0, 5) == "green" && num > MAX_GREEN) {
            return false;
        }

    }

    return true;
}


int main() {
    // Open the file
    std::ifstream file("input1.txt");

    // Check if the file is open
    if (!file.is_open()) {
        std::cerr << "Could not open the file!" << std::endl;
        return 1; // Return an error code
    }

    // Read the file line by line
    std::string line;
    while (std::getline(file, line)) {
        // Process the line
        std::cout << line << std::endl;
        if (parseLine(line)) {
            SUM += GAME_ID;
            std::cout << SUM << std::endl;
        }


        GAME_ID++;
    }

    // Close the file
    file.close();

    return 0;
}
