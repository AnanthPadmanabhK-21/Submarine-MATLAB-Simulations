% Step 1: Read Input Image
img = imread('football.jpg'); % Replace with actual file
figure, imshow(img); title('Original Image');

% Step 2: Convert to Grayscale if Color Image
if size(img,3) == 3
    gray_img = rgb2gray(img);
else
    gray_img = img;
end
figure, imshow(gray_img); title('Grayscale Image');

% Step 3: Noise Removal (Median Filter)
filtered_img = medfilt2(gray_img, [3 3]);
figure, imshow(filtered_img); title('Filtered Image');

% Step 4: Crack/Edge Detection using Canny Algorithm
edges = edge(filtered_img, 'canny');
figure, imshow(edges); title('Detected Cracks/Edges (Canny)');

% Step 5: Overlay Detected Edges on Original Image
crack_overlay = img;
crack_overlay(:,:,1) = uint8(double(img(:,:,1)) + 120*edges); % Red highlight
figure, imshow(crack_overlay); title('Original Image with Crack Overlay');

% Step 6: Rust Detection by Color Segmentation (reddish/brown mask)
rust_mask = (img(:,:,1) > 100 & img(:,:,2) < 90 & img(:,:,3) < 80);
figure, imshow(rust_mask); title('Rust Segmentation (Red/Brown Areas)');

% Step 7: Quantify Rust Coverage Percentage
rust_area = sum(rust_mask(:));
total_area = numel(rust_mask);
rust_percentage = (rust_area / total_area) * 100;
fprintf('Estimated Rust Coverage: %.2f%%\n', rust_percentage)

% Step 8: Highlight Rust on Original Image
rust_overlay = img;
rust_overlay(repmat(rust_mask, [1 1 3])) = 255; % White highlight
figure, imshow(rust_overlay); title('Original Image with Rust Highlighted');
