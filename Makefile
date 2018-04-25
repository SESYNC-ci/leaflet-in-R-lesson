SHELL := /bin/bash

# look up slides and lesson number in Jekyll _config.yml
SLIDES := $(shell ruby -e "require 'yaml';puts YAML.load_file('docs/_config.yml')['slide_sorter']")
LESSON := $(shell ruby -e "require 'yaml';puts YAML.load_file('docs/_config.yml')['lesson']")

# list available Markdown, RMarkdown and Pweave slides
SLIDES_MD := $(shell find . -path "./docs/_slides_md/*.md")
SLIDES_RMD := $(shell find . -path "./docs/_slides_Rmd/*.Rmd")
SLIDES_PMD := $(shell find . -path "./docs/_slides_pmd/*.pmd")

# look up files for trainees in Jekyll _config.yml
HANDOUTS := $(shell ruby -e "require 'yaml';puts YAML.load_file('docs/_config.yml')['handouts']")
COURSE_HANDOUTS := $(HANDOUTS:worksheet%=worksheet-$(LESSON)%)
COURSE_HANDOUTS := $(COURSE_HANDOUTS:%=../../release/%)

# do not run rules in parallel; because
# bin/build_slides.* runs over all .Rmd and .pmd slides
.NOTPARALLEL:
.DEFAULT_GOAL: slides
.PHONY: course lesson slides archive

# target to check files in docs/_slides
slides: $(SLIDES:%=docs/_slides/%.md) | .git/refs/remotes/upstream

# target to ensure upstream remote is lesson-style
.git/refs/remotes/upstream:
	git remote add upstream "git@github.com:sesync-ci/lesson-style.git"
	git fetch upstream
	git checkout -b upstream upstream/master
	git checkout master

# cannot use a pattern as the next three targets, because
# the targets are only a subset of docs/_slides/%.md and
# they have different recipes
$(subst _md,,$(SLIDES_MD)): docs/_slides/%: docs/_slides_md/%
	cp $< $@
$(subst _Rmd,,$(SLIDES_RMD:.Rmd=.md)): $(SLIDES_RMD)
	@bin/build_slides.R
$(subst _pmd,,$(SLIDES_PMD:.pmd=.md)): $(SLIDES_PMD)
	@bin/build_slides.py

# target to update lesson repo on GitHub
lesson: slides
	git pull
	git fetch upstream master:upstream
	git merge --no-edit upstream
	git push

# target copies lesson handouts to the ../../release/ director,
# while adding lesson numbers to worksheets
.SECONDEXPANSION:
$(COURSE_HANDOUTS): $$(patsubst worksheet-$(LESSON)%,worksheet%,$$(subst ../../release/,,$$@))
	cp -r $< $@

# targets keep jekyll site up to date for RStudio Viewer presentation on port 4000
export GEM_HOME=$(HOME)/.gem
SITE = $(shell find ./docs/ ! -name _site)
docs/_site: $(SITE) | docs/Gemfile.lock
	pushd docs && bundle exec jekyll build --baseurl=/p/4000 && popd
	touch docs/_site
docs/Gemfile.lock:
	pushd docs && bundle install && popd

# make target "course" is called within the handouts Makefile,
# assumed to be at ../../
course: lesson $(COURSE_HANDOUTS) docs/_site

# call the archive target with a
# command line parameter for DATE
archive:
	@curl -L "https://sesync-ci.github.io/$${PWD##*/}/course/archive.html" -o docs/_posts/$(DATE)-index.html

# create binary for GitHub release
release:
	ln *.Rproj handouts.Rproj && zip -FSr handouts handouts.Rproj $(HANDOUTS) && rm handouts.Rproj
