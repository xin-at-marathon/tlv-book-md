struct := $(shell cat struct.conf).trln

view_file := index.trln
struct_file := deps/treeline-struct-repo/src/$(struct)

.PHONY: new edit merge
new:
	@if [ -f "$(view_file)" ]; then echo "File $(view_file) already exists."; exit -1; fi
	cp $(struct_file) $(view_file)

edit:
	treeline $(view_file) &

merge: $(view_file)
$(view_file): $(struct_file)
	docker run -it --rm -v $(PWD):/data bryt/treeline-cmd mergefmt $< $@ $@


.PHONY: submodule submodule-clean
submodule:
	make -f Makefile.submodule
submodule-clean:
	make -f Makefile.submodule clean
