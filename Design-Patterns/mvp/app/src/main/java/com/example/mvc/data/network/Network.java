package com.example.mvc.data.network;

import hu.akarnokd.rxjava3.retrofit.RxJava3CallAdapterFactory;
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
                    .addCallAdapterFactory(RxJava3CallAdapterFactory.create())
                    .build();
        }
        return instance;
    }

    public ProductService getProducts(){

        productService = retrofit.create(ProductService.class);
        return productService;
    }
}
