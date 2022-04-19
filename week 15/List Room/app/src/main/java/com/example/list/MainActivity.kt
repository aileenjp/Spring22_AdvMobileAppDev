package com.example.list

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.list.model.Item
import com.example.list.model.ItemViewModel
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import java.util.*

class MainActivity : AppCompatActivity() {
    private val viewModel: ItemViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        //define an adapter
        val adapter = MyListAdapter(viewModel)

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
            //create alert dialog
            val dialog = AlertDialog.Builder(this)
            //create edit text
            val editText = EditText(applicationContext)
            //add edit text to dialog
            dialog.setView(editText)
            //set dialog title
            dialog.setTitle(R.string.addItem)
            //set OK action

            dialog.setPositiveButton(R.string.add) {dialog, which ->
                val newItem = editText.text.toString()
                if (!newItem.isEmpty()){
                    //add item
                    viewModel.add(Item(0, newItem))
                    Snackbar.make(view, R.string.itemAdded, Snackbar.LENGTH_LONG)
                        .setAction(R.string.action, null).show()
                }
            }
            //sets cancel action
            dialog.setNegativeButton(R.string.cancel) { dialog, which ->
                //cancel
            }
            dialog.show()
        }

        //create the observer
        viewModel.itemList.observe(this, Observer {
            adapter.update()
        })
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menuInflater.inflate(R.menu.options_menu, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        return when (item.itemId) {
            R.id.action_deleteAll -> {
                viewModel.deleteAll()
                true
            }
            else -> super.onOptionsItemSelected(item)
        }
    }

}