package hello;

import hello.MyGreetUtil;
import mylib.ThirdParty;

public class MyEntryPoint {

    public static void main(String[] args) {

        System.out.println("Hello World!");

        String name = args.length > 0 ? args[0] : "Stranger";

        MyGreetUtil.greet(name);

        ThirdParty.says();

    }
}

