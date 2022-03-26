<?php
session_start();
error_reporting(1);
$status=0;
$isread=0;
include('includes/config.php');
if(isset($_POST['submit2']))
{
$pid=intval($_GET['pkgid']);
$useremail=$_SESSION['login'];
$noofpeople=$_POST['noofpeople'];
$fromdate=$_POST['fromdate'];
$todate=$_POST['todate'];
$comment=$_POST['comment'];
$status=0;
$sqll="INSERT INTO tblbooking(PackageId,UserEmail,FromDate,ToDate,Comment,NoOfPeople,status) VALUES(:pid,:useremail,:fromdate,:todate,:comment,:noofpeople,:status)";
$query = $dbh->prepare($sqll);
$query->bindParam(':pid',$pid,PDO::PARAM_STR);
$query->bindParam(':useremail',$useremail,PDO::PARAM_STR);
$query->bindParam(':noofpeople',$noofpeople,PDO::PARAM_STR);
$query->bindParam(':fromdate',$fromdate,PDO::PARAM_STR);
$query->bindParam(':todate',$todate,PDO::PARAM_STR);
$query->bindParam(':comment',$comment,PDO::PARAM_STR);
$query->bindParam(':status',$status,PDO::PARAM_STR);
try {
		$query->execute();
		$lastInsertId = $dbh->lastInsertId();
		$sql8="CALL `costperpersonupdate`()";
		$query8 = $dbh->prepare($sql8);
		$query8->execute();
		$sql9 = "CALL `totalcostupdate`()";
		$query9 = $dbh->prepare($sql9);
		$query9->execute();
		if($fromdate > $todate){
			$error=" To Date should be greater than From Date ";
			$sql5="DELETE FROM tblbooking WHERE BookingId = (SELECT MAX(BookingId) FROM tblbooking);";
			$query5 = $dbh->prepare($sql5);
			$query5->execute();
		}
		elseif($lastInsertId)
		{
		$msg="Booked Successfully";
		}
		else 
		{
		$error="Something went wrong. Please try again";
		}
	}catch(PDOException $e) {
	   	$errmsg = $e->getMessage();
		$errData = explode(":",$errmsg);
	   	$error= $errData[3];
	   
	}
}
?>
<!DOCTYPE HTML>
<html>
<head>
<title>TMS | Package Details</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="applijewelleryion/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<link href="css/style.css" rel='stylesheet' type='text/css' />
<link href='//fonts.googleapis.com/css?family=Open+Sans:400,700,600' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,700,300' rel='stylesheet' type='text/css'>
<link href='//fonts.googleapis.com/css?family=Oswald' rel='stylesheet' type='text/css'>
<link href="css/font-awesome.css" rel="stylesheet">
<!-- Custom Theme files -->
<script src="js/jquery-1.12.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!--animate-->
<link href="css/animate.css" rel="stylesheet" type="text/css" media="all">
<script src="js/wow.min.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css" />
	<script>
		 new WOW().init();
	</script>
<script src="js/jquery-ui.js"></script>
					
	  <style>
		.errorWrap {
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #dd3d36;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
}
.succWrap{
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #5cb85c;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
}
		</style>				
</head>
<body>
<!-- top-header -->
<?php include('includes/header.php');?>
<div class="banner-3">
	<div class="container">
		<h1 class="wow zoomIn animated animated" data-wow-delay=".5s" style="visibility: visible; animation-delay: 0.5s; animation-name: zoomIn;"></h1>
	</div>
</div>
<!--- /banner ---->
<!--- selectroom ---->
<div class="selectroom">
	<div class="container">	
		  <?php if($error){?><div class="errorWrap"><strong>ERROR</strong>:<?php echo htmlentities($error); ?> 
		  </div>
		  <?php }
				else if($msg)
				{?>
				<?php
				$sql4 = "SELECT * FROM tblbooking ORDER BY BookingId DESC LIMIT 1";
				$query3 = $dbh->prepare($sql4);
				$query3->execute();
				$results2=$query3->fetchAll(PDO::FETCH_OBJ);
				if($results2){
				?>
				<div class="succWrap">
					<strong>SUCCESS</strong>:<?php echo htmlentities($msg);?><br>
					<br><h4>For Booking details check <div>
						<a href="tour-history.php" class="view">Booking Details</a>
					</div>
					</div>
				</h4>
				</div> <?php }}?>
