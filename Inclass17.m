%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 
img1 = imread('img1.tif');
img2 = imread('img2.tif');
diffs = zeros(1,500);
for ovv = 1:500;
    for ovh = 1:500
    pix1 = img1((end-ovh):end,(end-ovv):end);
    pix2 = img2(1:(1+ovh),1:(1+ovv));
    diffs(ovh,ovv) = sum(sum(abs(pix1-pix2)))/(ovv*ovh);
    end
end
[overlaph,overlapv] = min(min(diffs));
img_align = [zeros(800-18,1600-3);zeros(800,800-3),img2];
imshowpair(img1,img_align)

img1ft = fft2(img1);
img2ft = fft2(img2);
[nr,nc] = size(img2ft);
CC = ifft2(img1ft.*conj(img2ft));
CCabs = abs(CC);
figure; imshow(CCabs,[]);
[row_shift, col_shift] = find(CCabs == max(CCabs(:)));
Nr = ifftshift(-fix(nr/2):ceil(nr/2)-1);
Nc = ifftshift(-fix(nc/2):ceil(nc/2)-1);
row_shift = Nr(row_shift);
col_shift = Nc(col_shift);
img_shift = zeros(size(img2)*2-[row_shift,col_shift]);
img_shift((end-799):end,(end-799:end)) = img2;
figure; imshowpair(img1,img_shift);