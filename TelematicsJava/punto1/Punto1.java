package punto1;

import java.util.Scanner;

/**
 *
 * @author Manuel Bojato
 */
public class Punto1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Main Code - Input fields for lower and upper integer and validation logic.
        String continString;        
        int valNum[] = new int[2];
        do {  
            // Read each input field (2 integers)
            Scanner inpField = new Scanner(System.in);
            for (int i = 0; i<2; i++) {
                // Verify if it is a integer, can't be cero.
                do {
                    if (i == 0) {
                        System.out.println("Introduzca un número entero positivo como limite inferior: ");
                    } else {
                        System.out.println("Introduzca un número entero positivo como limite superior: ");
                    }                    
                    while (!inpField.hasNextInt()) {
                        System.out.println("¡No es un número entero!");
                        System.out.println("Introduzca un número entero positivo: ");
                        inpField.next();                    
                    }
                    valNum[i] = inpField.nextInt();
                } while (valNum[i] <= 0);
            }    
            // Calculate the prime numbers between the specified range
            CheckPrime numPrime = new CheckPrime(valNum[0], valNum[1]);            
            System.out.println(numPrime.isPrime());
            // If the user wants to test again a different range, press "s" to continue (Case sensitive)
            System.out.println("¿Desea continuar ingresando datos? s: Sí, cualquier otra tecla: No");
            Scanner startField = new Scanner(System.in);
            continString = startField.nextLine();
        } while ("s".equals(continString));            
    }
    
}
