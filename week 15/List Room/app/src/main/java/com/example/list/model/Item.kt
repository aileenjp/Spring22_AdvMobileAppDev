package com.example.list.model

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity
data class Item(@PrimaryKey(autoGenerate = true)  var id: Int, var name: String){
}