import subprocess, sys, os

##Because real make files are for wimps. And also I don't know how to make them.
'''
-----------------------------------------------
This is the configuration section. Hopefully should be pretty self explanatory

'''
##Path to files, and how many copies you want
config = {
'': 1

}

##Specify the path to your platter instance, if you have one.
PLATER_PATH="Plater"


'''
--------------Actual code starts here---------------------
'''

has_plater=False
try:
    subprocess.check_call(PLATER_PATH)
    has_plater=True
except:
    print(sys.exc_info()[1])
    print('Carrying on anyway. You\'ll just have to create build plates manually')

for key,value in config:
    if has_plater=True:
        pass
    else:
        value-1
        pass
        for count in value:
            pass
base_end_2off.scad
bed_mounts.scad
feet.scad
idler_pulleys.scad
idler_pulleys_single_bearing.scad
leadscrew_couplers.scad
make.py
plates.scad
pulley with collar.scad
settings.scad
wallace.scad
x_carriage.scad
x_end_left.scad
x_end_right.scad
y_bearing_retainers.scad
y_idler.scad
z_top_clamps.scad
