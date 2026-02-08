package com.example.mvc.data.network;

import com.example.mvc.data.products.model.ProductResponse;

import io.reactivex.rxjava3.core.Single;
import retrofit2.Call;
import retrofit2.http.GET;

public interface ProductService {

    @GET("products")
    Single<ProductResponse> getProducts();
}
