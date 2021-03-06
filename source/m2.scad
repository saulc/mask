


use <myshapes.scad> 
 
fn = 60;
 h = 28.5; 
 w = 50;  
 l = 80;  //vertical length
  ll = 4;  //chin offset
  lf = 6; //chin cutout?
  tz = 7; //vertical offset
  
  l2 = l - 9; //print face
  w2 = w - 7;   //print face
  
  //nearly rectanular cutout for efficient filter use.
  gd = 22; //cutout width
  gg = gd+ 4; //low cutout addtion
  
  oc = 19;  //outter coner
  ic = 17; //inner corner
  
  t = 11;    //lowwer negative taper
  tt = 7;   //upper positive center taper
  
  
 wall = 1.2*2;
 fwall = 1.2*1;
 
hole = 4;
hs = 11;  //hole suppport
hh = 8;     //hole height

//color("black") translate([0, 0, -4])     
screen();
//color("white") translate([0, 0, 11])     screen();


//%cy(111, 200, fn); //test volume //delta

//translate([80, 90, 11]) 
//%c(250, 210, fn); //test volume pi3//
//translate([80, 90, 11]) 
//%c(200, 200, fn); //test volume pi3


//for(j=[0:1]) 
//for(i=[0:1]) 
//    translate([90*i+45*j, j*148, 0]) 
//    rotate([0,0,j*180])
//mask();

module mask(){ 
    difference(){ 
        //outside
      out();
    
        //inside 
    difference(){ 
        in();
        sup();
    }
        
    
    //chin cutout
        translate([0,-1, 180])  rotate([90,0,0])   
        rotate([0,0,180/fn]) cy(311, 11, fn);
    
    
    //face cutouts
    //    grid();               //vertical screen
    vc();                   //v  screen
    //gc();                 //open cut
   // translate([0,0, 2])  //no outside holes.
    holes();
    translate([0,5+1.2,7]) rotate([90,0,0]) sidecut();
        
    //top cutoff
        translate([0,0, h*1.5])  cy(211, h ,50);
        
    }
}

module in(){
      union(){
        hull(){
        translate([0,0, fwall]) base(w-t-wall, l-t-wall, 2, ic); 
      //  translate([0,0, 4]) base(w-wall, l-wall, 2, ic); 
        translate([0,0, h-tz]) base(w-wall, l-wall, 2, ic);  
        }
    
       difference(){
        hull(){
             
        translate([0,l+7, h+11]) sp(ic, fn);
        translate([0,4, h+2])  rotate([0,90,0])  cy(ic, 1, fn);
            
        translate([0,0, h-1]) base(w+tt-wall, l-wall, 2, ic); 
        translate([0,0, h-tz]) base(w-wall, l-wall, 2, ic); 
        }
             translate([0, -oc+11, h-11])   rotate([0,90,0])  cy(oc, l, fn);
    }
    }
}


module out(){

  union(){
        hull(){
        translate([0,0, 0]) base(w-t, l-t, 2, oc);  
        translate([0,0, h-tz]) base(w, l, 2, oc);  
             translate([0, -ll, h-lf])   rotate([0,90,0])  cy(3, 22, fn);
        } 
        hull(){
        translate([0,0, h-2]) base(w+tt, l, 2, oc); 
        translate([0,0, h-tz]) base(w, l, 2, oc); 
             translate([0, -ll, h-lf])   rotate([0,90,0])  cy(3, 22, fn);
             
        }
    }
}

//---------------------------------------------------
// --------------- screen ---------------------------
    
module screen(){
    
    difference(){ 
        union(){
           translate([0, -1, 0]) base(w2-7, l2-5, fwall*2, ic);
            //sup();
        }
       
           translate([0, 24, h/2+fwall]) rc(gg, 45, h, 5);
        grid();
    holes();
    }
}

module grid(){
    difference(){
        gc();
    n = 2;
//  for(j=[-1,1]) rotate([0,0, j*11]) translate([0, 28])  c(3, 66, h);
  for(j=[-n:n]) rotate([0,0, 0]) translate([j*6, 28])  c(2.5, 66, h);
  }
}

module vc(){
    difference(){
        gc(); 
  for(j=[-1,1]) rotate([0,0, j*11]) translate([0, 28])  c(3, 66, h);
   }
}
module gc(){
    
    hull(){
         translate([0, 33, 0])  cy(gd, h, fn);
         translate([0, 7, 0]) rc(gg, 7, h, 6);
    } 
}


//---------------------------------------------------

module holes(){
    union(){
    for(i=pos(w2, l2, ll)) 
        translate([0,0, h/2])
        translate(i) cy(hole, h+1, fn);
    }
}

module sup(){
    union(){
    for(i=pos(w2, l2, ll)) 
        translate([0,0, -h/2+hh])
        translate(i) cy(hs, h, fn);
    }
}

function pos(w, l, ll) = [ [w/2, hs/2, 0], [-w/2, hs/2, 0], [0, l, 0] ];


module base(w, l, h, c){
    hull(){
    for(i=pos(w, l, ll)) 
        translate([0,3, h/2])
        translate(i) cy(c, h, fn);
    }
    
}

//---------------------------------------------------

module sidecut(){
    
    x = 13;
    y = 5;
    t = 11;
    n = 1;
        for(i=[-n:n])                                   //   d, h, c, fn
         translate([x*i,0, h/2-2])      rotate([0,0,90])  rcy(t, 7, 2 ,3);
        for(i=[-n:0])  
            translate([x*i+x/2,y, h/2-2]) rotate([0,0,-90])  rcy(t, 7, 2 ,3);
        

}
    
 
 
    
 
