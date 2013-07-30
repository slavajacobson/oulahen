function calcRefresh(e) {
	if (e.keyCode >= 48 && e.keyCode <= 57)
		doCalc(1);
		//e.value = e.value;
		//
}

function calcRefreshP(e,ev) {
	var ask_price = filterNum(document.getElementById("io_price").value);
	var percent = e.value;
	if (ev.keyCode >= 48 && ev.keyCode <= 57) {
		if (e.name == 'percent_down1') {
			document.getElementById("down_payment1").value = commaFmt(parseInt(ask_price * percent) / 100);
		}
		else if (e.name == 'percent_down2') {
			document.getElementById("down_payment2").value = commaFmt(parseInt(ask_price * percent) / 100);
		}
		else if (e.name == 'percent_down3') {
			document.getElementById("down_payment3").value = commaFmt(parseInt(ask_price * percent) / 100);
		}
		doCalc();
	}
}
function setPercent() {
	var ask_price = filterNum(document.getElementById("io_price").value);
	document.getElementById("down_payment1").value = commaFmt(parseInt(ask_price * 10) / 100);
	document.getElementById("down_payment2").value = commaFmt(parseInt(ask_price * 15) / 100);
	document.getElementById("down_payment3").value = commaFmt(parseInt(ask_price * 20) / 100);
}

function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}


function doCalc(n) {
//
//  return doCalcOnForm(MM_findObj("qualForm"));
if ($("#io_price").val().length < 1) {
	alert("Please enter the asking price");
	$("#io_price").css("background-color","rgb(255, 199, 199)");
	
}
else
	$("#io_price").css("background-color","white");
	doCalcOnForm(document.forms["AffordFORM"],n);
}

function clearColumn(form, nColumn) {
        // form[("down_payment" + nColumn)].value = "";
        form[("first_mortgage" + nColumn)].value = "";
        form[("cmhc" + nColumn)].value = "";
        form[("total_financing" + nColumn)].value = "";
        form[("monthly_payment" + nColumn)].value = "";
        form[("expenses" + nColumn)].value = "";
        form[("total_payment" + nColumn)].value = "";
        form[("income_required" + nColumn)].value = "";
}

function clearResults(form) {
        var nCounter = 0;
        for (nCounter = 1; nCounter <=3; nCounter++) {
                clearColumn(form, nCounter);
        }
}

function checkForm(form,n) {
        var nCounter = 0;
        var sResult = 0;
        var nResult = -1;
        var nIndex = 0;
        // validateNum(form.down_payment1,0,0,9999999,true);
		if (n != 1) {
			validateNum(form.down_payment1,0,0,9999999,true);
			validateNum(form.down_payment2,0,0,9999999,true);
			validateNum(form.down_payment3,0,0,9999999,true);
		}
        validateNum(form.io_price,0,1000,9999999,true);
        validateNum(form.io_interest,3,1,100, false);
        validateNum(form.io_heating,0,0,99999,true);
        validateNum(form.io_taxes,0,0,99999,true);
        validateNum(form.io_condo,0,0,99999,true);
        validateNum(form.io_gds,2,1,100);

        if ((form.io_price.value != "") &&
                (form.io_interest.value != "") &&
                (form.io_gds.value != "")) {
                return true;
        } else {
                return false;
        }
}

// function CMHCRate(PercentDown) {
function CMHCRate(PercentDown, Amortization) {

var PercentFinanced = 0;
PercentFinanced = Number(100 - Number(PercentDown));


var total_rate = 0.0;
total_rate = 0;



if (Amortization == 40)
	total_rate = .6;
else if (Amortization == 35)
	total_rate = .4;
else if (Amortization == 30)
	total_rate = .2;

        if (PercentFinanced <= 80)
                total_rate = 0;
        else if (PercentFinanced <= 85)
                total_rate = total_rate + 1.75;
        else if (PercentFinanced <= 90)
                total_rate = total_rate + 2.0;
        else if (PercentFinanced <= 95)
                total_rate = total_rate + 2.75;
        else if (PercentFinanced <= 100)
                total_rate = total_rate + 3.1;
	return total_rate;

}

function mortgagePayment(nAmount, nRate, nAmort) {
        var nAmortMonths = nAmort * 12;
        var nPaymentsPer6Months = 6;    

        return (nAmount / ( (1 / ( Math.pow((1 + nRate / 200), (1 / nPaymentsPer6Months ))  - 1) ) * (1 - Math.pow((1 + nRate / 200), (-nAmortMonths / nPaymentsPer6Months)) ) ) );     
}

