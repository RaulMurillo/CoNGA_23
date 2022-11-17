# Example of usage

cmake -DUSE_Posit=OFF -DLOG_APPROX=OFF .
make
./knn

cmake -DUSE_Posit=ON -DLOG_APPROX=OFF .
make
./knn

cmake -DUSE_Posit=ON -DLOG_APPROX=ON .
make
./knn
