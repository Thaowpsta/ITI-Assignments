package com.example.mvc.data.db;

import android.content.Context;

import androidx.room.Database;
import androidx.room.Room;
import androidx.room.RoomDatabase;

import com.example.mvc.data.products.datasource.local.ProductDAO;
import com.example.mvc.data.products.model.Product;

@Database(entities = {Product.class}, version = 1)
public abstract class AppDatabase extends RoomDatabase {
    public abstract ProductDAO productDAO();
    private static AppDatabase instance;

    public static AppDatabase getInstance(Context context) {
        if(instance == null){
           instance = Room.databaseBuilder(context, AppDatabase.class, "DB").build();
        }
        return instance;
    }
}