function currencyString(nNumber) {
        nNumDec = 2;
        if (nNumber > 999999) nNumDec = 0;
        var str = "" + Math.round(nNumber * Math.pow(10,nNumDec));
        while (str.length <= nNumDec) {
                str = "0" + str;
        }
        var decpoint = str.length - nNumDec;
        var result = commaFmt(str.substring(0,decpoint) + "." + str.substring(decpoint,str.length));
        // var result = str.substring(0,decpoint) + "." + str.substring(decpoint,str.length);
        if (result.charAt(result.length - 1) == ".") result = result.substring(0, result.length - 1);
        return result;


}

function doCalcOnForm(form,n) {
        var bCMHCAlert = true;
        var nDownPayment = 0;
        var nFirstMortgage = 0;
        var nCMHCPremium = 0;
        var nTotalFinancing = 0;
        var nPayment = 0;
        var nExpenses = 0;
        var nTotal = 0;
        var nIncome = 0;
        if (checkForm(form,n)) {
                var nCounter = 0;
                for (nCounter = 1; nCounter <= 3; nCounter++) {
			// form[("percent_down" + nCounter)].value = (form[("down_payment" + nCounter)].value / form.io_price.value) * 100;

			dp = form[("down_payment" + nCounter)].value;
			dp = dp.replace(/^\$/, "").replace(/,/g, "");
			price = form.io_price.value;
			price = price.replace(/^\$/, "").replace(/,/g, "");

			// tmp = (parseFloat(form[("down_payment" + nCounter)].value) / parseFloat(form.io_price.value)) * 100;
			tmp = (parseFloat(dp) / parseFloat(price)) * 100;

			form[("percent_down" + nCounter)].value = Math.round(tmp*Math.pow(10,2))/Math.pow(10,2);

                        // calculate downpayment
                        nDownPayment = (filterNum(form.io_price.value)) * (Number(form[("percent_down" + nCounter)].value) / 100);
                        nFirstMortgage = (filterNum(form.io_price.value) - nDownPayment);
                        form[("first_mortgage" + nCounter)].value = currencyString(nFirstMortgage);
                        nCMHCPremium = (CMHCRate(Number(form[("percent_down" + nCounter)].value), form.io_amortization.options[form.io_amortization.selectedIndex].value)) * (nFirstMortgage) / 100;
                        form[("cmhc" + nCounter)].value = currencyString(nCMHCPremium);
                        nTotalFinancing = nFirstMortgage + nCMHCPremium;
                        form[("total_financing" + nCounter)].value = currencyString(nTotalFinancing);
                        nPayment = mortgagePayment(nTotalFinancing, Number(form.io_interest.value), (Number(form.io_amortization.options[form.io_amortization.selectedIndex].value)));
                        form[("monthly_payment" + nCounter)].value = currencyString(nPayment);
                        nExpenses = ( (Number(filterNum(form.io_heating.value)) + Number(filterNum(form.io_taxes.value)) ) /12 + Number(filterNum(form.io_condo.value))/12 );
                        form[("expenses" + nCounter)].value = currencyString(nExpenses);
                        nTotal = nExpenses + nPayment;
                        form[("total_payment" + nCounter)].value = currencyString(nTotal);
                        nIncome = nTotal * 12 / (Number(form.io_gds.value) / 100);
                        form[("income_required" + nCounter)].value = currencyString(nIncome);
                }
        } else {
                clearResults(form);
        }
}

//------------------------------------------------------------------------------

function formatRealNum(theNum,decplaces) {
// *** STOP USING THIS ***
// USE format_Real
// FORMAT A REAL NUMBER TO THE DESIRED DECIMAL PLACE
	var str = Math.round(parseFloat(filterNum(theNum.value)) * Math.pow(10,decplaces));
	str = ""+str;
	while (str.length <= decplaces) {
		str = "0" + str;
	}
	var decpoint = str.length - decplaces;
	return str.substring(0,decpoint) + "." + str.substring(decpoint,str.length);
}

//------------------------------------------------------------------------------

function formatInteger(theNum) {
// *** STOP USING THIS ***
// USE format_Integer
// FORMAT AN INTEGER
	var str = Math.round(parseFloat(filterNum(theNum.value)));
	str = ""+str;
	return str;
}

//------------------------------------------------------------------------------

