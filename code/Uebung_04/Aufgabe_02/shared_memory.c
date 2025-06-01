/*
  P-Operation: "passeren": Prozess versucht, zugang zu einem kritischen Bereucht (shared Memory zu bekommen),
                           Wenn Wert des Semaphors > 0 ist, wird er um 1 verkleinert und darf fortfahren.
                           Wenn Wer des Semaphors 0 ist, wird er blockiert, bis er wieder > 0 wird

  V-Operation: "vrijgeven": Gibt Zugriff wieder frei, signalisiert, dass ein Prozess fertig ist
                            Semaphor wird um 1 erhöht
                            Falls Prozesse warten (wegen früherer P-Operation), kann einer weitermachen 


*/


#define N_DATA 2000000
#define N_SHARED 2000