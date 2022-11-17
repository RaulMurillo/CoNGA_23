# Example of usage

cmake -DUSE_Posit=ON -DLOG_APPROX=OFF .
make
mkdir -p cat_posit
./kmeans chelsea.txt 16 cat_posit &

cmake -DUSE_Posit=ON -DLOG_APPROX=ON .
make
mkdir -p cat_posit_approx
./kmeans chelsea.txt 16 cat_posit_approx &

cmake -DUSE_Posit=OFF .
make
mkdir -p cat_float
./kmeans chelsea.txt 16 cat_float
