# Example of usage

Create a building folder
```
mkdir build
cd build
```
and from there, build the project with any of the following configurations (default options yield to standard float configuration):
* Standard floating-point:
    ```
    cmake -DUSE_Posit=OFF ..
    make
    ./knn
    ```
* Standard posit:
    ```
    cmake -DUSE_Posit=ON -DLOG_APPROX=OFF ..
    make
    ./knn
    ```
* Approximate posit:
    ```
    cmake -DUSE_Posit=ON -DLOG_APPROX=ON ..
    make
    ./knn
    ```
