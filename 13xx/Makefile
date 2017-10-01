all:
	@for a in $$(ls); do \
		if [ -d $$a ]; then \
			echo "Running 'make' in subdirectory $$a"; \
			cd $$a ; make; cd ..; \
		fi; \
		done;

clean:
	@for a in $$(ls); do \
		if [ -d $$a ]; then \
			echo "Running 'make clean' in subdirectory $$a"; \
			cd $$a ; make clean; cd ..; \
		fi; \
		done;


