package com.example.android.architecture.blueprints.todoapp.tasks

import android.app.Application
import androidx.arch.core.executor.testing.InstantTaskExecutorRule
import androidx.lifecycle.MutableLiveData
import androidx.test.core.app.ApplicationProvider
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.example.android.architecture.blueprints.todoapp.data.Result
import com.example.android.architecture.blueprints.todoapp.data.Task
import com.example.android.architecture.blueprints.todoapp.data.source.DefaultTasksRepository
import com.example.android.architecture.blueprints.todoapp.data.source.TasksDataSource
import org.hamcrest.CoreMatchers.`is`
import org.hamcrest.CoreMatchers.nullValue
import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.core.IsNot.not
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import com.example.android.architecture.blueprints.todoapp.getOrAwaitValue
import io.mockk.coEvery
import io.mockk.every
import io.mockk.mockk
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.test.UnconfinedTestDispatcher
import kotlinx.coroutines.test.resetMain
import kotlinx.coroutines.test.setMain
import org.junit.After
import org.junit.Before
import org.robolectric.annotation.Config

class TasksViewModelTest {

    @get:Rule
    val rule = InstantTaskExecutorRule()

    private lateinit var repo: TasksDataSource
    private lateinit var viewModel: TasksViewModel

    @Before
    fun setup() {

        repo = mockk()

        val tasksLiveData = MutableLiveData<Result<List<Task>>>()

        every { repo.observeTasks() } returns tasksLiveData
        coEvery { repo.refreshTasks() } returns Unit

        viewModel = TasksViewModel(repo)

        tasksLiveData.value = Result.Success(emptyList())
    }


    @Test
    fun addNewTask_newTaskEventIsNotNull() {
        // Given: Create new TasksViewModel
//        val app = ApplicationProvider.getApplicationContext() as Application
//        val viewModel = TasksViewModel(app)

        // When: Call the method under testing (addNewTask)
        viewModel.addNewTask()

        // Then: assert that newTaskEvent has Triggered
        val result = viewModel.newTaskEvent.getOrAwaitValue()
        assertThat(result, not(nullValue()))
    }

    @Test
    fun setFiltering_allTasks_tasksAddViewVisible() {
        // Given: Create new TasksViewModel
//        val app = ApplicationProvider.getApplicationContext() as Application
//        val viewModel = TasksViewModel(app)

        // When: Call the method under testing to set filter to ALL_TASKS
        viewModel.setFiltering(TasksFilterType.ALL_TASKS)

        // Then: assert that the private setFilter() correctly updated the LiveData
        val isAddVisible = viewModel.tasksAddViewVisible.getOrAwaitValue()
        assertThat(isAddVisible, `is`(true))
    }

    @Test
    fun setFiltering_completedTasks_tasksAddViewNotVisible() {
        // Given: Create new TasksViewModel
//        val app = ApplicationProvider.getApplicationContext() as Application
//        val viewModel = TasksViewModel(app)

        // When: Call the method under testing to set filter to COMPLETED_TASKS
        viewModel.setFiltering(TasksFilterType.COMPLETED_TASKS)

        // Then: assert that the private setFilter() correctly updated the LiveData
        val isAddVisible = viewModel.tasksAddViewVisible.getOrAwaitValue()
        assertThat(isAddVisible, `is`(false))
    }
}