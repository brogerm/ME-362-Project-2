diskPixelLocations = [];

%%

for i=1:1:10
    picNumbers = ["0", "0", "0", "0", "0", "0", "0", "0", "0", "0"];
    filePath = sprintf('./pics/disk%s.jpg', picNumbers(i));
    Image = imread(filePath);
    figure(1),clf
    imshow(Image)

    [L, R] = ginput2(5);
    
    diskPixelLocations(end + 1) = mean(L)
end
