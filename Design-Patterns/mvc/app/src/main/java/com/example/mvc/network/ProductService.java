package com.example.mvc.network;

import com.example.mvc.model.Product;
import com.example.mvc.model.ProductResponse;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;

public interface ProductService {

    @GET("products")
    Call<ProductResponse> getProducts();
}
