  
    <cfset theDay=Now()>
     
    <!---Getting/Creating today--->
    <cfset Today=CreateDate(Year(theDay),Month(theDay),Day(theDay))>
    
    <!---#Today# in to int--->
    <cfset dt_Today = Fix(#Today#)>
    
    <!---Getting Last day of this month--->
    <cfset LastDayOfThisMonth = DATEADD("d",-(DAY(DATEADD("m",1,Now()))),DATEADD("m",1,Now()))>
    
    <!---Creating Last Day Of This Month(LDOTM) to the same format---->
    <cfset LDOTM = CreateDate(Year(#LastDayOfThisMonth#),Month(#LastDayOfThisMonth#),Day(#LastDayOfThisMonth#))>
    
    <!---LDOTM in ton int---->
    <cfset dt_LDOTM = Fix(#LDOTM#)>
    
        <!---Checking LDOTH is a weekend--->
    <cfswitch expression="#DayOfWeekAsString(DayOfWeek(LDOTM))#">
        <cfcase value="SATURDAY">
        	<!---Getting the last weekday of the week(Friday)--->
            <cfset LastWeekDay = DateAdd("d",-1,#LDOTM#)> 
        </cfcase>
            <cfcase value="SUNDAY">
        	<!---Getting the last weekday of the week(Friday)--->
            <cfset LastWeekDay = DateAdd("d",-2,#LDOTM#)> 
        </cfcase>
        <cfdefaultcase>
        	<cfset LastWeekDay = #LDOTM#>
        </cfdefaultcase>
        
    </cfswitch>
    
    <!---LastWeekDay in to int--->
    <cfset dt_LastWeekDay = Fix(LastWeekDay)>
    
    <!---Getting Company Holidays for this month----->
    <cfquery name="CompanyHolidays" datasource="yourdatasource">
        SELECT TO_DATE 
        FROM yourTable
        WHERE PTO_CODE='9' 
            AND MONTH(TO_DATE)='#MONTH(Today)#' 
            AND YEAR(TO_DATE)='#YEAR(Today)#'
        ORDER BY TO_DATE DESC
    </cfquery>
    
    <!---Looping thru Company holidays to make sure LastWeekDay is not a Company Holiday----->
    <cfloop query="CompanyHolidays">
    
        <!---Company Holidays in to int--->
		<cfset dt_CompanyHoliday = Fix(#CompanyHolidays.TO_DATE#)> 
        
        <!---Checking the NextDay is a Company Holiday---->
        <cfIF #dt_LastWeekDay# IS #dt_CompanyHoliday#>
            <cfset #dt_LastWeekDay# = #dt_LastWeekDay# - 1>
        <cfELSE>
            <!---Do nothing---->    
        </cfIF>
        
    </cfloop>    
    
    <!---After all checking whether, today is last business day of the month, which is also not a Company holiday--->
    
    <CFIF #dt_Today# IS #dt_LastWeekDay#>
    	
    	<!--------Last Business Day of the month reminder window--------------->
    
            <cfwindow 
                closable="true"
                draggable="true" 
                height="100" 
                name="myWindow"
                resizable="true"
                title=" -----LAST BUSINESS DAY OF THE MONTH REMINDER----- "
                width="400"
                x="275"
                y="300"
                initshow="true"
                modal="true"
            >
                <b>REMINDER</b>. Today is the last business day of the month.
                
            </cfwindow>    
        
    <CFELSE>
    	<!---Do nothing, i.e. Today is not the last business day of the month, so no pop up--->
    </CFIF>
