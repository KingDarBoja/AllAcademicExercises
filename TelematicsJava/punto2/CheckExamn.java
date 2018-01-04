/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package punto2;

import java.util.Arrays;
import javax.swing.JOptionPane;

/**
 *
 * @author Manuel Bojato
 */
public class CheckExamn {

    private final int examInt;
    private final String stdString; 
        
    public CheckExamn(int examInt, String stdString) {
        this.examInt = examInt;
        this.stdString = stdString;
    }

    public int getExamInt() {
        return examInt;
    }
    
    public String getStdString() {
        return stdString;
    }

    private int[] evalCount() {
        int numExam[] = new int[examInt];
        int sum = 0;
        do {
            for (int i = 1; i<=examInt; i++) {
                String gradeWeight = JOptionPane.showInputDialog(null, "Ingrese el porcentaje de la evaluación N°" + i, "Porcentaje de evaluaciones", JOptionPane.INFORMATION_MESSAGE);  
                numExam[i-1] = Integer.parseInt(gradeWeight); 
                sum = numExam[i-1] + sum;
            }
            if (sum != 100) {                
                JOptionPane.showMessageDialog(null, "Error, la suma esta incompleta o excede el 100%. Suma obtenida: " + sum +"\n"
                + "Porcentaje evaluaciones ingresado: " + Arrays.toString(numExam));
                sum = 0;
            }
        } while (sum != 100);
        return numExam;
    }
    
    public String resultExam() {
        int[] exWeight = evalCount();
        double prom = 0;
        for (int i = 1; i <= exWeight.length; i++) {
            String gradeNum = JOptionPane.showInputDialog(null,"Ingrese la calificación de la evaluación N°" + i,"Calificaciones de valuaciones", JOptionPane.INFORMATION_MESSAGE);  
            prom = (Double.valueOf(exWeight[i-1])/100)*Double.parseDouble(gradeNum) + prom;            
        }
        prom = Math.floor(prom * 100)/100;
        if (prom >= 3) {
            return "El estudiante " + getStdString().toUpperCase() + " obtuvo una calificación de " + prom + "\n" + "El estudiante pasó la materia.";
        } else {
            return "El estudiante " + getStdString().toUpperCase() + " obtuvo una calificación de " + prom + "\n" + "El estudiante NO pasó la materia.";
        }        
    }    
}
