package com.example.mvc.datasource.local;

import androidx.lifecycle.LiveData;
import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

import com.example.mvc.model.Product;

import java.util.List;

@Dao
public interface ProductDAO {

    @Insert(onConflict = OnConflictStrategy.IGNORE)
    void insertProduct(Product product);

    @Delete
    void deleteProduct(Product product);

    @Query("SELECT * FROM fav_products")
    LiveData<List<Product>> getAllProducts();
}
