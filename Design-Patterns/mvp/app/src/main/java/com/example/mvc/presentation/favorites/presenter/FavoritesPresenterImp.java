package com.example.mvc.presentation.favorites.presenter;

import android.content.Context;
import com.example.mvc.data.products.ProductRepository;
import com.example.mvc.data.products.model.Product;
import java.util.List;
import io.reactivex.rxjava3.core.Completable;
import io.reactivex.rxjava3.core.Flowable;

public class FavoritesPresenterImp implements FavoritePresenter {
    ProductRepository repository;

    public FavoritesPresenterImp(Context context) {
        repository = new ProductRepository(context);
    }

    @Override
    public Flowable<List<Product>> getFavoriteProducts() {
        return repository.getFavoriteProducts();
    }

    @Override
    public Completable deleteFavoriteProduct(Product product) {
        return repository.deleteFromFavorite(product);
    }
}