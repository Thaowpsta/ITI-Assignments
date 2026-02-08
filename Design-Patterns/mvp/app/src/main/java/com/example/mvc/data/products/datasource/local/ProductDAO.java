package com.example.mvc.data.products.datasource.local;

import androidx.room.Dao;
import androidx.room.Delete;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;
import com.example.mvc.data.products.model.Product;
import java.util.List;
import io.reactivex.rxjava3.core.Completable;
import io.reactivex.rxjava3.core.Flowable;

@Dao
public interface ProductDAO {
    @Insert(onConflict = OnConflictStrategy.IGNORE)
    Completable insertProduct(Product product);

    @Delete
    Completable deleteProduct(Product product);

    @Query("SELECT * FROM fav_products")
    Flowable<List<Product>> getFavoriteProducts();
}