import numpy as np
import skimage.data as skd
from skimage.metrics import peak_signal_noise_ratio as psnr
from skimage.metrics import structural_similarity as ssim

# Read input files and store images

#############
#    CAT    #
#############
print('### CAT ###')
rows, cols = 300, 451

cat=skd.chelsea()

# Exact division - float
print('### Float ###')
my_clusters = np.genfromtxt('cat_float/16-clusters.txt')
my_labels = np.genfromtxt('cat_float/16-points.txt', dtype=int)-1

compressed_cat = my_clusters[my_labels]*255
compressed_cat = np.clip(compressed_cat.astype('uint8'), 0, 255)

#Reshape the image to original dimension
compressed_cat = compressed_cat.reshape(rows, cols, 3)

# Compute PSNR
psnr_val = psnr(cat, compressed_cat)
print("PSNR:", psnr_val)

# Compute SSIM
ssim_val = ssim(cat, compressed_cat, channel_axis=2)
print("SSIM:", ssim_val)

# Exact division - posit
print('### Posit ###')
my_clusters = np.genfromtxt('cat_posit/16-clusters.txt')
my_labels = np.genfromtxt('cat_posit/16-points.txt', dtype=int)-1

compressed_cat = my_clusters[my_labels]*255
compressed_cat = np.clip(compressed_cat.astype('uint8'), 0, 255)

#Reshape the image to original dimension
compressed_cat = compressed_cat.reshape(rows, cols, 3)

# Compute PSNR
psnr_val = psnr(cat, compressed_cat)
print("PSNR:", psnr_val)

# Compute SSIM
ssim_val = ssim(cat, compressed_cat, channel_axis=2)
print("SSIM:", ssim_val)

# Approximate division
print('### Log Approx Posit ###')
approx_my_clusters = np.genfromtxt('cat_posit_approx/16-clusters.txt')
approx_my_labels = np.genfromtxt('cat_posit_approx/16-points.txt', dtype=int)-1

approx_compressed_cat = approx_my_clusters[approx_my_labels]*255
approx_compressed_cat = np.clip(approx_compressed_cat.astype('uint8'), 0, 255)

#Reshape the image to original dimension
approx_compressed_cat = approx_compressed_cat.reshape(rows, cols, 3)

# Compute PSNR
psnr_val = psnr(cat, approx_compressed_cat)
print("PSNR:", psnr_val)

# Compute SSIM
ssim_val = ssim(cat, approx_compressed_cat, channel_axis=2)
print("SSIM:", ssim_val)

# #############
# # ASTRONAUT #
# #############
# print('### ASTRONAUT ###')
# rows, cols = 512, 512

# astronaut = iio.imread('imageio:astronaut.png')

# # Exact division
# my_clusters = np.genfromtxt('kmeans_posit/astronaut/32-clusters.txt')
# my_labels = np.genfromtxt('kmeans_posit/astronaut/32-points.txt', dtype=int)-1

# compressed_astronaut = my_clusters[my_labels]*255
# compressed_astronaut = np.clip(compressed_astronaut.astype('uint8'), 0, 255)

# #Reshape the image to original dimension
# compressed_astronaut = compressed_astronaut.reshape(rows, cols, 3)

# # Compute PSNR
# psnr = cv2.PSNR(astronaut, compressed_astronaut)
# print("PSNR:", psnr)

# # Compute SSIM
# ssim_value = ssim(astronaut, compressed_astronaut, channel_axis=2)
# print("SSIM:", ssim_value)

# # Approximate division
# approx_my_clusters = np.genfromtxt('kmeans_approx/astronaut/32-clusters.txt')
# approx_my_labels = np.genfromtxt('kmeans_approx/astronaut/32-points.txt', dtype=int)-1

# approx_compressed_astronaut = approx_my_clusters[approx_my_labels]*255
# approx_compressed_astronaut = np.clip(approx_compressed_astronaut.astype('uint8'), 0, 255)

# #Reshape the image to original dimension
# approx_compressed_astronaut = approx_compressed_astronaut.reshape(rows, cols, 3)

# # Compute PSNR
# psnr = cv2.PSNR(astronaut, approx_compressed_astronaut)
# print("PSNR:", psnr)

# # Compute SSIM
# ssim_value = ssim(astronaut, approx_compressed_astronaut, channel_axis=2)
# print("SSIM:", ssim_value)