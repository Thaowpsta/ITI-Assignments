package com.example.mvc.datasource.local;

import android.content.Context;

import androidx.lifecycle.LiveData;

import com.example.mvc.db.AppDatabase;
import com.example.mvc.model.Product;

import java.util.List;

public class ProductsLocalDatasource {
    private ProductDAO productDAO;

    public ProductsLocalDatasource(Context context){
        productDAO = AppDatabase.getInstance(context).productDAO();
    }

    public void insertProduct(Product product){
        new Thread(new Runnable() {
            @Override
            public void run() {
                productDAO.insertProduct(product);
            }
        }).start();
    }

    public void deleteProduct(Product product){
        new Thread(new Runnable() {
            @Override
            public void run() {
                productDAO.deleteProduct(product);
            }
        }).start();
    }

    public LiveData<List<Product>> getAllProducts(){
        return productDAO.getAllProducts();
    }
}
