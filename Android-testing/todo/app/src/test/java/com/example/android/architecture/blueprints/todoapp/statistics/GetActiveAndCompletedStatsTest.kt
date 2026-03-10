package com.example.android.architecture.blueprints.todoapp.statistics

import com.example.android.architecture.blueprints.todoapp.data.Task
import org.hamcrest.MatcherAssert.assertThat
import org.hamcrest.core.Is.`is`
import org.junit.Test

class StatisticsUtilsTest {

    @Test
    fun getActiveAndCompletedStats_noCompleted_returnsHundredActiveZeroCompleted() {
        // Given: No Complete list of tasks
        val tasks = listOf<Task>(Task(isCompleted = false))

        // When: getActiveAndCompletedStats
        val result = getActiveAndCompletedStats(tasks)

        // Then: we get 0 complete and 100 active
        assertThat(result.completedTasksPercent, `is`(0f))
        assertThat(result.activeTasksPercent, `is`(100f))
    }

    @Test
    fun getActiveAndCompletedStats_twoCompletedThreeActive_returnsSixtyActiveFortyCompleted() {
        // Given: list with 2 completed and 3 active tasks
        val tasks = listOf(
            Task(isCompleted = true),
            Task(isCompleted = true),
            Task(isCompleted = false),
            Task(isCompleted = false),
            Task(isCompleted = false)
        )

        // When: getActiveAndCompletedStats
        val result = getActiveAndCompletedStats(tasks)

        // Then: we get 40 complete and 60 active
        assertThat(result.completedTasksPercent, `is`(40f))
        assertThat(result.activeTasksPercent, `is`(60f))
    }

    @Test
    fun getActiveAndCompletedStats_emptyList_returnsZeros() {
        // Given: empty list
        val tasks = emptyList<Task>()

        // When: getActiveAndCompletedStats
        val result = getActiveAndCompletedStats(tasks)

        // Then: we get 0 complete and 0 active
        assertThat(result.completedTasksPercent, `is`(0f))
        assertThat(result.activeTasksPercent, `is`(0f))
    }

    @Test
    fun getActiveAndCompletedStats_null_returnsZeros() {
        // Given: null list
        val tasks = null

        // When: getActiveAndCompletedStats
        val result = getActiveAndCompletedStats(tasks)

        // Then: we get 0 complete and 0 active
        assertThat(result.completedTasksPercent, `is`(0f))
        assertThat(result.activeTasksPercent, `is`(0f))
    }
}