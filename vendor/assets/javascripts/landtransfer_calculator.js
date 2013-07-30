function numberFilter (s) {
		filteredValues = "1234567890";     // Characters stripped out
		var i;
		var returnString = "";
		for (i = 0; i < s.length; i++) {  // Search through string and append to unfiltered values to returnString.
		var c = s.charAt(i);
		if (filteredValues.indexOf(c) != -1) returnString += c;
		}
			return returnString;
		}

		function calculate(){
			price = numberFilter(document.calculator.price.value);
			leftt = price;
			total_tax = 0;
			toronto_tax = 0;


			if (price > 55000){
				tmp_tax = 55000 * 0.005;
				total_tax += tmp_tax;
				price -= 55000;
			} else {
				tmp_tax = price * 0.005;
				total_tax += tmp_tax;
				price = 0;
			}


			if (price > 195000){
				tmp_tax = 195000 * 0.01;
				total_tax += tmp_tax;
				price -= 195000;
			} else {
				tmp_tax = price * 0.01;
				total_tax += tmp_tax;
				price = 0;
			}


			if (price > 150000){
				tmp_tax = 150000 * 0.015;
				total_tax += tmp_tax;
				price -= 150000;
			} else {
				tmp_tax = price * 0.015;
				total_tax += tmp_tax;
				price = 0;
			}

			if (price > 0){
				tmp_tax = price * 0.02;
				total_tax += tmp_tax;
				price = 0;
			}

			if (document.calculator.firsttimehomebuyer.checked==true){
				if (total_tax > 2000)
					total_tax = total_tax - 2000;
				else
					total_tax = 0;
			}
			total_tax = Math.round(total_tax);
			if (document.calculator.torontopurchase.checked==true){
				if (leftt > 55000){
					toronto_tax = 275;
					leftt = leftt - 55000;
				} else {
					toronto_tax = leftt * .005;
					leftt = 0;
				}


				if (leftt > 345000){
					toronto_tax = toronto_tax + 3450;
					leftt = leftt - 345000;
				} else {
					toronto_tax = toronto_tax + (leftt * .01);
					leftt = 0;
				}

				if (document.calculator.firsttimehomebuyer.checked==true)
					toronto_tax = 0;

				if (leftt > 0){
					toronto_tax = toronto_tax + (leftt * .02);
				}
				toronto_tax = Math.round(toronto_tax);
				total_tax = total_tax + toronto_tax;
			}

			document.calculator.tax.value = total_tax;

		}