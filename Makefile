.PHONY: compile debug test clean check-env all


all: compile


clean:
	rm -fr dist/ doc/_build/
	rm -fr asyncpg/*.c asyncpg/*.html asyncpg/*.so build *.egg-info
	rm -fr asyncpg/codecs/*.html
	find . -name '__pycache__' | xargs rm -rf


check-env:
	python -c "import cython; (cython.__version__ < '0.24') and exit(1)"


compile: check-env clean
	cython asyncpg/protocol.pyx
	python setup.py build_ext --inplace


debug: check-env clean
	cython -a asyncpg/protocol.pyx
	python setup.py build_ext --inplace --debug


test:
	PYTHONASYNCIODEBUG=1 python -m unittest discover -s tests
	python -m unittest discover -s tests