function formatNum(theNum,decplaces,addcommas) {
// *** STOP USING THIS ***
// USE format_NUMBER
// FORMAT NUMERIC DATA

	var str = ""+theNum.value;
	if ((str == "") || (str == "null")) {
		theNum.value = "";
		return false;
	}
	if (decplaces == 0) {
		var fmtdnum = formatInteger(theNum,decplaces);
	} else {
		var fmtdnum = formatRealNum(theNum,decplaces);
	}
	if (addcommas) {
		fmtdnum = commaFmt(fmtdnum);
	}
	theNum.value = fmtdnum;
	return true
}

//------------------------------------------------------------------------------

function popupIsEmpty(theMenuObj) {
	var theSelection = theMenuObj.selectedIndex;
	if (theSelection <= 0) {
		return true;
	} else {
		return false;
    }
}

//------------------------------------------------------------------------------

function scrub_RollNum(theNum,otherAllowed,minWildcardPosition) {
// REMOVE ALL NON-NUMERIC CHARS EXCEPT FOR PROGRAMMER SPECIFIED 'OTHER' ALLOWABLE CHARS
	var result = "";
	var allowed = "";
	otherAllowed +="";
	if (otherAllowed == 'undefined')
		otherAllowed = "";
	allowed = "0123456789"+ otherAllowed;

	result = scrub_String(theNum,allowed);
	
	// remove commas from the end of the string
	for(i=result.length-1; i>=0; i--) {
		if(result.charAt(i) != ",")
			break;
		result = result.substring(0,i);
	}

	if (minWildcardPosition)
		result = parse_Wildcards (result,minWildcardPosition);

	return result;
}

//------------------------------------------------------------------------------

function scrub_String(theStr,charsAllowed,charsAllowedOnce) {
	// eliminate all unwanted chars
	var result = "";
	var specialCharAt = -1;
	var specialChar = "";
	for(i=0;i<=theStr.length;i++) {
		theChar = theStr.charAt(i);
		if (charsAllowed.indexOf(theChar) != -1)
 			result +=theChar;
 		else if (charsAllowedOnce){
 			specialCharAt = charsAllowedOnce.indexOf(theChar);
 		 	if (specialCharAt != -1) {
 				result += theChar;
 				// remove the char from the list so it will not be allowed
				charsAllowedOnce = charsAllowedOnce.substring(0,specialCharAt) 
					+ charsAllowedOnce.substring(specialCharAt+1,charsAllowedOnce.length);
// specialChar = charsAllowedOnce.charAt(specialCharAt-1);      
// charsAllowedOnce = charsAllowedOnce.replace(specialChar,""); 
 			}
 		}
	}
	return result;
}

//------------------------------------------------------------------------------

function filterNum(theNum) {
	var minusStr = "";
	var result = "";

	if (theNum.indexOf("-") != -1)
		minusStr = "-";

 	result = scrub_String(theNum,"0123456789",".")

 	if (result == "")
 		return "";
	else
		return minusStr + result;
}

//------------------------------------------------------------------------------

function commaFmt(numEle) {
	var tempStr = ""+numEle;
	
	// already has commas
	var charCheck = tempStr.indexOf(",");
	if ((charCheck+0) >= 0) {
		return numEle;
	}

	// separate the decimal from the whole number
	var decStr = "";
	var decInt = tempStr.indexOf(".");
	if (decInt!=-1) {
		decStr = tempStr.substring(decInt,tempStr.length);
		tempStr = tempStr.substring(0,decInt);
	}

	// if negative - save sign
	var isNeg = false;
	if (tempStr.indexOf("-")!=-1) {
		isNeg=true;
        tempStr=tempStr.substring(1,tempStr.length);
	}

	// short - no commas needed
	if (tempStr.length<=3) { 
		return numEle;
	}

	// add commas
	var newStr = "";
	var jInt = 0;
	for (var iInt=tempStr.length-1;iInt>=0;iInt--) {
		jInt++;
		newStr = tempStr.charAt(iInt) + newStr;
		if (jInt%3==0) {
			if (iInt-1>=0) {
				newStr = ","+newStr;
			}
		}
	}

	// re-assemble the parts
	if (decInt!=-1)
		newStr = newStr + decStr;
	if (isNeg)
		newStr = "-"+newStr;

	return newStr;
}

//------------------------------------------------------------------------------

