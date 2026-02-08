package com.example.mvc.data.products.model;

import com.google.gson.annotations.SerializedName;

import java.util.List;

public class ProductResponse {
    @SerializedName("products")
    private List<Product> results;
    public ProductResponse(List<Product> results){
        this.results = results;
    }

    public List<Product> getResults(){
        return results;
    }

    public void setResults(List<Product> results){
        this.results = results;
    }
}
