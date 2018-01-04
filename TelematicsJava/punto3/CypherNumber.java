package punto3;

import java.util.Arrays;

/**
 *
 * @author Manuel Bojato
 */
public class CypherNumber {
    
    private final int cypInt;

    public CypherNumber(int cypInt) {
        this.cypInt = cypInt;
    }

    public int getCypInt() {
        return cypInt;
    }
    
    private int[] splitNumber() {
        int[] newDigit = new int[4];
        // Getting the module in order to split the number into 4 independent digits.
        for (int i = 0; i < 4; i++) {
            newDigit[i] =  (int) (( cypInt / Math.pow(10.0, i) ) % 10) + 7;
        }
        // Extra for cycle in order to reverse the array
        for (int start = 0, end = newDigit.length - 1; start <= end; start++, end--) {
            int aux = newDigit[start];
            newDigit[start]=newDigit[end];
            newDigit[end]=aux;
        }        
        return newDigit;
    }
    
    private int[] modSwapNumber() {             
        int[] modNum = splitNumber();
        for (int i=0; i < 4; i++) {
            modNum[i] = modNum[i] % 10;
        }
        int swapDigit[] = {modNum[2],modNum[3], modNum[0],modNum[1]};
        return swapDigit;        
    }
    
    public String resultCypther() {
        int[] rs = modSwapNumber();        
        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < rs.length; i++) {
           strBuilder.append(rs[i]);
        }
        String resString = strBuilder.toString();        
        return resString;
    }
}
