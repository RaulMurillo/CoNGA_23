# Example of usage

cmake -DUSE_Posit=OFF .
make
./blur

cmake -DUSE_Posit=ON -DLOG_APPROX=OFF .
make
./blur

cmake -DUSE_Posit=ON -DLOG_APPROX=ON .
make
./blur
