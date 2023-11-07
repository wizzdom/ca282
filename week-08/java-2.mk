files = $(wildcard *.java)

classes = $(files:.java=.class)

install: $(classes)

%.class: %.java
	javac $<
