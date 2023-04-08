import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class test {
    public static void main(String[] args) {
        test t = new test();
        
        System.out.println(t.join(t.changeArr()));
    }
String join(List<String>  l){

String word="";
for (String i : l) {
    word+=i;
}
return word;

}
    List<String> names = new ArrayList<String>();

    public int length() {
        return names.size();
    }

     String[] chars = { "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s", "d", "f", "g", "h", "j", "k", "l",
            "z", "x", "c", "v", "b", "n", "m", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F",
            "G", "H", "J", "K", "L", "Z", "X", "C", "V", "B", "N", "M", "{", "}", "[", "]", "!", "@", "#", "$", "%",
            "^", "&", "*", "(", ")", "|", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", };
            Random rand = new Random();

    List<String> changeArr() {
        for (int i = 0; i < chars.length; i++) {
            String word="";
            for (int j = 0; j < i; j++){

                int n = rand.nextInt(i+1);
                word+=chars[n];
            }
            names.add(word);


        }
        return names;
    }
}