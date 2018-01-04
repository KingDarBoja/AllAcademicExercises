package punto5;

import javax.swing.JOptionPane;

/**
 *
 * @author Manuel Bojato
 */
public class Punto5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int inputInt = 0;
        int inpEul = 0;
        int inpEul2 = 0;
        int xNum = 0;
        do {         
            String inpNum = JOptionPane.showInputDialog(null,"Ingrese un número entero POSITIVO: ","Calculo de Factorial",JOptionPane.INFORMATION_MESSAGE);
            try{
                inputInt  = Integer.parseInt(inpNum);                
            }catch(NumberFormatException e){
                JOptionPane.showMessageDialog(null, "Error, el usuario no ingreso un entero - " + e.getMessage());
            }    
        } while (inputInt < 0); 
        
        FactorialNumber factNum = new FactorialNumber(inputInt);
        JOptionPane.showMessageDialog(null,"Factorial de "  + inputInt + " es " + factNum.getFactorial());
        
        do {         
            String eulNum = JOptionPane.showInputDialog(null,"Ingrese un número entero POSITIVO: ","Calculo de Euler", JOptionPane.INFORMATION_MESSAGE);
            try{
                inpEul  = Integer.parseInt(eulNum);                
            }catch(NumberFormatException e){
                JOptionPane.showMessageDialog(null, "Error, el usuario no ingreso un entero - " + e.getMessage());
            }    
        } while (inpEul < 0);
        
        FactorialNumber eulerNum = new FactorialNumber(inpEul);
        JOptionPane.showMessageDialog(null,"Valor de Euler para "  + inpEul + " es " + eulerNum.getEuler(inpEul));
        
        do {         
            String eulNum2 = JOptionPane.showInputDialog(null,"Ingrese un número entero POSITIVO: ","Calculo de Euler a la X", JOptionPane.INFORMATION_MESSAGE);
            String inpX = JOptionPane.showInputDialog(null,"Ingrese un número entero POSITIVO para X: ","Calculo de Euler a la X", JOptionPane.INFORMATION_MESSAGE);
            try{
                inpEul2 = Integer.parseInt(eulNum2);
                xNum  = Integer.parseInt(inpX);                
            }catch(NumberFormatException e){
                JOptionPane.showMessageDialog(null, "Error, el usuario no ingreso un entero - " + e.getMessage());
            }    
        } while (inpEul2 < 0 && xNum < 0);
        
        FactorialNumber eulerNum2 = new FactorialNumber(inpEul2);
        JOptionPane.showMessageDialog(null,"Valor de Euler^x para "  + inpEul2 + " con x igual a " + xNum + " es " + eulerNum2.getEulerX(inpEul,xNum));
    }    
}
