package com.example.showcasephone.uitils;

import java.util.regex.Pattern;

public class ValidateProduct {
    public static final String REGEX_NAME = "^[\\p{L} ]+$";
    public static final String REGEX_PRICE = "^-?\\d+[,.?\\d+]*$";
    public static final String REGEX_IDPHONE = "^[1-9]$";
    public static boolean isName(String name){
        return Pattern.matches(REGEX_NAME,name);
    }
    public static boolean isPrice(String price){
        return Pattern.matches(REGEX_PRICE,price);
    }
    public static boolean isIdPhone(String idPhone){return Pattern.matches(REGEX_IDPHONE,idPhone);}
}
