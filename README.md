
Xylotones.com

This is a site to create halftone images from user picture uploads. Eventually, you will be able to have the resulting images engraved on consumer products.

It interfaces with Amazon S3, via carrierwave and fog to store images. 

The outcome of the algorithm is the information for dots. Each dot is then created as an SVG element that can be 
manipulated in the user's browser.

Current optimization work is going on in the branch "refactor_update."

To Do
- ~~write algorithm to analyze image and create dot information~~
- ~~create basic user interface to select remove dots~~
- ~~add ajax update to store which dots are deleted~~
- ~~add mass selection tool to remove more dots at once~~
- ~~push to heroku (xylotones.com)~~
- ~~optimize conversion algorithm~~
- rewrite testing
- give each image a unique url
- option to create image file from xylotone
- add edit tools
- add zoom to user viewport
- tie in ability to purchase design on consumer products

This has been a solo project by 1dlehands (Jeffrey Matthias).