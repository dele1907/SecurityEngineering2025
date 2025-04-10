import java.util.HashSet;
import java.util.Random;

public class Aufgabe_03 {
    static final int N = 10000;
    static final int ITERATIONS = 1000;
    static final Random random = new Random();

    public static void main(String[] args) {
        int totalA = 0;
        for (int i = 0; i < ITERATIONS; i++) {
            int y = random.nextInt(N);
            totalA += excerciseA(N, y);
        }
        double averageA = (double) totalA / ITERATIONS;
        System.out.printf("3a: Durchschnitt nach %d Läufen: %.2f%n", ITERATIONS, averageA);

        int totalB = 0;
        for (int i = 0; i < ITERATIONS; i++) {
            totalB += excerciseB(N);
        }
        double averageB = (double) totalB / ITERATIONS;
        System.out.printf("3b: Durchschnitt nach %d Läufen: %.2f%n", ITERATIONS, averageB);
    }

    private static int excerciseA(int n, int y) {
        int counter = 0;
        int guess;
        do {
            guess = random.nextInt(n);
            counter++;
        } while (guess != y);
        return counter;
    }

    private static int excerciseB(int n) {
        HashSet<Integer> seenNumbers = new HashSet<>();
        int counter = 0;
        while (true) {
            int guess = random.nextInt(n);
            counter++;
            if (seenNumbers.contains(guess)) {
                break;
            }
            seenNumbers.add(guess);
        }
        return counter;
    }
}