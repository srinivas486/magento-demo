<!DOCTYPE html>
<html lang="en">
<head>
	<title>Customer Provisioner</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->
	<link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/noui/nouislider.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body>


	<div class="container-provision100">
		<div class="wrap-provision100">
			<form class="provision100-form validate-form" action="/provision" method="post">
				<span class="provision100-form-title">
					Provision Customer
				</span>

				<div class="wrap-input100 validate-input bg1" data-validate="Please Type Site Name">
					<span class="label-input100">Site Name *</span>
					<input class="input100" type="text" name="name" placeholder="Enter Site Name">
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100 validate-input">
					<span class="label-input100">Admin First Name</span>
					<input class="input100" type="text" name="adminfname" placeholder="Enter Admin First Name">
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100 validate-input">
					<span class="label-input100">Admin Last Name</span>
					<input class="input100" type="text" name="adminlname" placeholder="Enter Admin Last Name">
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100 validate-input">
					<span class="label-input100">Admin User Name</span>
					<input class="input100" type="text" name="adminuname" placeholder="Enter Admin User Name">
				</div>

				<div class="wrap-input100 bg1 rs1-wrap-input100 validate-input">
					<span class="label-input100">Admin Password</span>
					<input class="input100" type="password" name="adminpwd" placeholder="Enter Admin Password">
				</div>

				<div class="wrap-input100 validate-input bg1 rs1-wrap-input100" data-validate = "Enter Admin Email (e@a.x)">
					<span class="label-input100">Admin Email *</span>
					<input class="input100" type="text" name="email" placeholder="Enter Admin Email ">
				</div>



				<div class="wrap-input100 rs1-wrap-input100 bg1">
					<span class="label-input100">Site Currency *</span>
					<div>
						<select class="js-select2" name="currency">
							<option>Please chooses</option>
							<option>AUD</option>
							<option>USD</option>
							<option>INR</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>

				<div class="wrap-input100 rs1-wrap-input100 bg1">
					<span class="label-input100">Site Language *</span>
					<div>
						<select class="js-select2" name="language">
							<option>Please chooses</option>
							<option>en_US</option>
							<option>en_AU</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>

				<div class="wrap-input100 rs1-wrap-input100 bg1">
					<span class="label-input100">Site Timezone *</span>
					<div>
						<select class="js-select2" name="timezone">
							<option>Please chooses</option>
							<option>Australia/Sydney</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>

				<div class="wrap-input100 rs1-wrap-input100 bg1">
					<span class="label-input100">Select Region *</span>
					<div>
						<select class="js-select2" name="service">
							<option>Please chooses</option>
							<option>Minikube Local</option>
							<option>Melbourne (ALibaba Cloud)</option>
							<option>Melbourne (AWS)</option>
						</select>
						<div class="dropDownSelect2"></div>
					</div>
				</div>

				<div class="w-full">
					<div class="wrap-provision100-form-radio">
						<span class="label-input100">Select plan type</span>

						<div class="provision100-form-radio m-t-15">
							<input class="input-radio100" id="radio1" type="radio" name="type-service" value="basic" checked="checked">
							<label class="label-radio100" for="radio1">
								Basic
							</label>
						</div>

						<div class="provision100-form-radio">
							<input class="input-radio100" id="radio2" type="radio" name="type-service" value="silver">
							<label class="label-radio100" for="radio2">
								Silver
							</label>
						</div>

						<div class="provision100-form-radio">
							<input class="input-radio100" id="radio3" type="radio" name="type-service" value="platinum">
							<label class="label-radio100" for="radio3">
								Platinum
							</label>
						</div>
					</div>

					<div class="wrap-provision100-form-range">
						<span class="label-input100">Webservers *</span>

						<div class="provision100-form-range-value">
							<span id="value-lower">1</span>
							<input type="text" name="from-value">
							<input type="text" name="to-value">
						</div>

						<div class="provision100-form-range-bar">
							<div id="filter-bar"></div>
						</div>
						
					</div>
					
				</div>


				<div class="container-provision100-form-btn">
					<button class="provision100-form-btn" type=submit>
						<span>
							Provision
							<i class="fa fa-long-arrow-right m-l-7" aria-hidden="true"></i>
						</span>
					</button>
				</div>
			</form>
		</div>
		<div class="provisioning-animation" align="center" style="display: none; position:fixed; opacity: 0.50; z-index: 2;">
				<img id="loading" src="images/loading.gif" width="200px"/>
		</div>
	</div>

<!--===============================================================================================-->
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
	<script>
		$(".provision100-form").submit(function(event) {
			event.preventDefault();
			var form = $(this);
            var url = form.attr('action');

  			$(".provisioning-animation,#loading").show(); 
		   // $(".provision100-form").ajaxSubmit({url: 'provision', type: 'post'})
			$.ajax({

           type: "POST",
           url: url,
           data: form.serialize(), // serializes the form's elements.
           success: function(data)
           {
			$("#loading").hide(); 
			   $(".provisioning-animation").html(data);
              // alert(data); // show response from the php script.
           }
         });
        });
	</script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});


			$(".js-select2").each(function(){
				$(this).on('select2:close', function (e){
					if($(this).val() == "Please chooses") {
						$('.js-show-service').slideUp();
					}
					else {
						$('.js-show-service').slideUp();
						$('.js-show-service').slideDown();
					}
				});
			});
		})
	</script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/countdowntime/countdowntime.js"></script>
<!--===============================================================================================-->
	<script src="vendor/noui/nouislider.min.js"></script>
	<script>
	    var filterBar = document.getElementById('filter-bar');

	    noUiSlider.create(filterBar, {
	        start: [ 1 ],
	        connect: true,
	        range: {
	            'min': 1,
	            'max': 10
	        }
	    });

	    var skipValues = [
	    document.getElementById('value-lower'),
	    document.getElementById('value-upper')
	    ];

	    filterBar.noUiSlider.on('update', function( values, handle ) {
	        skipValues[handle].innerHTML = Math.round(values[handle]);
	        $('.provision100-form-range-value input[name="from-value"]').val($('#value-lower').html());
	        $('.provision100-form-range-value input[name="to-value"]').val($('#value-upper').html());
	    });
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>

  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>

</body>
</html>
