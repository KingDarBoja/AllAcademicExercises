package punto4;

import javax.swing.JOptionPane;

/**
 *
 * @author Manuel Bojato
 */
public class Punto4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // Main code for data uncypher of four digit number.
        int cypInt = 0, cypLen = 0;        
        // Validation loop for examn number field in case user doesn't write a integer greater than zero.
        // Also it check if it has four digits.
        do {       
            String cypherNum = JOptionPane.showInputDialog(null,"Ingrese el número de cuatro digitos: ", "Cifrado de datos", JOptionPane.INFORMATION_MESSAGE);
            try{
                cypInt = Integer.parseInt(cypherNum); 
                cypLen = cypherNum.length();
                if (cypInt <= 0 || cypLen !=4) {
                    JOptionPane.showMessageDialog(null, "Ingrese un número de cuatro digitos positivo", "Incorrecto", JOptionPane.ERROR_MESSAGE);
                }                
            }catch(NumberFormatException e){
                JOptionPane.showMessageDialog(null, "Error, el usuario no ingreso un entero - " + e.getMessage(), "Error!" , JOptionPane.ERROR_MESSAGE);
            }    
        } while (cypInt < 1 || cypLen != 4);  
        
        UncypherNumber cypNum = new UncypherNumber(cypInt);
        JOptionPane.showMessageDialog(null,"Número Descifrado: " + cypNum.resultCypther());
    }
    
}
