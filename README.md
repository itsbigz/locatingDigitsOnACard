# locating Digits On A Card
In this project, I will try to locate the 16 digits on a credit card with a rectangle. I used the example in this link  to recognize characters in the image. As it is explained in the link:
Step 1: Detect Candidate Text Regions Using MSER
The MSER feature detector works well for finding text regions. It works well for text because the consistent color and high contrast of text leads to stable intensity profiles.
Use the detectMSERFeatures function to find all the regions within the image and plot these results. Notice that there are many non-text regions detected alongside the text.
detectMSERFeatures
Detect MSER features and return MSERRegions object. 
In computer vision, maximally stable extremal regions (MSER) are used as a method of blob detection  in images. This technique was proposed by Matas et al. to find correspondences between image elements from two images with different viewpoints. 
regions = detectMSERFeatures(I) returns an MSERRegions object, regions, containing information about MSER features detected in the 2-D grayscale input image, I. This object uses Maximally Stable Extremal Regions (MSER) algorithm to find regions.
[regions,cc] = detectMSERFeatures(I)optionally returns MSER regions in a connected component structure.
[___] = detectMSERFeatures(I,Name,Value) sets additional options specified by one or more Name,Value pair arguments.
The following tables list of some of the properties that are used in the text detection example.
Property Name	Description	N-D Support	GPU Support	Code Generation
'BoundingBox'	Smallest rectangle containing the region, returned as a 1-by-Q*2 vector, where Q is the number of image dimensions. For example, in the vector [ul_corner width], ul_corner specifies the upper-left corner of the bounding box in the form [x y z ...]. width specifies the width of the bounding box along each dimension in the form [x_width y_width ...]. regionprops uses ndims to get the dimensions of label matrix or binary image, ndims(L), and numel to get the dimensions of connected components, numel(CC.ImageSize).	Yes	Yes	Yes
'Centroid'	Center of mass of the region, returned as a 1-by-Q vector. The first element of Centroid is the horizontal coordinate (or x-coordinate) of the center of mass. The second element is the vertical coordinate (or y-coordinate). All other elements of Centroid are in order of dimension. This figure illustrates the centroid and bounding box for a discontiguous region. The region consists of the white pixels; the green box is the bounding box, and the red dot is the centroid.	Yes	Yes	Yes
'Eccentricity'	Eccentricity of the ellipse that has the same second-moments as the region, returned as a scalar. The eccentricity is the ratio of the distance between the foci of the ellipse and its major axis length. The value is between 0 and 1. (0 and 1 are degenerate cases. An ellipse whose eccentricity is 0 is actually a circle, while an ellipse whose eccentricity is 1 is a line segment.)	2-D only	Yes	Yes
'EulerNumber'	Number of objects in the region minus the number of holes in those objects, returned as a scalar. This property is supported only for 2-D label matrices. regionprops uses 8-connectivity to compute the Euler number measurement. To learn more about connectivity, see Pixel Connectivity.
2-D only	No	Yes
'Extent'	Ratio of pixels in the region to pixels in the total bounding box, returned as a scalar. Computed as the Area divided by the area of the bounding box.	2-D only	Yes	Yes
'Image'	Image the same size as the bounding box of the region, returned as a binary (logical) array. The on pixels correspond to the region, and all other pixels are off.	Yes	Yes	Yes
'Solidity'	Proportion of the pixels in the convex hull that are also in the region, returned as a scalar. Computed as Area/ConvexArea.	2-D only	No	No

Step 2: Remove Non-Text Regions Based On Basic Geometric Properties
Although the MSER algorithm picks out most of the text, it also detects many other stable regions in the image that are not text. You can use a rule-based approach to remove non-text regions. 
There are several geometric properties that are good for discriminating between text and non-text regions, including:
•	Aspect ratio
•	Eccentricity
•	Euler number
•	Extent
•	Solidity
Use regionprops to measure a few of these properties and then remove regions based on their property values.
Regionprops: Measure properties of image regions.
stats = regionprops(BW,properties) returns measurements for the set of properties specified by properties for each 8-connected component (object) in the binary image, BW. Stats is struct array containing a struct for each object in the image. You can use regionprops on contiguous regions and discontiguous regions.
Step 3: Remove Non-Text Regions Based On Stroke Width Variation
Another common metric used to discriminate between text and non-text is stroke width. Stroke width is a measure of the width of the curves and lines that make up a character. Text regions tend to have little stroke width variation, whereas non-text regions tend to have larger variations.
To help understand how the stroke width can be used to remove non-text regions, estimate the stroke width of one of the detected MSER regions. You can do this by using a distance transform and binary thinning operation.
D = bwdist(BW) computes the Euclidean distance transform of the binary image BW. For each pixel in BW, the distance transform assigns a number that is the distance between that pixel and the nearest nonzero pixel of BW.
Morphological operations on binary images.
BW2 = bwmorph(BW,operation,n) applies the operation n times. n can be Inf, in which case the operation is repeated until the image no longer changes.
'thin': With n = Inf, thins objects to lines. It removes pixels so that an object without holes shrinks to a minimally connected stroke, and an object with holes shrinks to a connected ring halfway between each hole and the outer boundary. This option preserves the Euler number.
Step 4: Merge Text Regions for Final Detection Result
At this point, all the detection results are composed of individual text characters. To use these results for recognition tasks, such as OCR, the individual text characters must be merged into words or text lines. This enables recognition of the actual words in an image, which carries more meaningful information than just the individual characters.
One approach for merging individual text regions into words or text lines is to first find neighboring text regions and then form a bounding box around these regions. To find neighboring regions, expand the bounding boxes computed earlier with regionprops. This makes the bounding boxes of neighboring text regions overlap such that text regions that are part of the same word or text line form a chain of overlapping bounding boxes.
As it was explained above, in this example of automatic text detection, it first segments the picture using detectMSERFeatures function and then removes the non-text parts and shows the digits using a rectangle. I have changed the parameters in the code and it is different for 1 card or a few cards. In the following segment, I will include the Matlab code and the result of my experiments:

refrence:
https://www.mathworks.com/help/vision/examples/automatically-detect-and-recognize-text-in-natural-images.html
https://www.mathworks.com/help/vision/ref/detectmserfeatures.html#namevaluepairarguments
https://en.wikipedia.org/wiki/Blob_detection
https://en.wikipedia.org/wiki/Maximally_stable_extremal_regions
https://www.mathworks.com/help/images/ref/regionprops.html#buoixjn-1-CC
