<?php

class Constants 
{
	/* Some static variables */
	const BASE_PATH = "../../backofficeimages/";
	static $valid_extensions = array("jpeg", "jpg", "png");
	const MAX_WIDTH = 900;
	const MAX_HEIGHT = 360; 
}
	
/* Script to be executed every time */
if (isset($_POST['submit'])) 
{
	/* Prepare variables to assess success or failure */
	$successes = 0; 
	$failures = 0; 

	/* Execution */
	$count = count($_FILES['file']['name']);
	for ($i = 0; $i < $count; ++$i) 
	{
		//extract file extension
		$filename =  $_FILES['file']['name'][$i];
		$expl = explode('.', $filename);
		$ext = end($expl);
		
		//file name
		$filename = $_FILES['file']['tmp_name'][$i];
		
		//compute the image 
		if (computeImage($ext,$filename))
		{
			$successes++;
		}
		else 
		{
			$failures++;	
		}	
	}
	
	echo  '<span id="result"><p class="noerror">'.$successes.' succeeded</p><p class="error">'.$failures.' failed </p></span><br/><br/>';
	
	
}

function computeImage($ext,$filename)
{
	//guarantee file name uniqueness
	$target_path = Constants::BASE_PATH . md5(uniqid()) . "." . $ext;

	if (in_array($ext, Constants::$valid_extensions)) 
	{
		/*Compress image and store it */
		list($width,$height)=getimagesize($filename);
		
		//determine if there is a need to compress 
		$jpg = ($ext == "jpg"|| $ext == "jpeg");
		if ($width > Constants::MAX_WIDTH || $height > Constants::MAX_HEIGHT || !$jpg)//need to compress
		{
			/* create prior image data depending on extension */
			if($jpg)
			{
				$src = imagecreatefromjpeg($filename);
			}
			else if($ext=="png")
			{
				$src = imagecreatefrompng($filename);
			}
			else if($ext=="gif")
			{
				$src = imagecreatefromgif($filename);
			}
			else
			{
				$src = imagecreatefrombmp($filename);
			}
					
			/* Calculate new size */			
			$newSize = fit($width,$height,Constants::MAX_WIDTH,Constants::MAX_HEIGHT);
			$newWidth = $newSize[0];
			$newHeight = $newSize[1];
					
			/* Create resized image empty data */
			$tmp=imagecreatetruecolor($newWidth,$newHeight);
			
			/* Copy prior image data in the new data */
			imagecopyresampled($tmp,$src,0,0,0,0,$newWidth,$newHeight,$width,$height);
			
			/* Create a compressed image in path*/
			$success = imagejpeg($tmp,$target_path,100);
			
			/* Destroy template */
			imagedestroy($tmp);		
					
			return $success;
		}
		else 
		{
			//no compression, store the image as is 
			return move_uploaded_file($filename,$target_path);
		}				
		
	}
	else  
	{    
		echo '<span id="error">'.$filename.'<br>File too big or is of unsupported format</span><br/><br/>';
	}
}

function fit($srcWidth, $srcHeight, $maxWidth, $maxHeight) 
{
    $ratio = min($maxWidth / $srcWidth, $maxHeight / $srcHeight);
    return array($srcWidth*$ratio,$srcHeight*$ratio);
}

?>