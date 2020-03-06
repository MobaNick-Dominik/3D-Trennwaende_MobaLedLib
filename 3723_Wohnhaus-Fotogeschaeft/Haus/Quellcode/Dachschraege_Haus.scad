x_all = 59;
y_all = 43;
z_all = 1.5;
z1_cut = 0.25;

led_x = 10;
led_y = 10;

led_h_z = 3.2;
led_h_x = 7;
led_h_y = 2;
led_x_inner = 5;
led_y_inner = 5;
haken = 1.25;

wand_oben = 0;
wand_dicke = 1.6;
 
//Definiton zusätzlicher Werte für Dachschraege
hoehe = 20;
kniestock = 4;

module led_halter_dach(pos_x, pos_y,pos_z){
    translate([pos_x,pos_y-led_x/2-led_h_y,z_all+pos_z]){
        cube([led_h_z,led_h_y,led_h_x], center=false);
    }
    translate([pos_x+led_h_z,pos_y-led_x/2-led_h_y,z_all+pos_z]){
        cube([z_all,led_h_y+haken,led_h_x], center=false);
    }
    
    translate([pos_x,pos_y+led_y/2,z_all+pos_z]){
        cube([led_h_z,led_h_y,led_h_x], center=false);
    }
    translate([pos_x+led_h_z,pos_y+led_y/2-haken,z_all+pos_z]){
        cube([z_all,led_h_y+haken,led_h_x], center=false);
    }
    translate([pos_x,pos_y-led_h_x/2,z_all]){
        cube([led_h_z*0.9,led_h_x,led_h_y], center=false);
    }
    
}

module DachSchraege(){
    //Berechnung der Startpunkte
    start_x = x_all / 2 - z_all / 2 - led_h_x/2;
    start_y = 0;
    start_z = z_all;
    breite = y_all;
    difference(){
        union(){  
            //Kniestock
            translate([start_x,start_y,start_z]){
                cube([z_all,y_all,kniestock],false);
            }
            
            //Dachschraege
            DachPunkte = [
              [start_x+z_all,0,      start_z+kniestock ],  //0
              [start_x+z_all,y_all,  start_z+kniestock ],  //1
              [start_x,             y_all,  start_z+kniestock ],  //2
              [start_x,             0,      start_z+kniestock ],  //3
              [start_x+z_all,y_all/2,hoehe ],  //4
              [start_x,             y_all/2,hoehe ]]; //5
              
            DachFlaechen = [
              [0,1,2,3],  // bottom
              [4,1,0],  // front
              [4,5,2,1],  // right
              [5,3,2],  // back
              [5,4,0,3]]; // left
              
            polyhedron( DachPunkte, DachFlaechen );
            
            //LED_Halter am Dach
            //Links
            led_halter_dach(start_x+z_all,y_all/2,kniestock);
        }
        
        loch_y = y_all/2 - led_x_inner/2;
        translate([start_x, loch_y, z_all+kniestock]){
            cube([z_all,led_x_inner,led_x_inner],false);
        }
    }   
}

DachSchraege();