KC=	kotlinc
KFLAG=	-cp
GLIB=	lib

all:	libProblema3.jar

libProblema3.jar: $(GLIB)/Nodo.class
		
	jar -cvf $@ $(GLIB)/*.class 

$(GLIB)/Nodo.class: $(GLIB)/Nodo.kt
	$(KC) $(GLIB)/Nodo.kt

clean:
	rm -rf libProblema3.jar META-INF $(GLIB)/*.class
