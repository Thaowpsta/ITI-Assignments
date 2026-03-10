package com.example.mvvm.data.products.datasource.remote

import com.example.mvvm.data.products.model.Product


interface NetworkProductResponse {
    fun onSuccess(products: List<Product>)
    fun onFailure(msg: String)
}