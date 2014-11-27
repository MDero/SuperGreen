<!DOCTYPE html>
<html>
<head>
<title> Upload Images to the server </title>

<!-------Including jQuery from Google ------>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="script.js"></script>

<!------- Including CSS File ------>
<link rel="stylesheet" type="text/css" href="style.css">

<body>
	<div id="maindiv">
		<div id="formdiv">
		<h2>Image Upload</h2>
		<form enctype="multipart/form-data" action="" method="post">
		Only JPEG,PNG,JPG Type Image Uploaded. Image Size Should Be Less Than 100KB.
		
		<br><br>
		
		<input id="file" name="file[]" type="file" multiple="" />
		
		<br><br>
		
		<input type="submit" value="Upload File" name="submit" id="upload" class="upload"/>
		
		
		<br><br>
		
		<?php include "imageCompression.php" ?>
		<?php include "upload.php"; ?>

		</form>

		</div>
	</div>
</body>

</html>