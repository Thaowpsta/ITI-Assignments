package com.example.mvvm.data.products.datasource.local

import android.content.Context
import com.example.mvvm.data.db.AppDatabase
import com.example.mvvm.data.products.model.Product
import io.reactivex.rxjava3.core.Completable
import io.reactivex.rxjava3.core.Flowable
import kotlinx.coroutines.flow.Flow

class ProductsLocalDatasource(context: Context) {
    private val productDao = AppDatabase.getInstance(context).productDao()

    fun getFavoriteProducts(): Flow<List<Product>> {
        return productDao.getAllProducts()
    }

    suspend fun insertProduct(product: Product) {
        productDao.insertProduct(product)
    }

    suspend fun deleteProduct(product: Product) {
        productDao.deleteProduct(product)
    }}