# Example of usage

cmake -DUSE_Posit=OFF .
make
./sobel

cmake -DUSE_Posit=ON -DLOG_APPROX=OFF .
make
./sobel

cmake -DUSE_Posit=ON -DLOG_APPROX=ON .
make
./sobel
