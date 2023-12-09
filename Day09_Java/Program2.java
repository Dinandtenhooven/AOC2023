import java.io.File;  // Import the File class
import java.io.FileNotFoundException;  // Import this class to handle errors
import java.util.Scanner; // Import the Scanner class to read text files
import java.util.ArrayList;

public class Program2 {

    public static void main(String[] args) throws FileNotFoundException {
        ArrayList<Oasis> todayIsGonnaBeTheDay = ReadFile();
        long finalResult = 0;

        for(Oasis oasis : todayIsGonnaBeTheDay) {
            long result = oasis.Calculate();
            System.out.println("------");
            System.out.println(result);
            finalResult += result;
        }
        
        System.out.println("------");
        System.out.println(finalResult);
    }

    public static ArrayList<Oasis> ReadFile() throws FileNotFoundException {
        ArrayList<Oasis> Wonderwall = new ArrayList<Oasis>();
        File myObj = new File("input.txt");
        Scanner myReader = new Scanner(myObj);

        while (myReader.hasNextLine()) {
            String data = myReader.nextLine();
            Oasis oasis = Oasis.fromReverse(data);

            Wonderwall.add(oasis);
        }

        return Wonderwall;
    }
}