function format_Real(theNum,decplaces) {
// FORMAT A REAL NUMBER TO THE DESIRED DECIMAL PLACE
	var str = filterNum(theNum);
	str = Math.round(parseFloat(str) * Math.pow(10,decplaces));
	str = ""+str;
	while (str.length <= decplaces) {
		str = "0" + str;
	}
	var decpoint = str.length - decplaces;
	return str.substring(0,decpoint) + "." + str.substring(decpoint,str.length);
}

//------------------------------------------------------------------------------

function format_Integer(theNum) {
// FORMAT AN INTEGER
	var str = filterNum(theNum);
	str = Math.round(parseFloat(str));
	return ""+str;
}

//------------------------------------------------------------------------------

function format_Number(theNum,decplaces,addcommas) {
// FORMAT NUMERIC DATA
	var str = ""+theNum;
	if ((str == "") || (str == "null"))
		return "";

	if (decplaces == 0)
		var fmtdnum = format_Integer(str,decplaces);
	else
		var fmtdnum = format_Real(str,decplaces);
		
	if (addcommas) 
		fmtdnum = commaFmt(fmtdnum);
//	if (isNaN(fmtdnum))
//		return ""; 
	return fmtdnum;
}

//------------------------------------------------------------------------------

function validateNum(theNum,decplaces,min,max,addcommas) {
// VALIDATE & FORMAT USER INUPT
	var str = filterNum(theNum.value);
	
	if ((str == "") || (str == "null")) {
		theNum.value = "";
		return false;
	}
	var tmpFloat = parseFloat(filterNum(theNum.value));
	
	if (tmpFloat < min || tmpFloat > max) {
		alert("Please enter a number between " + min + " and " + max + ".");
		theNum.value = "";
		theNum.focus();
		return false;
	}
	if (decplaces == 0) {
		var fmtdnum = formatInteger(theNum,decplaces);
	} else {
		var fmtdnum = formatRealNum(theNum,decplaces);
	}
	if (addcommas) {
		fmtdnum = commaFmt(fmtdnum);
	}
	theNum.value = fmtdnum;
	return true
}

//------------------------------------------------------------------------------

function validatePrice(theNum,min,max,addcommas) {
// VALIDATE & FORMAT USER INUPT
	var str = filterNum(theNum.value);
	if ((str == "") || (str == "null")) {
		theNum.value = "";
		return false;
	}
	var tmpFloat = parseFloat(filterNum(theNum.value));
	
	if (tmpFloat < min || tmpFloat > max) {
		$("#io_price").css("background-color","rgb(255, 199, 199)");
		alert("Please enter a number between " + min + " and " + max + ".");
		theNum.value = "";
		theNum.focus();
		return false;
	}
	
	$("#io_price").css("background-color","white");
	if (tmpFloat < 100) {
		decplaces = 2;
	} else {
		decplaces = 0;
	}
	
	if (decplaces == 0) {
		var fmtdnum = formatInteger(theNum,decplaces);
	} else {
		var fmtdnum = formatRealNum(theNum,decplaces);
	}
	if (addcommas) {
		fmtdnum = commaFmt(fmtdnum);
	}
	theNum.value = fmtdnum;
	return true
}

//------------------------------------------------------------------------------

// SUBMIT VALIDATION

//------------------------------------------------------------------------------

function str_Empty (theFormObj){
	if (theFormObj.value+"" == "null")
		return true;
	else if (theFormObj.value == "")
		return true;
	return false;
}

//------------------------------------------------------------------------------

function popup_Empty(theMenuObj) {
	var theSelection = theMenuObj.selectedIndex;
	if (theSelection == -1)
		return true;
	else if (theMenuObj.options[theSelection].value == '')
		return true;
	else
		return false;
}

//------------------------------------------------------------------------------

function field_Empty (theFormObj){
	if (!theFormObj) {
		//alert("Please report this to systems support.\nUNKOWN FORM OBJECT"+theFormObj);
		//return false;
		return false;
	}
//	alert("field_Empty: " + theFormObj.name + " / " + theFormObj.type);
	var theType = theFormObj.type;
	if (theType.indexOf('select') != -1)
		return popup_Empty(theFormObj)
	else
		return str_Empty (theFormObj)
}

//------------------------------------------------------------------------------

function list_Empty(theMenuObj) {
	var isEmpty = true;
	for(i=1;i<theMenuObj.length;i++) {
		if (theMenuObj.options[i].selected)
			isEmpty = false;
	}
	return isEmpty;
}

