package com.example.mvvm.data.products.model

import com.google.gson.annotations.SerializedName

data class ProductResponse(
    @SerializedName("products")
    val products: List<Product>
)