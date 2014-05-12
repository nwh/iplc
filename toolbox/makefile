
.DEFAULT_GOAL := ipopt

Ipopt-3.11.0-linux64mac64win32win64-matlabmexfiles.zip:
	wget http://www.coin-or.org/download/binary/Ipopt/Ipopt-3.11.0-linux64mac64win32win64-matlabmexfiles.zip

ipopt: Ipopt-3.11.0-linux64mac64win32win64-matlabmexfiles.zip
	unzip $< -d $@

.PHONY: clean
clean:
	$(RM) Ipopt-3.11.0-linux64mac64win32win64-matlabmexfiles.zip
	$(RM) -r ipopt
