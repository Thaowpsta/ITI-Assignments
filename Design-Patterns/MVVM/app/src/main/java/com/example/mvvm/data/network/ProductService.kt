package com.example.mvvm.data.network

import com.example.mvvm.data.products.model.ProductResponse
import io.reactivex.rxjava3.core.Single
import retrofit2.http.GET

interface ProductService {

    @GET("products")
    suspend fun getProducts(): ProductResponse
}