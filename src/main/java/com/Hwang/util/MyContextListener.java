package com.Hwang.util;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyContextListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("webService start");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("webService stop");
        
        try {
            while(DriverManager.getDrivers().hasMoreElements()) {
                DriverManager.deregisterDriver(DriverManager.getDrivers().nextElement());
            }
            System.out.println("jdbc Driver close");
//            这里看网上使用的是shutdown()方法，这个方法是  Maven: mysql:mysql-connector-java:8.0.25 包里面的
//            可能因为版本问题，我只能使用 checkedShutdown() 方法,不过也解决了问题
//            AbandonedConnectionCleanupThread.shutdown();
            AbandonedConnectionCleanupThread.checkedShutdown();
            System.out.println("clean thread success");
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }
}
