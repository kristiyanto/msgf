# THIS SCRIPT WILL SCAN FOR THE FILES IN A FOLDER
# EXTRACT, IF NECESSARY, AND RUN MGSF PLUS TO 
# NORMALIZE THE DATA
# DANIEL.KRISTIYANTO@PNNL.GOV

######################## ENV ###########################
import gzip
import os
import glob
import os.path
import subprocess
from os.path import isfile, join

working_dir = os.getcwd() +"/data/"
print(working_dir)

spectrum 	= []
out 		= []
db 			= None
module 		= None

######################## FUNCTIONS ###########################
def msgf(spectrum, db, mod, out):
	#cmd = "java -Xmx3500M -jar MSGFPlus.jar -s " + spectrum + " -d " + db + " -o " + out
	subprocess.call(['java', '-Xmx3500M', '-jar', '/root/MSGFPlus.jar', '-s',spectrum, '-d', db, '-o', out])


######################## DECOMPRESS ###########################
spectrum_tmp = []
for src_name in glob.glob(os.path.join(working_dir, '*.gz')):
    base = os.path.basename(src_name)
    print("Extracting", src_name)
    dest_name = os.path.join(working_dir, base[:-3])
    spectrum_tmp.append(dest_name)
    with gzip.open(src_name, 'rb') as infile:
        with open(dest_name, 'wb') as outfile:
            for line in infile:
                outfile.write(line)

######################## SCAN FILES ###########################

for file in os.listdir(working_dir):
	if file.endswith(".mzML"):
		spectrum.append(join(working_dir, file))
		out.append(file[:-4]+".mzid")
		print("Spectrum: ", file)
	if file.endswith(".fasta"):
		db 			= join(working_dir, file)
		print("Database: ", file)
	if file.endswith(".mod"):
		module		= join(working_dir, file)
		print("Module:", file)
if (len(spectrum)==0):
	print("Missing spectrum files.")
	exit()
if (db == None):
	print("Missing database file.")
	exit()
if (module == None):
	print("Missing module file.")
	exit()

######################## MSGF ###########################

for s in spectrum:
	out = (s[:-4]+".mzid")
	msgf(s,db,module,out)

print("Done.")
