TARGET := html/index.html

BASE_SOURCE := linux_administration.xml
MAIN_SOURCE := unix-base-admin.docbook

SOURCES := $(wildcard *.xml) common.ent
IMAGES_SRC := $(wildcard $(addsuffix /*.svg, images ))
IMAGES := $(patsubst %.svg, %.png, $(IMAGES_SRC))
PRES_SRC := $(wildcard $(addsuffix /*.svg, presentation ))
PRES := $(patsubst %.svg, %.png, $(PRES_SRC))

XSLT_PROC := xsltproc
XSLT_PATH := http://docbook.sourceforge.net/release/xsl/current/html/chunk.xsl
CONVERT := convert -resize "25%"

ENCODING := koi8-r
TYPE := html
PARAMETERS := --stringparam chunker.output.indent yes \
	    --stringparam html.stylesheet 'general.css' \
	    --stringparam chunker.output.encoding $(ENCODING)


.PHONY: clear

$(TARGET): $(MAIN_SOURCE) $(IMAGES) $(XSLT_LOCAL) presentation
	$(XSLT_PROC) $(PARAMETERS) $(XSLT_PATH) $(MAIN_SOURCE)
	-rm -rf html/
	-rm images/small-*.png
	mkdir -p html/images html/pres
	mv *.html html/
	cp -r images/*.png html/images/
	cp general.css html/
	cp presentation/*.png html/pres/

$(MAIN_SOURCE): $(SOURCES) convert.xsl
	$(XSLT_PROC) --xinclude convert.xsl $(BASE_SOURCE) >$(MAIN_SOURCE)

clean:
	-rm *~
	-rm -rf html
	-rm -rf pres
	-rm images/*.png presentation/*.png
	-rm $(MAIN_SOURCE)

presentation: $(PRES)
	rm -rf pres
	mkdir -p pres
	cp presentation/*.png pres/

%.png: %.svg
	inkscape -z -f $< -e $@ -d 120 -D -b ffffffff 2>/dev/null
	inkscape -z -f $< -e $(subst /,/small-, $@) -d 50 -D -b ffffffff 2>/dev/null
