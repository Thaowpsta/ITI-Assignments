package com.example.day1.data

import com.example.day1.data.network.ProductService
import com.example.day1.presentatiom.product.viewModel.ProductState
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.flowOn

class ProductRepository(private val apiService: ProductService) {

    fun fetchProductsFlow(): Flow<ProductState> = flow {
        emit(ProductState.Loading)

        val response = apiService.getProducts()

        emit(ProductState.Success(response.products))

    }.catch { e ->
        emit(ProductState.Error(e.toString()))
    }.flowOn(Dispatchers.IO)
}