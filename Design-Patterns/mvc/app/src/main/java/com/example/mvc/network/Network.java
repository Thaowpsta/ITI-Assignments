package com.example.mvc.network;

import com.example.mvc.model.Product;

import java.util.List;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class Network {

    private ProductService productService;
    private static Network instance;
    private static Retrofit retrofit;

    private Network(){}
    public static Network getInstance(){
        if (instance == null){
            instance = new Network();
            retrofit = new Retrofit.Builder()
                    .baseUrl("https://dummyjson.com/")
                    .addConverterFactory(GsonConverterFactory.create())
                    .build();
        }
        return instance;
    }
    public ProductService getProducts(){

        productService = retrofit.create(ProductService.class);
        return productService;
    }
}
