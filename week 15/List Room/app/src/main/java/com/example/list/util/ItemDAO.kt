package com.example.list.util

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Delete
import androidx.room.Insert
import androidx.room.Query
import com.example.list.model.Item

@Dao
interface ItemDAO {
    @Query("SELECT * FROM Item ORDER BY name ASC")
    fun getAllItems(): LiveData<List<Item>>

    // Room executes all queries on a separate thread
    @Insert
    suspend fun insertItem(item: Item)

    @Delete
    suspend fun deleteItem(item: Item)

    @Query("DELETE FROM Item")
    suspend fun deleteAll()
}
