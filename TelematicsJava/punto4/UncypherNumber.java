/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package punto4;

import java.util.Arrays;

/**
 *
 * @author Manuel Bojato
 */
public class UncypherNumber {
    
    private final int cypInt;

    public UncypherNumber(int cypInt) {
        this.cypInt = cypInt;
    }    

    public int getCypInt() {
        return cypInt;
    }
    
    private int[] unModNumber() {
        int[] unmodDigit = unSwapNumber();        
        for (int i=0; i < 4; i++) {
            unmodDigit[i] = unmodDigit[i] + 3;
            if (unmodDigit[i] > 10) {
                unmodDigit[i] = unmodDigit[i] - 10;
            } 
        }        
        return unmodDigit;
    }
    
    private int[] unSwapNumber() {                 
        int[] cypDigit = new int[4];
        for (int i = 0; i < 4; i++) {
            cypDigit[i] =  (int) (( cypInt / Math.pow(10.0, i) ) % 10);
        }
        // Extra for cycle in order to reverse the array
        for (int start = 0, end = cypDigit.length - 1; start <= end; start++, end--) {
            int aux = cypDigit[start];
            cypDigit[start]=cypDigit[end];
            cypDigit[end]=aux;
        } 
        int unswapDigit[] = {cypDigit[2],cypDigit[3],cypDigit[0],cypDigit[1]};     
        return unswapDigit;        
    }
    
    public String resultCypther() {
        int[] rs = unModNumber();        
        StringBuilder strBuilder = new StringBuilder();
        for (int i = 0; i < rs.length; i++) {
           strBuilder.append(rs[i]);
        }
        String resString = strBuilder.toString();        
        return resString;
    }
    
}
