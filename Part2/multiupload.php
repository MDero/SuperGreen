<!DOCTYPE html>
<html>
<head>
<title> Upload Images to the server </title>

<!-------Including jQuery from Google ------>
<script src="jquery.min.js"></script>

<!------- Including CSS File ------>
<link rel="stylesheet" type="text/css" href="style.css">

<body>
		<div id="formdiv">
		
			<form enctype="multipart/form-data" action="" method="post">
			<h1>Image Upload</h1>
			Only JPG, JPEG,PNG, and GIF can be Uploaded. 
			
			<br><br>
			
			<input id="file" name="file[]" type="file" multiple="" />
			
			<br><br>
			
			<input type="submit" value="Upload File" name="submit" id="upload" class="upload"/>
			
			
			<br><br>
			
			<?php include "upload.php"; ?>

			</form>

		</div>
</body>

</html>