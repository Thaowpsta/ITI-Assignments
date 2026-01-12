package com.mycompany.lab1;

import java.util.Objects;

public class Task {
    private String name;
    private int id;
    private boolean isActive;

    public Task(int id, String name, boolean isActive) {
        this.id = id;
        this.name = name;
        this.isActive = isActive;
    }

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    public boolean isIsActive() {
        return isActive;
    }

    
    @Override
    public String toString() {
        return "Task{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}
