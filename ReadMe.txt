Impact will add two fields to the Item Card, a button to start the lot size calculation and two columns to the Production BOM:

Item card fields:
•	MOISTURE GAIN PERCENTAGE (“MG%”)
	This field will hold a decimal value (0.055 in this field = 5.5%).
	This field will be used to store the moisture GAINED in baking for a given item.
	This field will be available for all Items, but it should only be populated for finished good items and not raw material items. 
•	PLANNING SCRAP PERCENTAGE (“PS%”) 
	This field will hold a decimal value related to the scrap factor (0.055 in this field = 5.5%).
	Impact cannot use the native scrap fields as they will increase components to cover the scrap and impact production.
	This field will be available for all Items, but it should only be populated for finished good items and not raw material items. 
Process:
o	When a raw material item is added to a Production BOM Darlington will enter the items Qty per value in column(A) and the item’s ML% in custom column(B) 
o	Column(B) will be used with the Qty Per column(A) to calculate the item weight after moisture loss in a second custom column(C). 	 C= A-(A*B) 
o	Column C will then be totaled and stored as a variable (X).	X=Sum(C)
o	On the finished good item card (X) will be used with the MG% value(M) to calculate the batch weight (Z). 	Z =X+(X*M)
o	The item weight(W) will be entered by Darlington using the weight field on the item Unit of Measure.
o	The batch weight(Z) will be divided by the item weight(W) to give the Yield(Y). 	     Y=Z/W 
o	Finally, the PS% value(S) will be added to Yield(Y) to give the lot size(F).		 F=Y+(S*Y) 
o	Lot size field will be populated with value(F) and can then be used for planning. 
o	A button on the item card will be used to trigger this calculation and repopulate the lot size field 
	Any change to the BOM ML% value/values will require that Darlington press the calculation button.


BOM Calculations Example

	            Column(A)		    Column(B)	    Column(C)
                Qty Per	      UoM	   ML %	        lbs. after ML
Flower 	        1000	      lbs.	   0.11	        890
sugar 	        500	          lbs.	   0.08	        460	
lemon extract 	10	          lbs.	   0.005	    9.95	
yeast 	        2	          lbs.	   0.04	        1.92	
water 	        40	          lbs.     0.2	        32	
				                                    1393.87	 = X


Item Card Calculations Example

MG %	        0.05	     = M    Case Yield 	78.05672	 = Y
Batch Weight	1463.5635	 = Z	PS%	        0.1	         = S
Item Weight	    18.75	     = W	Lot Size	85.862392	 = F

