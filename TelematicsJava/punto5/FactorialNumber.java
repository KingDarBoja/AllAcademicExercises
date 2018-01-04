package punto5;

import java.math.BigDecimal;
import java.math.BigInteger;

/**
 *
 * @author Manuel Bojato
 */
public class FactorialNumber {
    
    private final int inputInt;

    public FactorialNumber(int inputInt) {
        this.inputInt = inputInt;
    }

    public int getInputInt() {
        return inputInt;
    }
    
    public BigInteger getFactorial() {
        BigInteger inc = new BigInteger("1");
        BigInteger fact = new BigInteger("1");
        if (inputInt == 0) {
            return inc;
        } else {
            for (int c = 1 ; c <= inputInt ; c++ ) {
                fact = fact.multiply(inc);
                inc = inc.add(BigInteger.ONE);
            }
            return fact;
        }
    }
    
    public double getEuler(int n) {
        BigInteger d1;        
        double f = 1;
        double e = 1;
        for ( int i=1; i <= n; i++) {
            d1 = getFactorial(i);            
            f =  1.0 /d1.doubleValue();
            if ( f == 0 ) break;
            e += f;            
        }
        return e;
    }
    
    public double getEulerX(int n,int x) {
        BigInteger d1;        
        double f = 1;
        double e = 1;
        for ( int i=1; i <= n; i++) {
            d1 = getFactorial(i);         
            f =  Math.pow(x, i) /d1.doubleValue();
            if ( f == 0 ) break;
            e += f;            
        }
        return e;
    }

    private BigInteger getFactorial(int i) {
        BigInteger inc = new BigInteger("1");
        BigInteger fact = new BigInteger("1");
        if (i == 0) {
            return inc;
        } else {
            for (int c = 1 ; c <= i ; c++ ) {
                fact = fact.multiply(inc);
                inc = inc.add(BigInteger.ONE);
            }
            return fact;
        }
    }
}
