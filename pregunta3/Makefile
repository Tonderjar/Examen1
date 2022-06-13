KC=		kotlinc
KFLAG=		-cp
LIBGRAPH=	libProblema3/libProblema3.jar

all:	MainKt.class

MainKt.class: Main.kt 
	$(KC) $(KFLAG) $(LIBGRAPH) Main.kt
clean:
	rm -rf *.class META-INF