<?php 
$pid=intval($_GET['pkgid']);
$sql3 = "SELECT * from tbltourpackages where PackageId=:pid";
$query4 = $dbh->prepare($sql3);
$query4 -> bindParam(':pid', $pid, PDO::PARAM_STR);
$query4->execute();
$results=$query4->fetchAll(PDO::FETCH_OBJ);
$cnt=1;
if($query4->rowCount() > 0)
{
foreach($results as $result)
{	?>

<form name="book" method="post">
		<div class="selectroom_top">
			<div class="col-md-4 selectroom_left wow fadeInLeft animated" data-wow-delay=".5s">
				<img src="admin/pacakgeimages/<?php echo htmlentities($result->PackageImage);?>" class="img-responsive" alt="">
			</div>
			<div class="col-md-8 selectroom_right wow fadeInRight animated" data-wow-delay=".5s">
				<h2><?php echo htmlentities($result->PackageName);?></h2>
				<p class="dow">#PKG-<?php echo htmlentities($result->PackageId);?></p>
				<p><b>Package Type :</b> <?php echo htmlentities($result->PackageType);?></p>
				<p><b>Package Location :</b> <?php echo htmlentities($result->PackageLocation);?></p>
				<p><b>Package Price :</b> <?php echo htmlentities($result->PackagePrice);?> per person*</p>
					<p><b>Features</b> <?php echo htmlentities($result->PackageFeatures);?></p>
					
					<li class="spe">
						<label class="inputLabel">Number Of People :</label>
						<input class="special" type="text" name="noofpeople" required="">
					</li>
					<div class="ban-bottom">
				<div class="bnr-right"><br>
				<label class="inputLabel">From</label>
				<input class="date" id="datepicker" type="date" placeholder="dd-mm-yyyy"  name="fromdate" required="">
			</div>
			<div class="bnr-right"><br>
				<label class="inputLabel">To</label>
				<input class="date" id="datepicker1" type="date" placeholder="dd-mm-yyyy" name="todate" required="">
			</div>
			</div>
						<div class="clearfix"></div>
			</div>
		<h3>Package Details</h3>
				<p style="padding-top: 1%"><?php echo htmlentities($result->PackageDetails);?> </p>	
				<div class="clearfix"></div>
		</div>
		<div class="selectroom_top">
			<h2>Travels</h2>
			<div class="selectroom-info animated wow fadeInUp animated" data-wow-duration="1200ms" data-wow-delay="500ms" style="visibility: visible; animation-duration: 1200ms; animation-delay: 500ms; animation-name: fadeInUp; margin-top: -70px">
				<ul>
				
					<li class="spe">
						<label class="inputLabel">Expectations out of the Tour:</label>
						<input class="special" type="text" name="comment" required="">
					</li>
					<?php if($_SESSION['login'])
					{?>
						<li class="spe" align="center">
					<button type="submit" name="submit2" class="btn-primary btn">Book</button>
						</li>
						<?php } else {?>
							<li class="sigi" align="center" style="margin-top: 1%">
							<a href="#" data-toggle="modal" data-target="#myModal4" class="btn-primary btn" > Book</a></li>
							<?php } ?>
					<div class="clearfix"></div>
				</ul>
			</div>
			
		</div>
		</form>
<?php }} ?>


	</div>
</div>
<!--- /selectroom ---->
<<!--- /footer-top ---->
<?php include('includes/footer.php');?>
<!-- signup -->
<?php include('includes/signup.php');?>			
<!-- //signu -->
<!-- signin -->
<?php include('includes/signin.php');?>			
<!-- //signin -->
<!-- write us -->
<?php include('includes/write-us.php');?>
</body>
</html>