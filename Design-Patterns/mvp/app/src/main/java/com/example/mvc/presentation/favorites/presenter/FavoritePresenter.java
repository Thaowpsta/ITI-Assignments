package com.example.mvc.presentation.favorites.presenter;

import com.example.mvc.data.products.model.Product;

import java.util.List;

import io.reactivex.rxjava3.core.Completable;
import io.reactivex.rxjava3.core.Flowable;

public interface FavoritePresenter {

    Flowable<List<Product>> getFavoriteProducts();
    Completable deleteFavoriteProduct(Product product);
}
