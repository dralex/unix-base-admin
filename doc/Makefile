TARGET := $(TYPE)/index.$(FILEEXT)

MAIN_SOURCE := unix-base-admin.docbook

IMAGES_SRC := $(wildcard $(addsuffix /*.svg, images ))
IMAGES := $(patsubst %.svg, %.png, $(IMAGES_SRC))
PRES_SRC := $(wildcard $(addsuffix /*.svg, presentation ))
PRES := $(patsubst %.svg, %.png, $(PRES_SRC))

XSLT_PROC := xsltproc
XSLT_PATH := /usr/share/xml/docbook/stylesheet/docbook-xsl/
CONVERT := convert -resize "25%"

ENCODING := utf-8
TYPE := xhtml5
FILEEXT := xhtml

PARAMETERS := --stringparam chunker.output.indent yes \
	    --stringparam html.stylesheet 'general.css' \
	    --stringparam chunker.output.encoding $(ENCODING)

.PHONY: clear

$(TARGET): $(MAIN_SOURCE) $(IMAGES) $(XSLT_LOCAL) presentation
	$(XSLT_PROC) $(PARAMETERS) $(XSLT_PATH)/$(TYPE)/chunk.xsl $(MAIN_SOURCE)
	-rm -rf $(TYPE)/
	-rm images/small-*.png
	mkdir -p $(TYPE)/images $(TYPE)/pres
	mv *.$(FILEEXT) $(TYPE)/
	cp -r images/*.png $(TYPE)/images/
	cp general.css $(TYPE)/
	-mv docbook.css $(TYPE)/
	cp presentation/*.png $(TYPE)/pres/

clean:
	-rm *~
	-rm -rf $(TYPE)
	-rm -rf pres
	-rm images/*.png presentation/*.png

presentation: $(PRES)
	rm -rf pres
	mkdir -p pres
	cp presentation/*.png pres/

%.png: %.svg
	inkscape -z -f $< -e $@ -d 120 -D -b ffffffff 2>/dev/null
	inkscape -z -f $< -e $(subst /,/small-, $@) -d 50 -D -b ffffffff 2>/dev/null
