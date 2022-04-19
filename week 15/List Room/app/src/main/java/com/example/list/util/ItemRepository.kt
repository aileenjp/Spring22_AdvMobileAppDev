package com.example.list.util

import androidx.lifecycle.LiveData
import com.example.list.model.Item

class ItemRepository(private val itemDAO: ItemDAO) {

    // Observed LiveData will notify the observer when the data has changed
    val itemList: LiveData<List<Item>> = itemDAO.getAllItems()

    // Room executes all queries on a separate thread
    suspend fun insertItem(item: Item) {
        itemDAO.insertItem(item)
    }

    suspend fun deleteItem(item: Item) {
        itemDAO.deleteItem(item)
    }

    suspend fun deleteAll() {
        itemDAO.deleteAll()
    }
}
