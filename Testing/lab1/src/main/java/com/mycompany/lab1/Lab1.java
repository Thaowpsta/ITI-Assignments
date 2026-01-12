/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 */
package com.mycompany.lab1;

import java.util.ArrayList;

/**
 *
 * @author thaowpstasaiid
 */
public class Lab1 {

    public ArrayList<Task> tasks = new ArrayList<Task>();

    public boolean addTask(Task t) {
        int size = tasks.size();

        tasks.add(t);

        if (tasks.size() == (size + 1)) {
            return true;
        } else {
            return false;
        }
    }

    public boolean removeTask(Task t) {
        int size = tasks.size();

        tasks.remove(t);

        return tasks.size() == (size - 1);
    }

    public boolean addAllTask(ArrayList<Task> t) {
        int size = tasks.size();

        for (Task task : t) {
            tasks.add(task);
        }

        if (tasks.size() == (size + t.size())) {
            return true;
        } else {
            return false;
        }
    }

    public boolean removeAllTask() {

        if (tasks.isEmpty()) {
            throw new IndexOutOfBoundsException("List is empty");
        } else {
            tasks.clear();
        }

        return tasks.isEmpty();
    }

    public ArrayList<Task> getActiveTasks() {
        ArrayList<Task> activeatedTasks = new ArrayList<Task>();

        for (Task task : tasks) {
            if (task.isIsActive()) {
                activeatedTasks.add(task);
            }
        }

//        System.out.println(activeatedTasks);
        return activeatedTasks;
    }

    public int getTotalNumberOfTasks() {
        return tasks.size();
    }

    public static void main(String[] args) {
//        System.out.println("Hello World!");
    }
}
