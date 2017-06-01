/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

/**
 *
 * @author DUONG
 */
public class Vigenere {

    //Mã hóa Vigenere
    public static String nguon = "aáàạảãăắằặẳẵâấầậẩẫbcdđeéèẹẻẽêếềệểễfghiíìịỉĩjklmnoóòọỏõôốồộổỗơớờợởỡpqrstuúùụủũưứừựửữvwxyAÁÀẠẢÃĂẮẰẶẲẴÂẤẦẬẨẪBCDĐEÉÈẸẺẼÊẾỀỆỂỄFGHIÍÌỊỈĨJKLMNOÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠPQRSTUÚÙỤỦŨƯỨỪỰỬỮVWXY0123456789~`!@#$%^&*()-_.:;,/?<>[]{}=+ ";
    public static char[] P = nguon.toCharArray();

    public static int[] taokhoa(String vao, int[] key) {
        char[] banro = vao.toCharArray();
        int l = banro.length;
        int[] plant = new int[l];
        for (int i = 0; i < l; i++) {

            plant[i] = key[i % key.length];
        }
        return plant;

    }

    public static int[] chuyenmakey(String s) {
        char[] banro = s.toCharArray();
        int l = banro.length;
        int[] temp = new int[l];
        int[] roso = new int[l];
        int j = 0;
        while (j < l) {
            for (int i = 0; i < P.length; i++) {
                if (P[i] == banro[j]) {
                    roso[j] = i;
                    temp[j] = roso[j];
                }
            }
            j++;
        }

        return temp;
    }

    public static String Giaima(String s, int[] khoa) {
        char[] lengt = s.toCharArray();
        int l = lengt.length;
        // int[] khoa = taokhoa(s, k);
        int[] roso = new int[l];
        char[] temp = new char[l];
        int maso;
        for (int j = 0; j < l; j++) {
            for (int i = 0; i < P.length; i++) {
                if (P[i] == lengt[j]) {
                    roso[j] = i;
                    maso = ((roso[j] + P.length) - khoa[j]) % P.length;
                    temp[j] = P[maso];
                }
            }
        }

        String tg = new String(temp);
        return tg;
    }

    public static void main(String[] args) {
        System.out.println(Vigenere.Giaima(AllConstant.Mail_Password,Vigenere.taokhoa(AllConstant.Mail_Password, Vigenere.chuyenmakey(AllConstant.Mail_Key))));
    }

}
