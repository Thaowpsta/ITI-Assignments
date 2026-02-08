package com.example.mvc.data.products;

import android.content.Context;
import com.example.mvc.data.products.datasource.local.ProductsLocalDatasource;
import com.example.mvc.data.products.datasource.remote.ProductsRemoteDatasource;
import com.example.mvc.data.products.model.Product;
import java.util.List;
import io.reactivex.rxjava3.core.Completable;
import io.reactivex.rxjava3.core.Flowable;
import io.reactivex.rxjava3.core.Single;

public class ProductRepository {
    ProductsLocalDatasource productsLocalDatasource;
    ProductsRemoteDatasource productsRemoteDatasource;

    public ProductRepository(Context context) {
        this.productsLocalDatasource = new ProductsLocalDatasource(context);
        this.productsRemoteDatasource = new ProductsRemoteDatasource();
    }

    public Single<List<Product>> getProducts(){
        return productsRemoteDatasource.getProductsService();
    }

    public Completable addToFavorite(Product product){
        return productsLocalDatasource.insertProduct(product);
    }

    public Completable deleteFromFavorite(Product product){
        return productsLocalDatasource.deleteProduct(product);
    }

    public Flowable<List<Product>> getFavoriteProducts(){
        return productsLocalDatasource.getFavoriteProducts();
    }
}