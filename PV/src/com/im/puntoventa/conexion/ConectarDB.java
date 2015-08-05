package com.im.puntoventa.conexion;

//import java.io.BufferedReader;
//import java.io.FileNotFoundException;
//import java.io.FileReader;
//import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectarDB {
	
	public Connection getConnection(){
//		leer UDL
//		BufferedReader reader=null;
//		String[] datos = new String[14];
//		try {
//			reader = new BufferedReader(new FileReader(
//				"C:/millenium.udl"));
//		} catch (FileNotFoundException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}

		// Read lines from file.
//		while (true) {
//		    String line = null;
//			try {
//				line = reader.readLine();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		    if (line == null) {
//			break;
//		    }
//		    // Split line on comma.
//		    String[] parts = line.split(";");
//		    int x = 0;
//		    for (String part : parts) {
//		    	datos[x] = part;
//		    	x++;
//		    }
//		}
		
//		try {
//			reader.close();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		
//		leer UDL
		Connection conectar = null;
		try {
			try {
				Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//RECORDAR QUE ESTE DEBE SACAR LA INFORMACION DEL UDL.
//			String url="jdbc:sqlserver://186.64.110.212;DatabaseName=PbMillenium2";
//			String usr = datos[3];
//			String pass = datos[4];
//			conectar = DriverManager.getConnection("jdbc:sqlserver://186.64.110.212;databaseName=PbMillenium2;"+ datos[3] + ";" + datos[1] + ";");
			conectar = DriverManager.getConnection("jdbc:sqlserver://localhost;databaseName=MilleniumIM;user=sa;password=SOLUCION");
//			conectar = DriverManager.getConnection("jdbc:sqlserver://186.64.110.212;databaseName=PbMillenium2;"+datos[3]+";"+datos[1]+";"+"integratedSecurity=true");
//			conectar = DriverManager.getConnection("jdbc:sqlserver://186.64.110.212;databaseName=PbMillenium2;user=consultas;password=consultas*");
		} catch (SQLException sqlex) {
			// TODO: handle exception
		}
		return conectar;
	}
}
