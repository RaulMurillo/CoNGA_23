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
    ./sobel
    ```
* Standard posit:
    ```
    cmake -DUSE_Posit=ON -DLOG_APPROX=OFF ..
    make
    ./sobel
    ```
* Approximate posit:
    ```
    cmake -DUSE_Posit=ON -DLOG_APPROX=ON ..
    make
    ./sobel
    ```

Results will be shown in the [`/imgs`](./imgs) folder.
