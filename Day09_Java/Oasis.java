import java.util.ArrayList;

public class Oasis {

    public ArrayList<Long> Integers;

    public Oasis(String oasis) {
        Integers = new ArrayList<Long>();

        String[] arr = oasis.split(" ", -1);

        for(String number : arr) {
            Integers.add(Long.parseLong(number));
        }
    }
    
    public static Oasis fromReverse(String oasis) {
        var temp = new ArrayList<Long>();
        var integers = new ArrayList<Long>();
        String[] arr = oasis.split(" ", -1);

        for(String number : arr) {
            temp.add(Long.parseLong(number));
        }

        for(int i = (temp.size()-1); i >= 0; i--) {
            integers.add(temp.get(i));    
        }

        return new Oasis(integers);
    }

    private Oasis(ArrayList<Long> oasis) {
        Integers = oasis;
    }

    public long Calculate() {
        ArrayList<Long> newOasis = new ArrayList<Long>();
        boolean isAllZero = true;

        for(int i = 0; i < (Integers.size() - 1); i++) {
            long value = Integers.get(i+1) - Integers.get(i);

            isAllZero = isAllZero && (value == 0);
            newOasis.add(value);
        }

        if(isAllZero) {
            return Integers.get(Integers.size() - 1);
        }

        long value = Integers.get(Integers.size() - 1);
        long result = value + new Oasis(newOasis).Calculate();

        return result;
    }
}