/*
Projekt Name: Trennwaende für das Modellhaus 3723
Modul:  Zwischendecke mit Halterungen für die WS2812
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
z_zwishendecke = z_grund * 0.5; // Hoehe der Zwischendecke

// Parameter für die Staerke der Waende
wand_staerke = 1.25;
/*
    Bitte die drei Formeln nicht aendern. Diese errechnen die zusätzlichen Parameter aus den vorhandenen Weten der Zeilen 10 - 22.
*/
x_all = x_grund;
y_all = y_grund;
z_all = z_grund;

/* 
    Wenn die Zwischendecke_Haus eine Halterung für eine Lampe hat oder ein Kabelschacht eine Oeffnung braucht, kann man hier einen Ausschnitt in der Zwischendecke_Haus dafuer vorsehen und die Position und Groesse angeben.
*/
x_cut = 49.25 - 39.25 - wand_staerke*0.25;  // Laenge der Aussparung
y_cut = 12+wand_staerke*1.25;  // Breite der Aussparung
cut_pos_x = 29.25 +wand_staerke/2; // Punkt X der Aussparung
cut_pos_y = 11.25 + wand_staerke; // Punkt Y der Aussparung 


/*
    Im nachfolgendem Abschnitt wird die Grundplatte und alle Waende erstellt.
    Die Angaben koennen ganz nach belieben abgeaendert werden.
*/
difference(){
    //Erstellen der Zwischendecke sowie dem Loch für den Kabelschacht (true = mit loch, false = ohne Loch)
    Zwischendecke_Haus(true); 
    // Die erste Wand ist die, die von links nach rechts geht und das Haus einmal teilt
    Wand_DIR_Y(0,y_grund/2,x_grund);
        
    // Die zweite Wand geht von der Mitte der Mittelwand bis zur unteren Kante der Grundplatte und teilt den unteren Teil nochmals in zwei Teile.
    Wand_DIR_X(x_grund/2, 0,y_grund/2); 

    //Die dritte Wand geht von der linken Aussenseite bis zur zweiten Wand
    Wand_DIR_Y(0,11.25+wand_staerke/2,40.25);

    //Die vierte und letzte Wand. Diese geht von der oberen Kante zu der dritten Wand.
    Wand_DIR_X(29.25,y_grund - (25.25+1.5+12+1.5),37.75+wand_staerke*2);
}

/* 
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!   
!!!!    Ab hier kommen die Module. Bitte nur aendern wann man   !!!!
!!!!    weiss was man macht.                                    !!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/*  
    Das Module Zwischendecke_Haus erstellt die Grundplatte des Hauses inkl. des Aussenrandes um die Grundplatte. Dazu wurde im Bereich für die Parameter in den  Zeilen 10 - 37 die Werte angeben.
*/
module Zwischendecke_Haus(cutting){
        difference(){
            cube([x_grund,y_grund,z_grund],false);
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
    width_x => gibt an wie lang die Wand werden soll..
*/
module Wand_DIR_X(pos_x, pos_y, width_x){
    translate([pos_x -wand_staerke/2,pos_y,0]){
        cube([wand_staerke,width_x, z_zwishendecke]);
    }
}

/*
    Das Modul "Wand_DIR_Y" erstellt Waende welche auf der Y-Achse (von vorne nach hinten) verschoben werden koennen.  
    Die Hoehe ist dabei immer die gesamte Hoehe des Stockwerkes.
    pos_x   => gibt den Startpunkt auf der X-Achse an.
    pos_y   => gibt den Startpunkt auf der Y-Achse an.
    width_y => gibt an wie lang die Wand werden soll..
*/
module Wand_DIR_Y(pos_x, pos_y, width_y){
    translate([pos_x,pos_y - wand_staerke/2,0]){
        cube([width_y,wand_staerke, z_zwishendecke]);
    }
}