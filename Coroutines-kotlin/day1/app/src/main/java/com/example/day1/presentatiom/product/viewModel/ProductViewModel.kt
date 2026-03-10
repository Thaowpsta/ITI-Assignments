package com.example.day1.presentatiom.product.viewModel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.day1.data.ProductRepository
import com.example.day1.data.network.RetrofitClient
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

class ProductViewModel : ViewModel() {

    private val repository = ProductRepository(RetrofitClient.apiService)

    private val _uiState = MutableStateFlow<ProductState>(ProductState.Loading)
    val uiState: StateFlow<ProductState> = _uiState.asStateFlow()

    init {
        fetchProducts()
    }

    private fun fetchProducts() {
        viewModelScope.launch {
            repository.fetchProductsFlow().collect { state ->
                _uiState.value = state
            }
        }
    }
}