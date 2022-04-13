function I = readimage(image_file) 
    addpath data 
    I=imread(image_file);
        if (size(I,3))
            I=rgb2gray(I);
        end
end