package punto2;

import javax.swing.JOptionPane;

/**
 *
 * @author Manuel Bojato
 */
public class Punto2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
      // Input fields and validation case
      int examInt = 0;
      String student = JOptionPane.showInputDialog("Ingrese el nombre del estudiante: ");
        // Validation loop for examn number field in case user doesn't write a integer greater than zero.
        do {         
            String exam = JOptionPane.showInputDialog("Ingrese la evaluación: ");
            try{
                examInt = Integer.parseInt(exam);
                if (examInt == 0) {
                    JOptionPane.showMessageDialog(null, "Ingrese un número entero mayor a cero", "Incorrecto", JOptionPane.ERROR_MESSAGE);
                } 
            }catch(NumberFormatException e){
                JOptionPane.showMessageDialog(null, "Error, el usuario no ingreso un entero - " + e.getMessage());
            }    
        } while (examInt < 1);  
        
        CheckExamn resQual = new CheckExamn(examInt,student);
        String finMsg = resQual.resultExam();        
        System.out.println(finMsg);
    }
    
}
