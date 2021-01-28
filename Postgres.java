/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.mycompany.mavenproject4;

import java.sql.*;
import java.util.Scanner;

/**
 * 
 * 
 * @author Manu
 */
public class Postgres {

    /**
     * @param args the command line arguments
     */
    private static String usuario;
    private static String contraseña;
    private static String nombreBaseDatos;
    
    
    public static void main(String[] args) {
        // FASES UNO  cargar el controlador de postgres
        System.out.println("probando si funciona el driver postgres");
        Scanner scan= new Scanner(System.in);
        try{
            Class.forName("org.postgresql.Driver");
                    }
        catch(ClassNotFoundException cnfe) {
            System.out.println("driver no disponible");
            System.out.println("error y salida");
            cnfe.printStackTrace();
            System.exit(1);
        }
       System.out.println("Driver cargado....empieza la conexiÃ³n"); 
       // FASE DOS probar el manejador con su conexiÃ³n (ojo cambiar usuario y password)
       Connection c = null;
       
       try {
              System.out.println("Introduzca el nombre de la base de datos: ");
              nombreBaseDatos = scan.nextLine();
              System.out.println("Introduzca el nombre de usuario: ");
              usuario = scan.nextLine();
              System.out.println("Introduzca la contraseña: ");
              contraseña = scan.nextLine();
              
              
              c = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/"+nombreBaseDatos,
                   usuario, contraseña);
       }
       catch(SQLException se) {
                  System.out.println("No se pudo establecer la conexiÃ³n"); 
                  se.printStackTrace();
                  System.exit(1);
       }
       if ( c!= null)
           System.out.println("Conectados a la base de datos");
       else
           System.out.println("Problemas al conectarnos a la base de datos"); 
       // FASE TRES probando la generaciÃ³n de sentencias
       Statement s = null;
       try {
            s = c.createStatement();
       }
        catch(SQLException se) {
                  System.out.println("probando conexion de consulta"); 
                  se.printStackTrace();
                  System.exit(1);
       }
       // FASE IV probando la ejecuciÃ³n
    ResultSet rs = null;

        String operacion = "";
        while(!operacion.equals("exit")){
            try{
                System.out.println("Introduzca la operación que desea realizar en la base de datos(exit para salir de la aplicacion): ");
                operacion = scan.nextLine();
                if(!operacion.equals("exit")){
                    rs = s.executeQuery(operacion);
                }
            
                int index = 0;
                try {
                    while (rs.next()) {
                        System.out.println("resultado fila" + index++ +" "
                                + rs.getString(1) + " " + rs.getString(2) ); 
                    }
                }
                catch(SQLException se) {
                              System.out.println("Error grave al mostrar datos"); 
                 }
            }catch(SQLException se) {
                  System.out.println("\n\nLa operación introducida es incorrecta\n"); 
            }
        }
        System.out.println("Nos vemos la próxima vez. ¡Un Saludo!");
    }
}

