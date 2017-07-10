package org.stp.Utils;

import org.apache.log4j.Logger;


import java.io.*;
import java.sql.SQLException;
import java.util.*;

public class log4jExample{

   /* Get actual class name to be printed on */
   private static org.apache.log4j.Logger log = Logger.getLogger(log4jExample.class.getName());

   public static void main(String[] args){
       System.out.println("test de log  from java_log4jExample");
      log.debug("Hello this is a debug message from java_log4jExample");
      log.info("Hello this is an info message  from java_log4jExample");
   }
}
