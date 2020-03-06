/*
Projekt Name: Trennwaende für das Modellhaus 3723
Modul:  Grundplatte und Waende für das Erdgeschoss
Projekt URL: https://github.com/Hardi-St/MobaLedLib_Docu/tree/master/3D_Daten_fuer_die_MobaLedLib/Trennwände%20für%20Häuser
Version: 0.0.1
Autor: Moba-Nick (mobanick@wp12085804.server-he.de)
Lizenz: CC-BY-SA-4.0 (https://creativecommons.org/licenses/by-sa/4.0/legalcode.de)
*/
// Alle Angaben sind immer in mm bei meinen Projekten.
//Parameter für die Grundplatte des Hauses
x_grund = 80;       // Laenge der Grundplatte
y_grund = 52;       // Breite der Grundplatte 
z_grund = 1.25;       // Staerke der Grundplatte
z_erdgeschoss = 35; // Hoehe des Erdgeschosses - 6 mm für die Zwischendecke

// Parameter für die Staerke der Waende
wand_staerke = 1.0;
/*
    Um zu verhindern das die GrundPlatte_Haus in das Haus ruscht, bekommt diese einen Rand der breiter und laenger ist als die Oeffnung. Nachfolgend werden die Werte für die Staerke und dem zusaetzlichen Rand definiert.
*/
z_rand = 0.35;  //Staerke des Zusatzrandes
rand = 1.75;    // Breite des umlaufenden Rands

/*
    Bitte die drei Formeln nicht aendern. Diese errechnen die zusätzlichen Parameter aus den vorhandenen Weten der Zeilen 10 - 22.
*/
x_all = x_grund + rand*2;
y_all = y_grund + rand*2;
z_all = z_grund + z_rand;

/* 
    Wenn die GrundPlatte_Haus eine Halterung für eine Lampe hat oder ein Kabelschacht eine Oeffnung braucht, kann man hier einen Ausschnitt in der GrundPlatte_Haus dafuer vorsehen und die Position und Groesse angeben.
*/
x_cut = 49.25 - 39.25 - wand_staerke*0.25;  // Laenge der Aussparung
y_cut = 12+wand_staerke*1.25;  // Breite der Aussparung
cut_pos_x = 29.25 +wand_staerke/2+ rand; // Punkt X der Aussparung
cut_pos_y = 11.25 + wand_staerke + rand; // Punkt Y der Aussparung 


/*
    Im nachfolgendem Abschnitt wird die Grundplatte und alle Waende erstellt.
    Die Angaben koennen ganz nach belieben abgeaendert werden.
*/
//Erstellen der Grundplatte mit dem Rand, sowie dem Loch für den Kabelschacht (true = mit loch, false = ohne Loch)
GrundPlatte_Haus(true); 
// Die erste Wand ist die, die von links nach rechts geht und das Haus einmal teilt
Wand_DIR_Y(0,y_grund/2,x_grund);
    
// Die zweite Wand geht von der Mitte der Mittelwand bis zur unteren Kante der Grundplatte und teilt den unteren Teil nochmals in zwei Teile.
Wand_DIR_X(x_grund/2, 0,y_grund/2); 

//Die dritte Wand geht von der linken Aussenseite bis zur zweiten Wand
Wand_DIR_Y(0,11.25+wand_staerke/2,40.25);

//Die vierte und letzte Wand. Diese geht von der oberen Kante zu der dritten Wand. Dadurch ist nun auch der Kabelschacht sichtbar.
Wand_DIR_X(29.25,y_grund - (25.25+1.5+12+1.5),37.75+wand_staerke*2);



/* 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   
!!!!    Ab hier kommen die Module. Bitte nur aendern wann man   !!!!
!!!!    weiss was man macht.                                    !!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*  
    Das Module GrundPlatte_Haus erstellt die Grundplatte des Hauses inkl. des Aussenrandes um die Grundplatte. Dazu wurde im Bereich für die Parameter in den  Zeilen 10 - 37 die Werte angeben.
*/
module GrundPlatte_Haus(cutting){
        difference(){
            union(){
                cube([x_all,y_all,z_rand],false);
                translate([rand,rand,0]){
                    cube([x_grund,y_grund,z_grund],false);
                }
            }
            // Auschnitt aus der Grundplatte vornehmen
            if (cutting == true){
                translate([cut_pos_x,cut_pos_y,0]){
                    cube([x_cut,y_cut,z_all],false);
                }
            }
        }
}

/*
    Das Modul "Wand_DIR_X" erstellt Waende welche auf der X-Achse (von links nach rechts) verschoben werden koennen.
    Die Hoehe ist dabei immer die gesamte Hoehe des Stockwerkes.
    pos_x   => gibt den Startpunkt auf der X-Achse an.
    pos_y   => gibt den Startpunkt auf der Y-Achse an.
    width_x => gibt an wie lang die Wand werden soll.
    Der Rand um die Grundplatte wird automatisch mit eingerechnet in die Startpositionen.
*/
module Wand_DIR_X(pos_x, pos_y, width_x){
    translate([pos_x + rand -wand_staerke/2,pos_y + rand,z_rand]){
        cube([wand_staerke,width_x, z_erdgeschoss+z_rand]);
    }
}

/*
    Das Modul "Wand_DIR_Y" erstellt Waende welche auf der Y-Achse (von vorne nach hinten) verschoben werden koennen.  
    Die Hoehe ist dabei immer die gesamte Hoehe des Stockwerkes.
    pos_x   => gibt den Startpunkt auf der X-Achse an.
    pos_y   => gibt den Startpunkt auf der Y-Achse an.
    width_y => gibt an wie lang die Wand werden soll.
    Der Rand um die Grundplatte wird automatisch mit eingerechnet in die Startpositionen.
*/
module Wand_DIR_Y(pos_x, pos_y, width_y){
    translate([pos_x + rand,pos_y + rand -wand_staerke/2,z_rand]){
        cube([width_y,wand_staerke, z_erdgeschoss+z_rand]);
    }
}