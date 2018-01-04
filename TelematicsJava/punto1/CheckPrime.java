package punto1;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Manuel Bojato
 * 
 */
class CheckPrime {

    private final int value1, value2;    
    
    public CheckPrime(int value1, int value2) {
        this.value1 = value1;
        this.value2 = value2;
    }

    public int getValue1() {
        return value1;
    }

    public int getValue2() {
        return value2;
    }    
    
    public List<Integer> isPrime() {
        int flag = 0, i, j;
        List<Integer> primeArray = new ArrayList<>();
        for(i = value1; i <= value2; i++) {
            for( j = 2; j < i; j++) {
                if(i % j == 0) {
                    flag = 0;
                    break;
                } else {
                    flag = 1;                    
                }                
            }
            if (flag == 1) {
                primeArray.add(i);
            }
        }
        return primeArray;
    }
   
}
