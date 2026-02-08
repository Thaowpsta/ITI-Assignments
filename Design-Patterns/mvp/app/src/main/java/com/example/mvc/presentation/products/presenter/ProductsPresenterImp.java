package com.example.mvc.presentation.products.presenter;

import android.content.Context;
import com.example.mvc.data.products.ProductRepository;
import com.example.mvc.data.products.model.Product;
import com.example.mvc.presentation.products.view.ProductsView;
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers;
import io.reactivex.rxjava3.schedulers.Schedulers;

public class ProductsPresenterImp implements ProductsPresenter {
    ProductsView productsView;
    ProductRepository repository;

    public ProductsPresenterImp(Context context, ProductsView view){
        productsView = view;
        repository = new ProductRepository(context);
    }

    @Override
    public void getProducts(){
        productsView.showLoading();
        repository.getProducts()
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(
                        products -> {
                            productsView.hideLoading();
                            productsView.setProducts(products);
                        },
                        throwable -> {
                            productsView.hideLoading();
                            productsView.showError(throwable.getMessage());
                        }
                );
    }

    @Override
    public void addToFavorite(Product product){
        repository.addToFavorite(product)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(() -> productsView.onAddToFavSuccessfully());
    }
}