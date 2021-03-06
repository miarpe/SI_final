package gui;

import jason.asSemantics.DefaultInternalAction;
import jason.asSemantics.TransitionSystem;
import jason.asSemantics.Unifier;
import jason.asSyntax.Literal;
import jason.asSyntax.StringTerm;
import jason.asSyntax.Term;

//import java.util.Properties;    

//import javax.mail.*;    
//import javax.mail.internet.*; 

import java.io.*;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import java.util.*;
import java.util.logging.Logger;

//import java.awt.event.ActionEvent;
//import java.awt.event.ActionListener;



/** internal action that allow agents to create a map file on the enviroment bot given */

public class creatingMapFileFor extends DefaultInternalAction {

    //int runCount = 0;

    @Override
    public Object execute(final TransitionSystem ts, Unifier un, Term[] args) throws Exception {

		// get the route
        String file = ((StringTerm)args[0]).getString();
        String botName = ((StringTerm)args[1]).getString();
		
 		String mapsPath = getSetsPath(botName);
		
		System.out.println("El path del directorio maps del bot: "+botName+" es "+mapsPath);
		
		File archivo = new File(mapsPath + File.separator + file);
        BufferedWriter bw;

		try {
			if(archivo.exists()) {
				System.out.println("El fichero de texto ya estaba creado.");
			} else {
				archivo.createNewFile();
				System.out.println("Acabo de crear el nuevo fichero de maps " + file + " en " + mapsPath + File.separator );
			}
			bw = new BufferedWriter(new FileWriter(archivo,true));
			bw.close();

          } 
		catch (Exception eLabel) {
			eLabel.printStackTrace();
		};   
				
        return true;
    }
	
private static String getSetsPath(String botName) {
		File currDir = new File(".");
		String path = currDir.getAbsolutePath();
		path = path.substring(0, path.length() - 2);
		//System.out.println(path);
		//logger.info(path);
		String setsPath = path + File.separator + "src" + File.separator + "resources"+ File.separator + "bots" + File.separator + botName + File.separator + "maps";
		return setsPath;
	}
	
}
