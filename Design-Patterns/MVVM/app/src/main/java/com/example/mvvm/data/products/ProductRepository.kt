package com.example.mvvm.data.products

import android.content.Context
import com.example.mvvm.data.products.datasource.local.ProductsLocalDatasource
import com.example.mvvm.data.products.datasource.remote.ProductsRemoteDatasource
import com.example.mvvm.data.products.model.Product
import com.example.mvvm.data.products.model.ProductResponse
import kotlinx.coroutines.flow.Flow

class ProductRepository(context: Context) {
    private val remoteDatasource = ProductsRemoteDatasource()
    private val localDatasource = ProductsLocalDatasource(context)

    suspend fun getRemoteProducts(): ProductResponse = remoteDatasource.getProducts()
    fun getFavoriteProducts(): Flow<List<Product>> = localDatasource.getFavoriteProducts()
    suspend fun insertProduct(product: Product) = localDatasource.insertProduct(product)
    suspend fun deleteProduct(product: Product) = localDatasource.deleteProduct(product)
}