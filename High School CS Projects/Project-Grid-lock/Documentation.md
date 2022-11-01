# Documentation
#### Pypi link:  https://pypi.org/project/Project-Grid-lock/ <br><br>

**grid(image_url)** <br>

Specify the url of an image as input to obtain a base64 data url in response. Can be used in an img tag.<br><br>
Best supports 1:1, 4:3 or 16:9. <br><br>
It can accomodate for slight imperfections. <br><br>

**pixel_selection(a,b,c,d,e,f)**<br><br>
Specify 6 boxes from the gridded image to obtain an extended, encrypted string in return. The encryption was our fun attempt at the art, (it is by no means secure...) so don't use it in place of serious options!

Always returns the same string with the same inputs.<br>

<br><br>**Known issues**<br>
The use of an absolute path image in the pixel_selection may cause it to crash.
