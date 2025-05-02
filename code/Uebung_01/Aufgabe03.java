import java.util.Random;

public class Aufgabe03 {
    public static void main(String[] args) {
        var maximum = 10000;
        
        System.out.println("Exercise A: " + exerciseA(maximum) + " Exercise B: " + exerciseB(maximum));

        //printFileContent(exerciseA(maximum), exerciseB(maximum));
    }

    private static int exerciseA(int maximum) {
        final var numberToMatch = 46;
        var iterationCounter = 0;
        var randomNumber = 0;

        do {
            randomNumber = new Random().nextInt(maximum);
            iterationCounter++;
        } while (randomNumber != numberToMatch);

        return iterationCounter;
    }

    private static int exerciseB(int maximum) {
        var seenNumbers = new boolean[maximum];
        var iterationCounter = 0;
        var collisionDetected = false;

        while (!collisionDetected) {
            int randomNumber = new Random().nextInt(maximum);

            if (seenNumbers[randomNumber]) {
                collisionDetected = true;
            } else {
                seenNumbers[randomNumber] = true;
                iterationCounter++;
            }
        }

        return iterationCounter;
    }

    private static void printFileContent(int countIterationsA, int countIterationsB) {
        try (var writer = new java.io.FileWriter("aufgabe_03.txt", true)) {
            var sumA = 0.0; 
            var sumB = 0.0;
            var countA = 0;
            var countB = 0;

            var formattedTime = java.time.LocalDateTime.now().getHour() + ":" + 
                java.time.LocalDateTime.now().getMinute();

            var filePath = java.nio.file.Paths.get("aufgabe_03.txt");
            var lines = java.nio.file.Files.exists(filePath) 
                ? java.nio.file.Files.readAllLines(filePath) 
                : java.util.Collections.<String>emptyList();

            for (var line : lines) {
                for (var linePart : line.split(", ")) {
                    if (linePart.startsWith("Iterations exc. a: ")) {
                    sumA += Integer.parseInt(linePart.split(": ")[1]);
                    countA++;
                    } else if (linePart.startsWith("Iterations exc. b: ")) {
                    sumB += Integer.parseInt(linePart.split(": ")[1]);
                    countB++;
                    }
                }
            }

            double averageA = countA > 0 ? sumA / countA : 0;
            double averageB = countB > 0 ? sumB / countB : 0;

            writer.write("Date/Time: " + 
            formattedTime +
            ", Iterations exc. a: " + countIterationsA +  
            ", Iterations exc. b: " + countIterationsB + 
            ", Avg. exc. a: " + averageA + 
            ", Avg. exc. b: " + averageB + 
            "\n");
        } catch (java.io.IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }
}
