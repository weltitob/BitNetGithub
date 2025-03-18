package com.example.moonpay_flutter


import android.app.Application
import android.util.Log

class AppController {


    public var composeActivity: ComposeActivity? = null




    companion object {
        @Volatile
        private var INSTANCE: AppController? = null

        // public function to retrieve the singleton instance
        public fun getInstance(): AppController? {
            // Check if the instance is already created
            if (INSTANCE == null) {
                // synchronize the block to ensure only one thread can execute at a time
                synchronized(this) {
                    // check again if the instance is already created
                    if (INSTANCE == null) {
                        // create the singleton instance
                        INSTANCE = AppController()
                    }
                }
            }
            // return the singleton instance
            return INSTANCE
        }
    }

}