//------------------------------------------------------------------------------

function numberRange_OK(fromNumObj,toNumObj)
{
	if (fromNumObj.value == "" || toNumObj.value == "")
		return true;
		
	var tmpFromFloat = parseFloat(filterNum(fromNumObj.value));
	var tmpToFloat = parseFloat(filterNum(toNumObj.value));
	if (tmpToFloat < tmpFromFloat) {
		alert(toNumObj.name+"  is greater than  "+toNumObj.name+"   Please re-enter");
		fromNumObj.value = "";
		toNumObj.value = "";
		fromNumObj.focus();
		return false;
	}
	return true;
}

//------------------------------------------------------------------------------

function wildcard_Alert () {
	alert('Wildcard Search Enabled\n  "?" - Searches for any single character.\n'
		+ '  "*" - Searches for any characters of any length.');
}

//------------------------------------------------------------------------------

function scrub_multi_value_field(fieldContents,minWildcardPosition) {
// Scrub fields that allow for multiple comma delimited values for queries
	var result = "";
	if (fieldContents == "" || fieldContents=='undefined')
		return "";
	if (minWildcardPosition == "" || minWildcardPosition=='undefined')
		minWildcardPosition = 0;

	fieldContents = scrub_Text (fieldContents,true);
	if (fieldContents.indexOf(",") == -1) {
			result = parse_Wildcards (fieldContents,minWildcardPosition);
	}
	else {
		var fieldContents_Array = fieldContents.split(",");
	
		for(var sc_x=0;sc_x < fieldContents_Array.length; sc_x++) {
	  		if (fieldContents_Array[sc_x] == "") 
	  			continue;
	  		if(fieldContents_Array[sc_x].charAt(0) == " ")
				fieldContents_Array[sc_x] = fieldContents_Array[sc_x].substring(1,fieldContents_Array[sc_x].length);
	  		if(fieldContents_Array[sc_x].charAt(fieldContents_Array[sc_x].length - 1) == " ")
				fieldContents_Array[sc_x] = fieldContents_Array[sc_x].substring(0,fieldContents_Array[sc_x].length - 1);
			result = result + parse_Wildcards (fieldContents_Array[sc_x],minWildcardPosition);
			result = result + ",";
		}
		// remove commas from the end of the string
		for(sc_i=result.length-1; sc_i>=0; sc_i--) {
			if(result.charAt(sc_i) != ",")
				break;
			result = result.substring(0,sc_i);
		}
	}
	return result;
}

//------------------------------------------------------------------------------

// onChange='return scrub_select_mult(this, 5);' //
function scrub_select_mult(elem, maxn) { 
	var valid = true;
	var cnt = 0;
	for (var i=0; i<elem.options.length; i++) {
		if (valid) {
			if (elem.options[i].selected) { 
				cnt ++;
				if (cnt > maxn) { 
					valid = false;
					alert("You can select only " + maxn + " items in the list"); 
					elem.options[i].selected = false; 
				}
			}
		} else {
			elem.options[i].selected = false; 
		}
	}
	return valid; 
}

//------------------------------------------------------------------------------

// Postal Code Check and Scrub space
function checkPostal(theObject,removeSpace) {
	var a = theObject.value;
	var b = "";
	var u = "";
	var numString="1234567890";
	var failed = false;

	a = scrub_Text(a,true);
	a = scrub_String_Unwanted(a," ");
	if (a.length < 1)
		return true;
		
	for(i=0;i<=5;i++) {
		var u = a.charAt(i);
		
		if (i==1||i==3||i==5) {
			if (!isNum(u)) 
				failed=true;
		} 
		else {
			if (isChar(u)) 
				u=u.toUpperCase();
			else 
				failed=true;
		}
		var b = b + u;
	}
	if (!removeSpace)
	  b = b.substring(0,3)+" "+b.substring(3,6);

	theObject.value = b;

	return !(failed);
}

//------------------------------------------------------------------------------

function isNum(inString)  {
	if(inString.length!=1) 
		return false;
	var refString="1234567890";
	if (refString.indexOf(inString,0) == -1) 
		return false;
	return true;
}

//------------------------------------------------------------------------------

function isChar(inString)  {
	if(inString.length!=1) 
		return false;
	var refString="abcdefghijklmnopqrstuvwxyzABCEDFGHIJKLMNOPQRSTUVWXYZ";
	if (refString.indexOf(inString,0) == -1) 
		return false;
	return true;
}

