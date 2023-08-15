CC = gcc
CXX = g++
CFLAGS = -O3 -pthread -DGGML_USE_K_QUANTS
CXXFLAGS = -O3 -pthread -DGGML_USE_K_QUANTS

simple: simple.cpp ggml.o llama.o common.o ggml-alloc.o k_quants.o
	$(CXX) $(CXXFLAGS) $(filter-out %.h,$^) -o $@ $(LDFLAGS)

ggml.o: ggml.c ggml.h
	$(CC) $(CFLAGS) -c $< -o $@

ggml-alloc.o: ggml-alloc.c ggml.h ggml-alloc.h
	$(CC) $(CFLAGS) -c $< -o $@

k_quants.o: k_quants.c k_quants.h
	$(CC) $(CFLAGS) -c $< -o $@

llama.o: llama.cpp ggml.h ggml-alloc.h llama.h llama-util.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

common.o: common.cpp common.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -vf *.o simple
