/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package com.mycompany.day2;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mycompany.day2.model.Library;
import jakarta.json.Json;
import jakarta.json.JsonArray;
import jakarta.json.JsonObject;
import jakarta.json.JsonReader;
import jakarta.json.JsonWriter;
import jakarta.json.bind.Jsonb;
import jakarta.json.bind.JsonbBuilder;
import jakarta.json.bind.JsonbConfig;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 *
 * @author thaowpstasaiid
 */
public class Day2 {

    public static void main(String[] args) {

        String jContent = "";

        try {
            jContent = new String(Files.readAllBytes(Paths.get("lab1.json")));
        } catch (IOException e) {
            e.printStackTrace();
            return;
        }

        System.out.println("--- JSON-P ---");
        try (JsonReader reader = Json.createReader(new StringReader(jContent))) {

            JsonObject lib = reader.readObject();

            System.out.println("--- OLD DATA ---");
            printLibraryDataP(lib);

            JsonObject book = lib.getJsonObject("book");

            JsonObject newRoot = Json.createObjectBuilder(lib).add("book", Json.createObjectBuilder(book).add("author", Json.createObjectBuilder().add("name", "Thaowpsta JSON-P"))).build();

            try (JsonWriter writer = Json.createWriter(new FileOutputStream("lab1.json"))) {
                writer.writeObject(newRoot);
                System.out.println("Success! Author name updated From JSON-P");
            }

            System.out.println("--- NEW DATA ---");
            printLibraryDataP(newRoot);

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("");

        System.out.println("--- JSON-B ---");
        JsonbConfig config = new JsonbConfig();
        Jsonb jsonb = JsonbBuilder.create(config);
        
        try (FileInputStream readFile = new FileInputStream("lab1.json")) {

            Library lib = jsonb.fromJson(readFile, Library.class);

            System.out.println("--- OLD DATA ---");
            printLibraryData(lib);

            lib.getBook().getAuthor().setName("Thaowpsta JSON-B");

            //Byte Stream
            try (FileOutputStream writeFile = new FileOutputStream("lab1.json")) {
                jsonb.toJson(lib, writeFile);
                System.out.println("Success! Author name updated From JSON-B");
            }

            System.out.println("--- NEW DATA ---");
            printLibraryData(lib);

        } catch (Exception e) {
            e.printStackTrace();
        }

        System.out.println("");

        System.out.println("--- Gson ---");
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        try (FileReader reader = new FileReader("lab1.json")) {

            Library lib = gson.fromJson(reader, Library.class);

            System.out.println("--- OLD DATA ---");
            printLibraryData(lib);

            lib.getBook().getAuthor().setName("Thaowpsta Gson");

            //Character Stream
            try (FileWriter writer = new FileWriter("lab1.json")) {
                gson.toJson(lib, writer);
                System.out.println("Success! Author name updated From Gson");
            }

            System.out.println("--- NEW DATA ---");
            printLibraryData(lib);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // JSON-P
    private static void printLibraryDataP(JsonObject lib) {
        try {
            JsonArray parts = lib.getJsonObject("book").getJsonArray("parts");
            JsonObject firstPart = parts.getJsonObject(0);
            JsonArray chapters = firstPart.getJsonArray("chapters");
            String chapTitle = chapters.getJsonObject(0).getString("title");
            String authorName = lib.getJsonObject("book").getJsonObject("author").getString("name");

            System.out.println("Library Location: " + lib.getString("location"));
            System.out.println("First Chapter: " + chapTitle);
            System.out.println("Author Name: " + authorName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // JSON-B & GSON
    private static void printLibraryData(Library lib) {
        System.out.println("Library Location: " + lib.getLocation());
        System.out.println("First Chapter: " + lib.getBook().getParts().get(0).getChapters().get(0).getTitle());
        System.out.println("Author Name: " + lib.getBook().getAuthor().getName());
    }
}
