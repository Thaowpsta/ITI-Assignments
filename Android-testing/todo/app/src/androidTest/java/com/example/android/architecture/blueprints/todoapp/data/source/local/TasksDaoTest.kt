package com.example.android.architecture.blueprints.todoapp.data.source.local

import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.room.Room
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.SmallTest
import com.example.android.architecture.blueprints.todoapp.data.Task
import kotlinx.coroutines.test.runTest
import org.junit.After
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNotNull
import org.junit.Assert.assertNull
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
@SmallTest
class TasksDaoTest {

    @get:Rule
    var instantExecutorRule = InstantTaskExecutorRule()

    private lateinit var database: ToDoDatabase

    @Before
    fun initDb() {
        database = Room.inMemoryDatabaseBuilder(
            ApplicationProvider.getApplicationContext(),
            ToDoDatabase::class.java
        ).build()
    }

    @After
    fun closeDb() = database.close()

    @Test
    fun saveTask_retrievesTask() = runTest {
        // GIVEN - Insert a task.
        val task = Task("Title", "Description", false, "id1")
        database.taskDao().insertTask(task)

        // WHEN - Get the task by id from the database.
        val loaded = database.taskDao().getTaskById(task.id)

        // THEN - The loaded data contains the expected values.
        assertNotNull(loaded)
        assertEquals(task.id, loaded?.id)
        assertEquals(task.title, loaded?.title)
        assertEquals(task.description, loaded?.description)
        assertEquals(task.isCompleted, loaded?.isCompleted)
    }

    @Test
    fun updateTaskAndGetById() = runTest {
        // GIVEN - Insert a task.
        val originalTask = Task("Title", "Description", false, "id1")
        database.taskDao().insertTask(originalTask)

        // WHEN - Update the task.
        val updatedTask = Task("New Title", "New Description", true, "id1")
        database.taskDao().updateTask(updatedTask)

        // THEN - The loaded data contains the expected values.
        val loaded = database.taskDao().getTaskById("id1")
        assertNotNull(loaded)
        assertEquals("id1", loaded?.id)
        assertEquals("New Title", loaded?.title)
        assertEquals("New Description", loaded?.description)
        assertEquals(true, loaded?.isCompleted)
    }

    @Test
    fun completeTask_retrievedTaskIsComplete() = runTest {
        // GIVEN - Insert an active task.
        val task = Task("Title", "Description", false, "id1")
        database.taskDao().insertTask(task)

        // WHEN - Complete the task.
        database.taskDao().updateCompleted(task.id, true)

        // THEN - The loaded task is marked as complete.
        val loaded = database.taskDao().getTaskById(task.id)
        assertNotNull(loaded)
        assertEquals(task.id, loaded?.id)
        assertEquals(true, loaded?.isCompleted)
    }

    @Test
    fun deleteTask_retrievesNone() = runTest {
        // GIVEN - Insert a task.
        val task = Task("Title", "Description", false, "id1")
        database.taskDao().insertTask(task)

        // WHEN - Delete the task by id.
        database.taskDao().deleteTaskById(task.id)

        // THEN - The task is no longer in the database.
        val loaded = database.taskDao().getTaskById(task.id)
        assertNull(loaded)
    }
}