"C:\Program Files\OpenSCAD\openscad.com" -D "mode=""export""" -o 2d_plates.dxf 2d_plates.scad
"C:\Program Files\OpenSCAD\openscad.com" --imgsize 800,450 --render -D "mode=""export""" -o outlines.png 2d_plates.scad
"C:\Program Files\OpenSCAD\openscad.com" --imgsize 800,450 -D "mode=""export""" -o plates.png 2d_plates.scad
"C:\Program Files\OpenSCAD\openscad.com" --imgsize 800,450 -o assembled.png 2d_plates.scad
