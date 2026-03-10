package com.example.day1.data.network

import com.example.day1.data.product.model.ProductResponse
import retrofit2.http.GET

interface ProductService {
    @GET("products")
    suspend fun getProducts(): ProductResponse
}