package com.example.potter

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.potter.data.JSONdata
import com.example.potter.model.PotterCharacter

class MainActivity : AppCompatActivity() {
    var potterList = ArrayList<PotterCharacter>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Log.i("data", "in oncreate")

        if (savedInstanceState == null){
            Log.i("data", "in if")
            val data = JSONdata()
            //populate with JSON data
            potterList = data.getJSON(this)
        }
        setupRecyclerView()
    }

    private fun setupRecyclerView(){
        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //define an adapter
        val adapter = MyListAdapter(potterList, {item: PotterCharacter -> itemClicked(item)})

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
    }

    private fun itemClicked(item : PotterCharacter) {
        //create intent
        var intent = Intent()
        intent.action = Intent.ACTION_VIEW
        intent.data = Uri.parse(item.info)

        //start activity
        startActivity(intent)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putParcelableArrayList("potterlist", potterList)
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        Log.i("data", "in on restore")
        super.onRestoreInstanceState(savedInstanceState)
        potterList = savedInstanceState.getParcelableArrayList<PotterCharacter>("potterlist") as ArrayList<PotterCharacter>
        setupRecyclerView()
    }

}