//------------------------------------------------------------------------------

// USED FUNCTIONS

//------------------------------------------------------------------------------

function replace_Char (unwantedChar,wantedChar,theStr) {
	while ((x=theStr.indexOf(unwantedChar)) != -1) {
		theStr = theStr.substring(0,x) + wantedChar 
			+ theStr.substring(x+unwantedChar.length,theStr.length);
	}	
	return theStr;
}

//------------------------------------------------------------------------------

function scrub_String_Unwanted(theStr,charsUnwanted) {
	// eliminate all unwanted chars
	var result = "";
	var theChar = "";
	var ok = true;
	var i = 0;
	for(i=0;i<=theStr.length;i++) {
		theChar = theStr.charAt(i);
		if (theChar == '"') // really bad ones
			result += "`"
		else if (theChar == "'")
			result += "`"
//		else if (theChar == "`")
//			theChar = ""
		else if (charsUnwanted.indexOf(theChar) == -1)
 			result += theChar;
	}
	return result;
}

//------------------------------------------------------------------------------

function parse_Wildcards (theStr,minWildcardPosition) {
	theStr = scrub_String_Unwanted(theStr,"%_");
	if (minWildcardPosition == 0) {
		if (theStr.indexOf("*") != -1 || theStr.indexOf("?") != -1 ) {
			alert("Wildcards are not allowed in this field.");
			theStr = replace_Char("*","",theStr);
			theStr = replace_Char("?","",theStr);
		}
	} else {
		var tmpStr = theStr.substring(0,minWildcardPosition);
		if (tmpStr.indexOf("*") != -1 || tmpStr.indexOf("?") != -1 ) {
			alert("A wildcard can only be used after character " + minWildcardPosition 
				+ " in this field.");
			theStr = replace_Char("*","",theStr);
			theStr = replace_Char("?","",theStr);
		} else {
			var x = theStr.indexOf("*");
			if (x != -1) {
				tmpStr = theStr.substring(x+1,theStr.length);
				if (tmpStr.indexOf("*") != -1 ) {
					alert("Only one * wildcard is allowed in this field.");
					theStr = replace_Char("*","",theStr);
					theStr = replace_Char("?","",theStr);
				}
			}
		}
	}
	return theStr;
}

//------------------------------------------------------------------------------

function scrub_Text (theStr,makeUpper,minWildcardPosition,allowQuotes) {
// strip spaces off ends of string
	theStr += "";
	if (theStr == "null" || theStr == "")
		return "";
	for(var i=0; i<theStr.length; i++) {
		if(theStr.charAt(0) != " ")
			break;
		theStr = theStr.substring(1,theStr.length);
	}
	for(i=theStr.length-1; i>=0; i--) {
		if(theStr.charAt(i) != " ")
			break;
		theStr = theStr.substring(0,i);
	}

	var perc = "";
	if (makeUpper) {
		theStr = theStr.toUpperCase();
		perc = "%_";
	}
	if (allowQuotes != 'true')
		theStr = scrub_String_Unwanted(theStr,perc);

	if (minWildcardPosition && minWildcardPosition > '')
		theStr = parse_Wildcards (theStr,minWildcardPosition);

	return theStr;
}

//------------------------------------------------------------------------------

// Date & Time Entry and Formating
// ANK - May, 1999

//------------------------------------------------------------------------------

function format_date(d) {
	if (!d.getTime())  return "Invalid Date";
	var y = d.getFullYear();
	var m = d.toString().substring(4,7);
	var a = d.getDate(); 
	return a + "-" + m.toUpperCase() + "-" + y;
//	return m + " " + a + ", " + y;
}

//------------------------------------------------------------------------------

function format_time(d) {
	if (!d.getTime())  return "Invalid Time";
	var h = d.getHours();    h = (h<10)?("0"+h):(""+h);
	var m = d.getMinutes();  m = (m<10)?("0"+m):(""+m);
	var s = d.getSeconds();  s = (s<10)?("0"+s):(""+s);
	return h + ":" + m + ":" + s;
}

//------------------------------------------------------------------------------

/*
function join_date(date, time, type, def_date) {
	if ((!date)&&(!time)) return "";

	if (!date) { 
		var d;
		if (def_date) d = new Date(def_date);
			else      d = new Date(); 
		date = format_date(d); 
	}
	if (!time) {
		switch (type) {
			case "start":   time = "00:00:00"; break;
			case "end":     time = "23:59:59"; break;
		    case "current": time = format_time(new Date()); break;
		    case "default": time = format_time(new Date(def_date)); break;
		    default:        return "";
		}
	}
	return date + "  " + time;
}
*/

