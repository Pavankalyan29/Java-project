import java.util.*;
public class AASCIISum{
    public static void main(String args[]){
        String s = "Helloworld";
        System.out.println(maxSum(s));
    }
    public static int maxSum(String s){
        int esum = 0;
        int osum = 0;
        s = s.toLowerCase();
        for(int i=0;i<s.length();i++){
            if(i % 2 == 0){
                esum += (int) s.charAt(i);
            }
            else{
                osum += (int) s.charAt(i);
            }
        }
        int result =esum >= osum ? esum : osum;
        // return esum >= osum ? esum : osum;
        return result;
    }
}