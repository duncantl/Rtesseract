
libRexit.a: exit.o
	ar rcs libRexit.a exit.o

libRexit.so: exit.o
	$(CXX) -shared -o libRexit.so exit.o

# -L${R_HOME}/lib -lR

#-F/Library/Frameworks/R.framework/.. -framework R -Wl,-framework -Wl,CoreFoundation

#R_HOME=/Library/Frameworks/R.framework/Resources
exit.o: exit.c
	$(CXX) -c -fPIC -I${R_HOME}/include exit.c 

clean: 
	rm exit.o libRexit.so libRexit.a
