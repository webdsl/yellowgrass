all : build deploy

build : 
	webdsl build

rebuild: 
	webdsl rebuild

clean: 
	webdsl clean

deploy:
	webdsl deploy