//------------------------------------------------------------------------------

function scrub_Date(theStr, def_date) {
	var str = String(theStr);
	if ((!str)||(str == "")) { return ""; }

	var p;
	while((p=str.indexOf("-")) >= 0)
		str = str.substring(0,p) + " " + str.substring(p+1,str.length);

	var c;
	if (def_date) c = new Date(def_date);
		else      c = new Date();
	var d = new Date(str);
	if (!d.getTime()) { d = new Date(str + " " + c.getFullYear()); }
	if (!d.getTime()) {	d = new Date((c.getMonth()+1) + "/" + str + " " + c.getFullYear()); }
	if (!d.getTime()) { return ""; }
    var x = c.getFullYear();
	var y = d.getFullYear();
	if (y < x-10) { d.setFullYear(x-10); }
	if (y > x+10) { d.setFullYear(x+10); }
	return format_date(d);
}

//------------------------------------------------------------------------------

function date_format_help() {
    alert('Date: \n \n'
		+ 'Please use one of the following formats:\n'
		+ '"31-MAY-1999" or\n'
		+ '"May 31 1999", "05/31/1999", "May 31", "31"');
}

//------------------------------------------------------------------------------

function scrub_Time(theStr) {
	var str = String(theStr);
	if ((!str)||(str == "")) { return ""; }
	
	var p, pm="";
	str = str.toUpperCase();
	if ((p=str.indexOf("PM")) >= 0) { pm = "PM"; str = str.substring(0,p); }
	if ((p=str.indexOf("AM")) >= 0) { pm = "AM"; str = str.substring(0,p); }

	while((p=str.indexOf(" :")) >= 0)
		str = str.substring(0,p) + str.substring(p+1,str.length);
	while(str.charAt(str.length-1) == " ")
		str = str.substring(0,str.length-1);

	var d = new Date("Jan 1, 1970 " + str + " " + pm);
	if (!d.getTime()) { d = new Date("1/1/1970 " + str + ":00" + " " + pm); }
	if (d.getTime()) {
		if ((pm=="AM") && (d.getHours()==12)) d.setHours(0);
		if ((pm=="PM") && (d.getHours()==0)) d.setHours(12);
		return format_time(d);
	} else {
		alert("Invalid time: " + theStr +"\n \n"
			+ "Please use one of the following formats:\n"
			+ "14:15:00,  14:15,  14  or  2 PM");
		return "";
	}
}

//------------------------------------------------------------------------------
//------ New style Functions ---------------------------------------------------
//------------------------------------------------------------------------------

function _not_ready(elem, msg) {
	elem.form._relem = elem;
	elem.form._ready = false;
	setTimeout("alert('" + msg + "');", 1);
}

//------------------------------------------------------------------------------

function try_to_submit(fm) {
	for (var i=0; i<fm.length; i++) {
		if (fm.elements[i].blur) { 
			fm.elements[i].blur(); // triggers onChange() before submit() (for IE)
		} 
	}
	if (!fm._ready) {
		fm._relem.focus();
		return;
	}
	fm.submit();
}

//------------------------------------------------------------------------------

function scrubDate(elem) {
	var x = scrub_Date(elem.value);
	if (x == '' && elem.value != '') {
		_not_ready(elem, 'Invalid date format: "' + elem.value +'"\\n \\n'
			+ 'Please use one of the following formats:\\n'
			+ '"31-MAY-1999" or\\n'
			+ '"May 31 1999", "05/31/1999", "May 31", "31"');
	}
	elem.value = x;
}

//------------------------------------------------------------------------------

function scrubText(elem) {
	elem.value = scrub_Text(elem.value,false);
}

//------------------------------------------------------------------------------

function scrubUpperText(elem) {
	elem.value = scrub_Text(elem.value,true);
}

//------------------------------------------------------------------------------
    
function scrubLongText(elem, numb) {
    numb = Number(numb);
	var res = scrub_Text(elem.value, false);
	if (res.length > numb) { 
		res = res.substring(0,numb); 
		_not_ready(elem, 'The text was longer than '+ numb +' characters. It has been truncated.'); 
	}
    elem.value = res;
}

//------------------------------------------------------------------------------


