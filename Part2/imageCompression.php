<?php
function compressAndSaveImage($ext,$uploadedfile,$path,$newwidth, $newheight = -1)
{
	/* create prior image data */
	if($ext=="jpg" || $ext=="jpeg" )
	{
		$src = imagecreatefromjpeg($uploadedfile);
	}
	else if($ext=="png")
	{
		$src = imagecreatefrompng($uploadedfile);
	}
	else if($ext=="gif")
	{
		$src = imagecreatefromgif($uploadedfile);
	}
	else
	{
		$src = imagecreatefrombmp($uploadedfile);
	}

	/* get information about the image before resize */
	list($width,$height)=getimagesize($uploadedfile);
	
	/* Calculate new height if not specified by user call */
	if ($newheight == -1)
		$newheight=($height/$width)*$newwidth;
		
	/* Create resized image empty data */
	$tmp=imagecreatetruecolor($newwidth,$newheight);
	
	/* Copy prior image data in the new data */
	imagecopyresampled($tmp,$src,0,0,0,0,$newwidth,$newheight,$width,$height);
	
	/* Create a compressed image in path*/
	if (imagejpeg($tmp,$path,100))
	{
		echo  '<span id="noerror">Success!</span><br/><br/>';
	}
	else 
	{
		echo '<span id="error">Error!</span><br/><br/>';
	}
	
	/* Destroy template */
	imagedestroy($tmp);
	
	return $path;
}
?>