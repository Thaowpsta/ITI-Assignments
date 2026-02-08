package com.example.mvc.data.products.datasource.local;

import android.content.Context;
import com.example.mvc.data.db.AppDatabase;
import com.example.mvc.data.products.model.Product;
import java.util.List;
import io.reactivex.rxjava3.core.Completable;
import io.reactivex.rxjava3.core.Flowable;

public class ProductsLocalDatasource {
    private ProductDAO productDAO;

    public ProductsLocalDatasource(Context context){
        productDAO = AppDatabase.getInstance(context).productDAO();
    }

    public Completable insertProduct(Product product){
        return productDAO.insertProduct(product);
    }

    public Completable deleteProduct(Product product){
        return productDAO.deleteProduct(product);
    }

    public Flowable<List<Product>> getFavoriteProducts(){
        return productDAO.getFavoriteProducts();
    }
}