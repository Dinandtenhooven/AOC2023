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

int parseLine(std::string line) {
    std::stringstream ss(line);
    std::vector<std::string> words;
    std::string word;
    int wordCounter = 0;

    int maxRed = 0;
    int maxBlue = 0;
    int maxGreen = 0;

    while (std::getline(ss, word, ' ')) {
        words.push_back(word);
        wordCounter++;
    }

    for (int i = 2; i < wordCounter; i += 2) {
        std::string numWord = words.at(i);
        std::string color = words.at(i + 1);

        int num = std::stoi(numWord);

        if (color.substr(0, 3) == "red") {
            maxRed = num > maxRed ? num : maxRed;
        }

        if (color.substr(0, 4) == "blue") {
            maxBlue = num > maxBlue ? num : maxBlue;
        }

        if (color.substr(0, 5) == "green") {
            maxGreen = num > maxGreen ? num : maxGreen;
        }

    }

    return maxGreen * maxBlue * maxRed;
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
        int result = parseLine(line);

        SUM += result;
        std::cout << SUM << " :: " << result << std::endl;
    }

    // Close the file
    file.close();

    return 0;
}
