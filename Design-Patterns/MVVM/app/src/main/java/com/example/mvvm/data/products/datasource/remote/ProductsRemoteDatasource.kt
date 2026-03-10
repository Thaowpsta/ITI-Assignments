package com.example.mvvm.data.products.datasource.remote

import com.example.mvvm.data.network.Network
import com.example.mvvm.data.network.ProductService
import com.example.mvvm.data.products.model.ProductResponse
import io.reactivex.rxjava3.core.Single

class ProductsRemoteDatasource {
    private val productService: ProductService = Network.retrofit.create(ProductService::class.java)

    suspend fun getProducts(): ProductResponse {
        return productService.getProducts()
    }
}