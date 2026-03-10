package com.example.android.architecture.blueprints.todoapp.data.source

import com.example.android.architecture.blueprints.todoapp.data.Result
import com.example.android.architecture.blueprints.todoapp.data.Task
import kotlinx.coroutines.test.runTest
import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.core.IsEqual
import org.junit.Before
import org.junit.Test

class DefaultTasksRepositoryTest {

    private val task1 = Task(title = "task1", description = "desc1", id = "1")
    private val task2 = Task(title = "task2", description = "desc2", id = "2")
    private val task3 = Task(title = "task3", description = "desc3", id = "3")
    private val task4 = Task(title = "task4", description = "desc4", id = "4")

    private val remoteTasks = listOf(task1, task2)
    private val localTasks = listOf(task3, task4)

    private lateinit var fakeLocalDataSource: TasksDataSource
    private lateinit var fakeRemoteDataSource: TasksDataSource
    private lateinit var repository: DefaultTasksRepository

    @Before
    fun setup() {
        fakeLocalDataSource = FakeDataSource(localTasks.toMutableList())
        fakeRemoteDataSource = FakeDataSource(remoteTasks.toMutableList())

        repository = DefaultTasksRepository(fakeRemoteDataSource, fakeLocalDataSource)
    }

    @Test
    fun getTask_forceUpdateIsFalse_returnsLocalDataFromLocal() = runTest {
        // When tasks are requested from repository and update is not required
        val result = repository.getTask(task3.id, forceUpdate = false) as Result.Success

        // Then tasks are loaded form the local data source
        assertThat(result.data, IsEqual(task3))
    }

    @Test
    fun getTask_forceUpdateIsTrue_returnsDataFromRemote() = runTest {
        // When tasks are requested from repository and update is required
        val result = repository.getTask(task1.id, forceUpdate = true) as Result.Success

        // Then tasks are loaded form the remote data source
        assertThat(result.data, IsEqual(task1))
    }
}