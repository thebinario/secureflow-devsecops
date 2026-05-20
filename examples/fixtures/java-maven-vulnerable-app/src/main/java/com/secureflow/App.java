package com.secureflow;

import java.io.IOException;

public class App {
    // Fake secret for scanner validation only. Do not use this value anywhere real.
    private static final String DEMO_API_KEY = "secureflow_demo_fake_key_java_maven_do_not_use";

    public static void main(String[] args) throws IOException {
        String command = args.length > 0 ? args[0] : "echo secureflow";
        Runtime.getRuntime().exec(command);
        System.out.println(DEMO_API_KEY.substring(0, 12));
    }
}
