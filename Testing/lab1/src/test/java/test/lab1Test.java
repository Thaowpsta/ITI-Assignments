/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.lab1Test to edit this template
 */
package test;

/**
 *
 * @author thaowpstasaiid
 */

import com.mycompany.lab1.Lab1;
import com.mycompany.lab1.Task;
import java.util.ArrayList;
import java.util.stream.Stream;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Tag;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.CsvFileSource;
import org.junit.jupiter.params.provider.MethodSource;


class Lab1Test {

    private Lab1 lab = new Lab1();
    private Task task1 = new Task(1, "Task 1", true);
    private Task task2 = new Task(2, "Task 2", false);
    private Task task3  = new Task(3, "Task 3", true);

static Stream<Arguments> provideTasksData() {
        ArrayList<Task> list = new ArrayList<>();
        
        list.add(new Task(4, "Task A", true));
        list.add(new Task(5, "Task B", false));
        list.add(new Task(6, "Task C", true));

        return Stream.of(
            Arguments.of(list)
        );
    }

    @Test
    @Tag("NotParam")
    @DisplayName("Add Task")
    void testAddTask() {
        assertEquals(true, lab.addTask(task1));
    }

    @Test
    @Tag("NotParam")
    void testRemoveTask() {
        lab.addTask(task1);
        lab.addTask(task2);
        lab.addTask(task3);
        
        assertEquals(true, lab.removeTask(task1));
    }

    @ParameterizedTest
    @DisplayName("Add All Tasks From CSV file")
    @CsvFileSource(resources = "/Tasks.csv", numLinesToSkip = 1)            
    void testAddAllTask(int id, String name, boolean active) {
        ArrayList<Task> newTasks = new ArrayList<>();
//        newTasks.add(task1);
//        newTasks.add(task2);
//        newTasks.add(task3);

        newTasks.add(new Task(id, name, active));

        
        assertEquals(true, lab.addAllTask(newTasks));
    }

    @ParameterizedTest
    @DisplayName("Remove All Tasks From Method Source")
    @MethodSource("provideTasksData")            
    void testRemoveAllTask(ArrayList<Task> tasks) {
//        lab.addTask(task1);
//        lab.addTask(task2);
//        lab.addTask(task3);
//        
        lab.addAllTask(tasks);
        
        assertEquals(true, lab.removeAllTask());
    }

    @Test
    @Tag("NotParam")
    @DisplayName("Throw exception test")
    void testRemoveAllFromEmpty() {
        
        Exception ex = assertThrows(IndexOutOfBoundsException.class, () -> {
            lab.removeAllTask();
        });

        assertEquals("List is empty", ex.getMessage());
    }
    
    @Test
    @Tag("NotParam")
    void testGetActiveTasks() {
        lab.addTask(task1);
        lab.addTask(task2);
        lab.addTask(task3);

        assertEquals(2, lab.getActiveTasks().size());
    }

    @Test
    @Tag("NotParam")
    void testGetTotalNumberOfTasks() {

        lab.addTask(task1);
        lab.addTask(task2);
        
        assertEquals(2, lab.getTotalNumberOfTasks());
    }
}

