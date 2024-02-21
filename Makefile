TEX := $(shell find content/**/*.tex) # find all `.tex` files in `content`
TEX_TARGET := $(patsubst %.tex, build/%.md, $(TEX)) # target them in the `build` folder

MARKDOWN := $(shell find content/**/*.md) # find all `.md` files in `content`
MARKDOWN_TARGET := $(patsubst %.md, build/%.md, $(MARKDOWN)) # target them in the `build` folder

# TODO: implement
# FIGURES := $(shell find assets/figures/*.tex)
# FIGURES_TARGET := $(patsubst %.tex, build/%.pdf, $(FIGURES))

all: content

# generate pdf of the latex figures
# figures: $(FIGURES_TARGET)
# build/figures/%.pdf: figures/%.tex
# 	mkdir -p $(dir $@)
# 	latexmk -pdf -jobname=$(@:%.pdf=%) $<

# build the target markdown content using the latex and markdown files
content: tex markdown

# convert latex content to markdown using pandoc
tex: $(TEX_TARGET)
build/%.md: %.tex
	mkdir -p $(dir $@)
	pandoc -f latex -t markdown $< -s -o $@

# convert markdown content to markdown using pandoc, it is almost just copying but transforms to strict markdown if needed
markdown: $(MARKDOWN_TARGET)
build/%.md: %.md
	mkdir -p $(dir $@)
	pandoc -f markdown -t markdown $< -s -o $@


# remove the `build` folder
clean:
	@rm -rf build
