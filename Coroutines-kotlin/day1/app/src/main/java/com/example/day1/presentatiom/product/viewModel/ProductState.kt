package com.example.day1.presentatiom.product.viewModel

import com.example.day1.data.product.model.Product

sealed class ProductState {
    object Loading : ProductState()
    data class Success(val products: List<Product>) : ProductState()
    data class Error(val message: String) : ProductState()
}