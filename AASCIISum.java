import java.util.*;
public class AASCIISum{
    public static void main(String args[]){
        Scanner sc = new Scanner(System.in);
        String s = sc.nextLine();
        System.out.println(maxSum(s));
    }
    public static int maxSum(String s){
        int esum = 0;
        int osum = 0;
        for(int i=0;i<s.length();i++){
            if(i % 2 == 0){
                esum += (int) s.charAt(i);
            }
            else{
                osum += (int) s.charAt(i);
            }
        }
        return esum >= osum ? esum : osum;
    }
}